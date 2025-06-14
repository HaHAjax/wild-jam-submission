class_name Triangulator
extends Node2D

var target : Objective
var current_target : String
var triangle_area : TriangleDetection

@export var mouse_move := false

func _init() -> void:
	add_to_group("triangulators")


func _ready() -> void:
	current_target = "first" #TODO: remove this when we add the target menu
	triangle_area = get_tree().get_first_node_in_group("triangle_area")


func _physics_process(_delta: float) -> void:
	
	if mouse_move:
		global_position = get_global_mouse_position()
		triangle_area.update_polygon()


func change_target(target_string : String) -> void:
	current_target = target_string

# TODO: remove if we don't use this function
func get_distance_to_objective() -> float:
	var p_target : Objective = get_tree().get_first_node_in_group(current_target)
	var dist : float = global_position.distance_to(p_target.global_position)
	
	return dist


# TODO: remove if we don't use this function
func get_closest_objective() -> Objective:
	
	var objectives : Array[Objective]
	
	for obj : Objective in get_tree().get_nodes_in_group("objectives"):
		objectives.append(obj)
	
	if objectives.is_empty():
		return
		
	var closest : Objective = objectives[0]
	
	for obj : Objective in objectives:
		if global_position.distance_to(obj.global_position) < global_position.distance_to(closest.global_position):
			closest = obj
	
	return closest
	
