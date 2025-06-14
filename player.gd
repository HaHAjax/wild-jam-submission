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

# helper variables?
var held_object : Triangulator #TODO: change this if we are able to hold other things
var last_facing_direction : Vector2


func _init() -> void:
	add_to_group("player")


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	_movement_stuff(delta)
	
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


func _movement_stuff(delta: float) -> void:
	input_move_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if input_move_dir:
		last_facing_direction = input_move_dir
	
	velocity = input_move_dir * move_speed * delta
	
	move_and_slide()
