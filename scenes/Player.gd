extends CharacterBody2D

@export var speed: int = 400
@export var gravity: int = 1200
@export var jump_speed: int = -400
@export var max_jumps = 2

var jumps_remaining = max_jumps

func get_input():
	velocity.x = 0
	
	if Input.is_action_just_pressed("jump") and jumps_remaining > 0:
		velocity.y = jump_speed
		jumps_remaining -= 1
		
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_speed
	if Input.is_action_pressed("right"):
		velocity.x += speed
	if Input.is_action_pressed("left"):
		velocity.x -= speed


func _physics_process(delta):
	velocity.y += delta * gravity
	var was_on_floor = is_on_floor()
	get_input()
	move_and_slide()
	if not was_on_floor and is_on_floor():
		jumps_remaining = max_jumps


func _process(_delta):
	if not is_on_floor():
		$Animator.play("Jump")
	elif velocity.x != 0:
		$Animator.play("Walk")
	else:
		$Animator.play("Idle")

	if velocity.x != 0:
		if velocity.x > 0:
			$Sprite2D.flip_h = false
		else:
			$Sprite2D.flip_h = true
