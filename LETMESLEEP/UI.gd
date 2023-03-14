extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var moveCheckLabel = get_node("MoveLabel")
onready var jumpCheckLabel = get_node("JumpLabel")

var passedTimer = 0.0;

var moveFlag = false
var jumpFlag = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("move_right") || event.is_action_pressed("move_left"):
		moveFlag = true
		moveCheckLabel.set("custom_colors/default_color", Color(0,1,0,1))
	if event.is_action_pressed("jump"):
		jumpFlag = true
		jumpCheckLabel.set("custom_colors/default_color", Color(0,1,0,1))

