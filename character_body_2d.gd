extends CharacterBody2D

@export var speed = 400

var is_attacking = false
var frame = 0

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide()
	
	#this is ugly for now, but it works. use state machine and MATCH instead
	if Input.get_vector("left", "right", "up", "down") == Vector2(0,1) and not is_attacking:
		$AnimatedSprite2D.play("walk_down")
	elif Input.get_vector("left", "right", "up", "down") == Vector2(0,-1) and not is_attacking :
		$AnimatedSprite2D.play("walk_up")
	elif Input.get_vector("left", "right", "up", "down") == Vector2(-1,0) and not is_attacking :
		$AnimatedSprite2D.play("walk_left")
	elif Input.get_vector("left", "right", "up", "down") == Vector2(1,0) and not is_attacking :
		$AnimatedSprite2D.play("walk_right")
	elif Input.get_vector("left", "right", "up", "down") == Vector2(0,0) and not is_attacking :
		$AnimatedSprite2D.play("idle")
	elif is_attacking :
		$AnimatedSprite2D.play("attack")
		if $AnimatedSprite2D.frame == 5:
			is_attacking = false
	
	if Input.is_action_pressed("attaque"):
		is_attacking = true
		
		
	
	
