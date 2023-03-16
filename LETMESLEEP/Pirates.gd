extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var playercam = get_node("Mutsu/PlayerCam")
onready var mapcam = get_node("MapCam")

# Called when the node enters the scene tree for the first time.
#func _ready():
	#$Mutsu/Sprite/Hat.animation = "pirate"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if event.is_action_pressed("look_at_map"):
		if(playercam.is_current()):
			mapcam.make_current()
		else:
			playercam.make_current()
		

func _on_Chest_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	$Mutsu/Sprite/Hat.animation = "pirate"
	$Chest/Sprite.animation = "loot"


func _on_Chestnoloot_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	$Chest1/Sprite.animation = "open"


func _on_Chestmastfake_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	$Chest2/Sprite.animation = "open"


func _on_Chestcabinfake_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	$Chest4/Sprite.animation = "open"


func _on_Chestcabinreal_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	$Chest3/Sprite.animation = "loot"
	$Mutsu/Sprite/Hat.animation = "fancy"
	

