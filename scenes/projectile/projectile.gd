class_name Projectile
extends CharacterBody2D

var max_speed := 400.0
var direction : Vector2
var lifetime := 5.0

var player : Player:
	get():
		if !player:
			player = get_tree().get_first_node_in_group("player")
		return player


func _ready() -> void:
	if player:
		global_position = player.global_position
		direction = player.last_facing_direction.normalized()


func _physics_process(delta: float) -> void:
	# TODO: acceleration 
	velocity = max_speed * direction
	move_and_slide()
	


func explode() -> void:
	queue_free()
