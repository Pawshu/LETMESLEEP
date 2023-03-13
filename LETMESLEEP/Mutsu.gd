extends RigidBody2D

export var WALK_SPEED = 120.0
export var AIR_SPEED = 140.0
export var Silent = true
export var ROTATE_AMOUNT = PI/20

const AIR_ACCEL = 100.0
const AIR_DEACCEL = 100.0
const JUMP_VELOCITY = 250
const STOP_JUMP_FORCE = 50.0
const MAX_FLOOR_AIRBORNE_TIME = 0.15

var jumping = false
var moving = false
var stopping_jump = false

var airborne_time = 1e20

func _ready():
	$Sprite/Character.animation = "idle"

func _integrate_forces(state):
	var move_left = Input.is_action_pressed("move_left")
	var move_right = Input.is_action_pressed("move_right")
	var jump = Input.is_action_pressed("jump")
	
	var velocity = state.get_linear_velocity()
	var step = state.get_step()
	
	var found_floor = false
	var floor_index = -1

	for x in range(state.get_contact_count()):
		var contact_local_normal = state.get_contact_local_normal(x)

		if contact_local_normal.dot(Vector2(0, -1)) > 0.6:
			found_floor = true
			floor_index = x
			
	if found_floor:
		airborne_time = 0.0
	else:
		airborne_time += step # Time it spent in the air.

	var on_floor = airborne_time < MAX_FLOOR_AIRBORNE_TIME
	
	if jumping:
		if velocity.y > 0:
			jumping = false
		elif not jump:
			stopping_jump = true
		if stopping_jump:
			velocity.y += STOP_JUMP_FORCE * step
	
	if on_floor:
		if move_left and not move_right:
			velocity.x = -WALK_SPEED
			moving = true
			$Sprite/Character.flip_h = true
			$Sprite/Hat.flip_h = true
		elif move_right and not move_left:
			velocity.x = WALK_SPEED
			moving = true
			$Sprite/Character.flip_h = false
			$Sprite/Hat.flip_h = false
		else:
			velocity.x = 0
			moving = false
			$Sprite.rotation = 0
			$Walking.playing = false

		#$Sprite.rotation = PI/10
		
		if jump:
			velocity.y = -JUMP_VELOCITY
			jumping = true
			moving = false
			$Sprite.rotation = 0
			stopping_jump = false
			
	else:
		# Process logic when the character is in the air.
		if move_left and not move_right:
			velocity.x = -AIR_SPEED;
			$Sprite/Character.flip_h = true
			$Sprite/Hat.flip_h = true
			moving = false
			$Walking.playing = false
		elif move_right and not move_left:
			velocity.x = AIR_SPEED;
			$Sprite/Character.flip_h = false
			$Sprite/Hat.flip_h = false
			moving = false
			$Walking.playing = false
		else:
			velocity.x = 0
			$Walking.playing = false
	

# Finally, apply gravity and set back the linear velocity.
	velocity += state.get_total_gravity() * step
	state.set_linear_velocity(velocity)
	if not Silent:
		 print(state.get_linear_velocity())
		

func _on_Timer_timeout():
	if moving == true:
		$Walking.playing = true
		if $Sprite.rotation == 0:
			$Sprite.rotation = -ROTATE_AMOUNT
		if $Sprite.rotation > 0:
			$Sprite.rotation = -ROTATE_AMOUNT
		elif $Sprite.rotation < 0:
			$Sprite.rotation = ROTATE_AMOUNT


func _on_Blink_timeout():
	$Sprite/Character.animation = "blink"
	$Sprite/Blinking.start()


func _on_Blinking_timeout():
	$Sprite/Character.animation = "idle"
