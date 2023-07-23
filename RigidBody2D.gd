extends KinematicBody2D

var scor: int = 0
var speed: int = 200
var jumpForce: int = 400
var gravity: int = 800

# vel -> velocity, how many pixels we'll be moving per second in whichever direction (X Y)
var vel : Vector2 = Vector2() #Vector2 -> holds two values (X and Y values in this case)

# initilizes when _ready func is called
#onready var sprite : Sprite = get_node("Sprite") #reference to Sprite node
onready var _animated_sprite = $AnimatedSprite2D


# built in func, gets called 60 times per second. Checks to se if we are pressing buttons
func _physics_process(delta):
	
	vel.x = 0
		# gravity
	#pixels per second :
	vel.y += gravity * delta # delta : time duration between each frame = 1/60 
	
	# movement inputs
	#if Input.is_action_pressed("move_left"):
	if Input.is_action_pressed("d_left"):
		if is_on_floor():
			_animated_sprite.play("run")
		else:
			_animated_sprite.play("jump")
		vel.x -= speed
	#if Input.is_action_pressed("move_right"):
	elif Input.is_action_pressed("d_right"):
		if is_on_floor():
			_animated_sprite.play("run")
		else:
			_animated_sprite.play("jump")
		vel.x += speed
	elif is_on_floor() == false:
		#_animated_sprite.stop()
		_animated_sprite.play("jump")
	else:
		_animated_sprite.play("default")
	
	if Input.is_action_just_pressed("A") and is_on_floor():
		vel.y -= jumpForce
		_animated_sprite.play("jump")			
	
		
	# applying the velocity 	
	vel = move_and_slide(vel, Vector2.UP) #velocity , direction (tells where floor is pointing) (UP => x = 0, y = 1)
	# sprite direction
	if vel.x < 0: # flips sprite (left , right) at initial move depending on direction
		_animated_sprite.flip_h = true
	elif vel.x > 0:
		_animated_sprite.flip_h = false
		
 
