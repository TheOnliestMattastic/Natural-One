extends Node

var health: int = 6
var health_max: int = 6
var thirst: int = 6
var thirst_max: int = 6
var hunger: int = 6
var hunger_max: int = 6
var actions: int = 4
var actions_max: int = 4

func take_damage(amount: int = 1) -> void:
	health = clampi(health - amount, 0, health_max)
