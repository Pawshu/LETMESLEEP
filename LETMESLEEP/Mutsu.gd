extends RigidBody2D

export var WALK_SPEED = 120.0
export var AIR_SPEED = 140.0

const AIR_ACCEL = 100.0
const AIR_DEACCEL = 100.0
const JUMP_VELOCITY = 250
const STOP_JUMP_FORCE = 50.0
const MAX_FLOOR_AIRBORNE_TIME = 0.15

var jumping = false
var stopping_jump = false

var airborne_time = 1e20

func _integrate_forces(s):
	var move_left = Input.is_action_pressed("move_left")
	var move_right = Input.is_action_pressed("move_right")
	var jump = Input.is_action_pressed("jump")
	
	var lv = s.get_linear_velocity()
	var step = s.get_step()
	
	var found_floor = false
	var floor_index = -1

	for x in range(s.get_contact_count()):
		var ci = s.get_contact_local_normal(x)

		if ci.dot(Vector2(0, -1)) > 0.6:
			found_floor = true
			floor_index = x
			
	if found_floor:
		airborne_time = 0.0
	else:
		airborne_time += step # Time it spent in the air.

	var on_floor = airborne_time < MAX_FLOOR_AIRBORNE_TIME
	
	if jumping:
		if lv.y > 0:
			jumping = false
		elif not jump:
			stopping_jump = true
		if stopping_jump:
			lv.y += STOP_JUMP_FORCE * step
	
	if on_floor:
		if move_left and not move_right:
			lv = Vector2(WALK_SPEED * -1, 0)
		elif move_right and not move_left:
			lv = Vector2(WALK_SPEED, 0)
		else:
			lv.x = 0
		
		if jump:
			lv.y = -JUMP_VELOCITY
			jumping = true
			stopping_jump = false
			
	else:
		# Process logic when the character is in the air.
		if move_left and not move_right:
			lv.x = AIR_SPEED * -1;
		elif move_right and not move_left:
			lv.x = AIR_SPEED;
		else:
			lv.x = 0
		

# Finally, apply gravity and set back the linear velocity.
	lv += s.get_total_gravity() * step
	s.set_linear_velocity(lv)
	print(s.get_linear_velocity())
		


