class_name PlayerAnimation
extends Node

@export var animation_tree : AnimationTree

@onready var player : Player = get_owner()

var last_facing_direction := Vector2.RIGHT

func _ready() -> void:
	animation_tree.active = true


func _physics_process(delta: float) -> void:
	if !player:
		return
		
	if player.velocity:
		last_facing_direction = player.velocity.normalized()
		
	
	animation_tree.set("parameters/idle/blend_position", last_facing_direction)
	animation_tree.set("parameters/move/blend_position", last_facing_direction)
	
