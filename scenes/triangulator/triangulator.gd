class_name Triangulator
extends Node2D

var target : Objective


func _init() -> void:
	add_to_group("triangulator")


func _physics_process(_delta: float) -> void:
	target = get_closest_objective()
	print(target)


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
	
