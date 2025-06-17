extends Node

# scenes as packed scenes
const MAIN_SCENE: PackedScene = preload("res://main.tscn")

# scene instances
var main_scene_instance: Node2D = null

enum GameStates {
	MAIN_MENU = 0,
	IN_GAME,
	PAUSED,
	SETTINGS
}

static var curr_game_state: GameStates = GameStates.MAIN_MENU
static var prev_game_state: GameStates = GameStates.MAIN_MENU


func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("debug_upgrade_bomb") and OS.has_feature("debug"):
		if Singletons.player: Singletons.player.increase_explosion_tier()


func start_game() -> void:
	# get_tree().change_scene_to_packed() caused the Singletons autoload to not find anything, so this is my solution
	
	main_scene_instance = MAIN_SCENE.instantiate()
	
	# get rid of the main menu scene
	get_tree().get_root().get_child(-1).queue_free()
	
	get_tree().get_root().add_child(main_scene_instance)
	
	# set the current scene so other scripts dont break!
	get_tree().current_scene = main_scene_instance
	
	Singletons.find_all_nodes()


func open_settings_menu() -> void:
	# TODO: add settings menu and open it in this function
	print("open settings menu")


func change_game_state(to_what: GameStates) -> void:
	prev_game_state = curr_game_state
	
	curr_game_state = to_what
