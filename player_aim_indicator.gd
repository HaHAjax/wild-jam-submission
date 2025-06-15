class_name PlayerAim
extends Sprite2D


@onready var player : Player = get_owner()
var aim_offset : float = 24.0

func update_position() -> void:
	global_position = player.aim_position
	rotation = player.aim_position.angle()
