extends CharacterBody2D

@export var speed = 400

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide()
	if Input.get_vector("left", "right", "up", "down") == Vector2(0,1):
		$AnimatedSprite2D.play("walk_down")
	elif Input.get_vector("left", "right", "up", "down") == Vector2(0,-1) :
		$AnimatedSprite2D.play("walk_up")
	elif Input.get_vector("left", "right", "up", "down") == Vector2(-1,0) :
		$AnimatedSprite2D.play("walk_left")
	elif Input.get_vector("left", "right", "up", "down") == Vector2(1,0) :
		$AnimatedSprite2D.play("walk_right")
	
	
