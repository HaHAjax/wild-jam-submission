class_name Projectile
extends CharacterBody2D

var max_speed : float = 400.0
var direction : Vector2
var lifetime : float = 5.0

@export var sprite : Sprite2D


var player : Player:
	get():
		if !player:
			player = get_tree().get_first_node_in_group("player")
		return player


func _ready() -> void:
	if player:
		global_position = player.aim_position
		direction = player.aim_direction


func _physics_process(_delta: float) -> void:
	# TODO: acceleration 
	velocity = max_speed * direction
	move_and_slide()
	
	sprite.rotation_degrees += 5
	


func explode() -> void:
	queue_free()
