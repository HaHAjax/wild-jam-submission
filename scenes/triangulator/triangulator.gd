class_name Triangulator
extends Node2D

var target : Objective
var current_target : String

func _init() -> void:
	add_to_group("triangulator")


func _ready() -> void:
	current_target = "first" #TODO: remove this when we add the target menu


func _physics_process(_delta: float) -> void:
	print(get_distance_to_objective())


func change_target(target_string : String) -> void:
	current_target = target_string


func get_distance_to_objective() -> float:
	var target : Objective = get_tree().get_first_node_in_group(current_target)
	var dist : float = global_position.distance_to(target.global_position)
	
	return dist


# TODO: remove if we don't use this function
func get_closest_objective() -> Objective:
	
	var objectives : Array[Objective]
	
	for object in get_tree().get_nodes_in_group("objectives"):
		objectives.append(object)
	
	if objectives.is_empty():
		return
		
	var closest : Objective = objectives[0]
	
	for object in objectives:
		if global_position.distance_to(object.global_position) < global_position.distance_to(closest.global_position):
			closest = object
	
	return closest
	
