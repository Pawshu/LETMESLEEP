extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
#func _ready():
	#$Mutsu/Sprite/Hat.animation = "pirate"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


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
