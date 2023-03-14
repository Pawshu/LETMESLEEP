extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var player = get_node("Mutsu")
onready var UI = get_node("UI")

# Called when the node enters the scene tree for the first time.
func _ready():
	remove_child(player)
	remove_child(UI)
	
	
func activateGame():
	add_child(player)
	add_child(UI)
	player.get_node("Appearing").playing = true
	$Mutsu/Sprite/Hat.animation = "none"
