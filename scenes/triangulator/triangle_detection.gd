class_name TriangleDetection
extends Area2D

var triangulators : Array[Triangulator]

@export var collision : CollisionPolygon2D

func _ready() -> void:
	for tri : Triangulator in get_tree().get_nodes_in_group("triangulators"):
		triangulators.append(tri)
	
	update_polygon()


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
		detected.append(item.owner)
	
	print(detected)
		
	
