extends Node

var terrain_top: Terrain = null
var terrain_bottom: Terrain = null
var player: Player = null


func _ready() -> void:
	find_all_nodes()


func find_all_nodes() -> void:
	terrain_top = get_tree().get_root().find_child("TopTerrain", true, false)
	terrain_bottom = get_tree().get_root().find_child("BottomTerrain", true, false)
	player = get_tree().get_root().find_child("Player", true, false)
