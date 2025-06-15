class_name PlayerProjectile
extends Node

@export var projectile_scene : PackedScene

@onready var player : Player = get_owner()

var on_cooldown : bool = false
var cooldown : float = 1.0
var remaining_cooldown : float = 0.0

func _physics_process(delta: float) -> void:
	
	if on_cooldown:
		remaining_cooldown -= delta
		if remaining_cooldown <= 0.0:
			on_cooldown = false
	
	if Input.is_action_just_pressed("secondary_fire"):
		var proj : Projectile = projectile_scene.instantiate()
		get_tree().current_scene.add_child(proj)
