extends Node
## Holds an instance for any necessary nodes in the scene tree.
## 
## This autoload holds the scene tree instance (as a variable)
## for any nodes that we want to use in other scripts. [br]
## This is used for easy access to any node needed for any script,
## without the need to get the instance on every script that uses it
## (instead, we only get it once).


static var terrain_top: Terrain = null ## The [Terrain] instance that holds the top terrain layer.
static var terrain_bottom: Terrain = null ## The [Terrain] instance that holds the bottom terrain layer.
static var player: Player = null ## The [Player] scene instance.


func _ready() -> void:
	find_all_nodes()


## Finds all nodes that are available within this script. [br]
## [b]THIS IS [i]SLOW[/i], DO NOT USE UNLESS ABSOLUTELY NECESSARY[b]
func find_all_nodes() -> void:
	terrain_top = get_tree().get_root().find_child("TopTerrain", true, false)
	terrain_bottom = get_tree().get_root().find_child("BottomTerrain", true, false)
	player = get_tree().get_root().find_child("Player", true, false)


## Finds and sets the corresponding variable from the given [param node_to_find]. [br]
## [param node_to_find] MUST be in snake_case [br]
## DO NOT CALL THIS VERY OFTEN, IT IS NOT THAT FAST
func find_specific_node(node_to_find: StringName) -> void:
	if node_to_find != node_to_find.to_snake_case(): push_error("param node_to_find is not in snake_case! Fix that."); return
	
	set(node_to_find, get_tree().get_root().find_child(node_to_find.to_pascal_case(), true, false))
