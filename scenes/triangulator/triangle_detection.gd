class_name TriangleDetection
extends Area2D

var triangulators : Array[Triangulator]

@export var collision : CollisionPolygon2D

func _ready() -> void:
	for tri : Triangulator in get_tree().get_nodes_in_group("triangulators"):
		triangulators.append(tri)
	
	update_polygon()


func update_polygon() -> void:
	var polygon_array : Array[Vector2]
	
	for tri : Triangulator in triangulators:
		polygon_array.append(tri.global_position)
	
	collision.polygon = polygon_array
	
	# TODO: must be called after objectives are spawned
	print("a", get_overlapping_areas())
