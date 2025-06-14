class_name PlayerUI
extends CanvasLayer


@export var label : Label


func _init() -> void:
	add_to_group("player_ui")


func update_label(p_number : int) -> void:
	label.text = str(p_number)
