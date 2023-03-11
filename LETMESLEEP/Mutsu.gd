extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 400;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _process(delta):
	var velocity = Vector2.ZERO;
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1;
	if Input.is_action_pressed("move_right"):
		velocity.x += 1;
		
	position += speed * velocity * delta;
	print(position)
# func _process(delta):

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
