extends Control


func _on_start_button_pressed() -> void:
	GameManager.start_game()


func _on_settings_button_pressed() -> void:
	GameManager.open_settings_menu()
