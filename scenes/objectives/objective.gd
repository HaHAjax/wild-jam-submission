@tool
class_name Objective
extends Node2D

@export var object: ScanObject

var objective_name: String
var objective_sprite: Texture2D
var objective_shape: Shape2D

@onready var node_sprite: Sprite2D = %Sprite2D
@onready var node_collision: CollisionShape2D = %CollisionShape2D


func _init() -> void:
	add_to_group("objectives")


func _process(_delta: float) -> void:
	if objective_name != object.name: objective_name = object.name
	if objective_sprite != object.sprite: objective_sprite = object.sprite
	if objective_shape != object.shape: objective_shape = object.shape
