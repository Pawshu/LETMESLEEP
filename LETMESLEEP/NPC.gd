extends Area2D

export var SKIN = "alphonso"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Height/Sprite.animation = SKIN


func _on_Blink_timeout():
	$Height/Sprite.frame = 1
	$Blinking.start()


func _on_Blinking_timeout():
	$Height/Sprite.frame = 0
