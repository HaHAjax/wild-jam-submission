class_name Player
extends CharacterBody2D

# initial player stats
const _INIT_PLAYER_STATE: PlayerStates = PlayerStates.IDLE
const _INIT_MOVE_SPEED: float = 100.0
const _INIT_TRI_PLACE_SPEED: float = 2.0

# player stats
@export_group("Generic Stats")
@export var move_speed: float = _INIT_MOVE_SPEED
@export_group("Equipment Stats")
@export var tri_place_speed: float = _INIT_TRI_PLACE_SPEED

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


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	pass
