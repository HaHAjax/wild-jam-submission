class_name Player
extends CharacterBody2D

# initial player stats
const _INIT_PLAYER_STATE: PlayerStates = PlayerStates.IDLE
const _INIT_MOVE_SPEED: float = 12500.0
const _INIT_TRI_PLACE_SPEED: float = 2.0

# player stats
@export_group("Generic Stats")
@export var move_speed: float = _INIT_MOVE_SPEED
@export_group("Equipment Stats")
@export var tri_place_speed: float = _INIT_TRI_PLACE_SPEED

@onready var interact_area : Area2D = %InteractArea


# player states enum
enum PlayerStates {
	IDLE = 0,
	MOVING,
	PLACING_TRI,
	DEAD
}

# player state variables
## The current player state. [br]
## Updates every physics tick.
@onready var curr_player_state: PlayerStates = _INIT_PLAYER_STATE
## The previous player state as of the previous physics tick. [br]
## Updates at the start of every physics tick.
@onready var prev_player_state: PlayerStates = _INIT_PLAYER_STATE

# input variables
var input_move_dir: Vector2 = Vector2.ZERO
var using_controller : bool

# helper variables?
var held_object : Triangulator #TODO: change this if we are able to hold other things
var last_facing_direction : Vector2 = Vector2.RIGHT

# Aiming Variables
@onready var aim_indicator : PlayerAim = %PlayerAimIndicator
var last_moving_direction : Vector2 = Vector2.RIGHT
var aim_direction : Vector2 = Vector2.RIGHT
var aim_position : Vector2 = Vector2.RIGHT:
	set(val):
		aim_position = val
		aim_indicator.update_position()

# explosion stuff for bombs
var explosion_tier: int = 0
var explosion_size: float = 0.0


func _init() -> void:
	add_to_group("player")


func _ready() -> void:
	explosion_tier = ProgressManager.curr_explosive_tier
	explosion_size = (explosion_tier * 5) + 15


func _process(_delta: float) -> void:
	pass


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		using_controller = false
	elif event is InputEventJoypadMotion:
		using_controller = true


func _physics_process(delta: float) -> void:
	_movement_stuff(delta)
	_aim_process(delta)
	
	if Input.is_action_just_pressed("interact"):
		interact()


func interact() -> void:
	# TODO: priority system if we have more than one thing in area
	if !held_object:
		var thing : Area2D
		
		if !interact_area.get_overlapping_areas().is_empty():
			thing = interact_area.get_overlapping_areas()[0]
			
			if thing is Triangulator:
				held_object = thing as Triangulator
				held_object.pick_up()
	
	else:
		held_object.drop()
		held_object = null


func _aim_process(_delta : float) -> void:
	if velocity:
		last_moving_direction = velocity.normalized()
		
	if using_controller:
		var input_direction : Vector2 = Input.get_vector("right_joy_left", "right_joy_right", "right_joy_up", "right_joy_down")
		
		if input_direction:
			aim_direction = input_direction.normalized()
		else:
			aim_direction = last_moving_direction
	
	else:
		aim_direction = (get_global_mouse_position() - global_position).normalized()
		
	aim_position = global_position + aim_direction * 24.0


func change_explosion_tier(new_tier: int) -> void:
	if new_tier > ProgressManager.MAX_EXPLOSIVE_TIER: return
	
	explosion_tier = new_tier
	explosion_size = (explosion_tier * 5) + 15


func increase_explosion_tier() -> void:
	if explosion_tier + 1 > ProgressManager.MAX_EXPLOSIVE_TIER: return
	
	explosion_tier += 1
	explosion_size = (explosion_tier * 5) + 15
	print(explosion_size)


func _movement_stuff(delta: float) -> void:
	input_move_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if input_move_dir:
		last_facing_direction = input_move_dir
	
	velocity = input_move_dir * move_speed * delta
	
	move_and_slide()
