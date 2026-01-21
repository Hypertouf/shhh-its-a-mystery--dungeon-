extends CharacterBody2D

@export var speed = 100

const inputs = {
	"move_right": Vector2.RIGHT,
	"move_left": Vector2.LEFT,
	"move_down": Vector2.DOWN,
	"move_up": Vector2.UP
}

var is_attacking = false
var is_moving = false
var frame = 0
var grid_size = 24

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

#func get_input():
	#var input_direction = Input.get_vector("left", "right", "up", "down")
	#return input_direction

func _physics_process(delta):
	get_input()
	move_and_slide()
	
	#if Input.get_vector("left", "right", "up", "down") != Vector2(0,0):
		#is_moving = true
		
	if Input.is_action_pressed("attaque"):
		is_attacking = true
	
	#this is ugly for now, but it works. use state machine and MATCH instead
	#if is_moving and not is_attacking:
		#$AnimatedSprite2D.play("walk_down")
		#if $AnimatedSprite2D.frame==3 :
			#is_moving = false
		
	if Input.get_vector("left", "right", "up", "down") == Vector2(0,1) and not is_attacking :
		$AnimatedSprite2D.play("walk_down")	
	elif Input.get_vector("left", "right", "up", "down") == Vector2(0,-1) and not is_attacking :
		$AnimatedSprite2D.play("walk_up")
	elif Input.get_vector("left", "right", "up", "down") == Vector2(-1,0) and not is_attacking :
		$AnimatedSprite2D.play("walk_left")
	elif Input.get_vector("left", "right", "up", "down") == Vector2(1,0) and not is_attacking :
		$AnimatedSprite2D.play("walk_right")
	elif Input.get_vector("left", "right", "up", "down") == Vector2(0,0) and not is_attacking and not is_moving :
		$AnimatedSprite2D.play("idle")
	elif is_attacking :
		$AnimatedSprite2D.play("attack")
		if $AnimatedSprite2D.frame == 5:
			is_attacking = false
	

		
		
	
	
