class_name TriangleDetection
extends Area2D

var triangulators : Array[Triangulator]
var player_ui : PlayerUI:
	get():
		if !player_ui:
			player_ui = get_tree().get_first_node_in_group("player_ui")
		return player_ui
	
var number_of_objects : int:
	set(val):
		number_of_objects = val
		player_ui.update_label(number_of_objects)


@export var collision : CollisionPolygon2D

func _init() -> void:
	add_to_group("triangle_area") # TODO: rename this?

func _ready() -> void:
	for tri : Triangulator in get_tree().get_nodes_in_group("triangulators"):
		triangulators.append(tri)


func _physics_process(delta: float) -> void:
	detect_objects()


func update_polygon() -> void:
	var polygon_array : Array[Vector2]
	
	for tri : Triangulator in triangulators:
		polygon_array.append(tri.global_position)
	
	collision.polygon = polygon_array


func detect_objects() -> void:
	var detected : Array
	
	for item : Area2D in get_overlapping_areas():
		if item.owner is Objective:
			detected.append(item.owner)
	
	number_of_objects = detected.size()
		
	
