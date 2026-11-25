extends Node

# UI
signal button_pressed(button: String)
signal menu_opened(menu_name: String)
signal gain_menu_requested(card, gained)

# Dice
signal roll_started
signal roll_finished(result: int)
