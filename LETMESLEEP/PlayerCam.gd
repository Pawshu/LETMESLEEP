extends Camera2D

onready var player = get_node("../Mutsu")

func _physics_process(delta):
	global_position = player.global_position.round()
	force_update_scroll()
