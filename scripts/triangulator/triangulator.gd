class_name Triangulator
extends Area2D

var target : Objective
var current_target : String
var detection_area : TriangleDetection
var is_picked_up : bool = false
var acceleration : float =  0.2

@export var hold_distance: float = 72.0


var player : Player:
	get():
		if !player:
			player = get_tree().get_root().find_child("Player", true, false)
		return player


@export var mouse_move : bool = false


func _init() -> void:
	add_to_group("triangulators")


func _ready() -> void:
	current_target = "first" #TODO: remove this when we add the target menu
	detection_area = get_tree().get_first_node_in_group("detection_area")


func _physics_process(_delta: float) -> void:
	if is_picked_up:
		move()


func change_target(target_string : String) -> void:
	current_target = target_string


func move() -> void:
	var target_position : Vector2 = player.global_position + (hold_distance * player.last_facing_direction)
	global_position = lerp(global_position, target_position, acceleration)
	detection_area.update_polygon()


func pick_up() -> void:
	is_picked_up = true


func drop() -> void:
	is_picked_up = false
