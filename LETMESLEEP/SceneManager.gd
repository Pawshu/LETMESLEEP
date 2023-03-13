extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var player = get_child(0)

# Called when the node enters the scene tree for the first time.
func _ready():
	remove_child(player)
	
func activateGame():
	add_child(player)
	player.get_node("Appearing").playing = true
	
