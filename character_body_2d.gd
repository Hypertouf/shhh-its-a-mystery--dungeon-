extends CharacterBody2D

@export var speed = 100

enum State {IDLE, WALK, ATTACK}

var inputs = {"right": Vector2.RIGHT,
			"left": Vector2.LEFT,
			"up": Vector2.UP,
			"down": Vector2.DOWN}

var current_state: State = State.IDLE

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray = $RayCast2D

var tile_size = 24
var time_passed = 0
var animation_speed = 3
var moving = false

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func change_state(new_state: State):
	if current_state == new_state:
		return
	current_state = new_state
	match current_state:
		State.IDLE:
			animated_sprite.play("idle")
		State.WALK:
			if Input.get_vector("left", "right", "up", "down") == Vector2(0,-1):
				animated_sprite.play("walk_up")
			elif Input.get_vector("left", "right", "up", "down") == Vector2(0,1):
				animated_sprite.play("walk_down")
			elif Input.get_vector("left", "right", "up", "down") == Vector2(1,0):
				animated_sprite.play("walk_right")
			elif Input.get_vector("left", "right", "up", "down") == Vector2(-1,0):
				animated_sprite.play("walk_left")
		State.ATTACK:
			animated_sprite.play("attack")
			
func _ready():
	animated_sprite.play("idle")
	
func _unhandled_input(event):
	if moving:
		return
	for dir in inputs.keys():
		if event.is_action_pressed(dir) and current_state == State.IDLE:
			move(dir)

func move(dir):
	ray.target_position = inputs[dir] * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		#position += inputs[dir] * tile_size
		var tween = create_tween()
		tween.tween_property(self, "position",
			position + inputs[dir] * tile_size, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
		moving = true
		await tween.finished
		moving = false
		
func _physics_process(delta):
	match current_state:
		State.IDLE:
			_idle_state(delta)
		State.WALK:
			_walk_state(delta)
		State.ATTACK:
			_attack_state(delta)
	#get_input()
	#move_and_slide()
	
func _idle_state(delta):
	if Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right") or Input.is_action_just_pressed("up") or Input.is_action_just_pressed("down"): #maybe check key press instead
		time_passed = 0
		change_state(State.WALK)
	if Input.is_action_just_pressed("attaque"):
		time_passed = 0
		change_state(State.ATTACK)

func _walk_state(delta):
	time_passed += 1
	if time_passed>=20:
		change_state(State.IDLE)
		
func _attack_state(delta):
	#print("hi")
	time_passed +=1
	#print(time_passed)
	if time_passed >= 30:
		change_state(State.IDLE)	

	
