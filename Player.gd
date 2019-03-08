extends Area2D

export (int) var speed # how fast the player will move (pixels/sec)
var screensize # size of the game window
var velocity = Vector2(0,0) #player's movement vector.

#Spawn point
var spawn = Vector2( 5, 5)

#Movement variables
var falling = true
var jumping = false
var screen_bot = 590
var jumpPower = 9
var movSpeed = 1
var maxMovSpeed = 9
var friction = 0.5
var grav = 0.25

#Collectables
var red = false #determines if a Character has collected a Red Jelly and is able to eat enemies
var redTimer = 0 #The time left remaining on the red mode
var maxRedTime = 10.0
var jellyCollected = 0 #Integer, the number of Jelly that the player currently has collected


#collision details
signal hit

func _ready():
	screensize = get_viewport_rect().size

#Handle button presses
func _process(delta):
	
	#Move right, and if we aren't jumping/falling play the animation
	if Input.is_action_pressed("ui_right"):
		velocity.x = clamp(velocity.x+movSpeed, 0, maxMovSpeed)
		if (falling == false && jumping == false):
			$AnimatedSprite.animation = "right"
			$AnimatedSprite.set_flip_h(false)
	#Move left, and if we aren't jumping/falling play the animation
	if Input.is_action_pressed("ui_left"):
		velocity.x = clamp(velocity.x-movSpeed, -maxMovSpeed, 0)
		if (falling == false && jumping == false):
			$AnimatedSprite.animation = "right"
			$AnimatedSprite.set_flip_h(true)
	#If we aren't already jumping/falling, start the jump & animation
	if Input.is_action_pressed("ui_up"):
		if(falling == false && jumping == false):
			velocity.y -= jumpPower
			jumping = true
			$AnimatedSprite.animation = "jumping"
	#If we aren't jumping/falling, crouch down
	if Input.is_action_pressed("ui_down"):
		if(velocity.y == 0):
			$AnimatedSprite.animation = "start_jump"
	#If we aren't pressing any buttons start doing some math to the velocity
	else:
		#If we aren't doing any movement, stop animations, else play animations
		if(velocity.y == 0 && velocity.x == 0 && falling == false && jumping == false):
			$AnimatedSprite.animation = "default"
			$AnimatedSprite.stop()
		else:
			$AnimatedSprite.play()
	
	#If we are no longer moving right, apply friction to stop moving
	if(velocity.x > 0 && (falling == false && jumping == false)):
		velocity.x -= friction
	#If we are no longer moving left, apply friction to stop moving
	if(velocity.x < 0 && (falling == false && jumping == false)):
		velocity.x += friction
	#If we are in the air, apply gravity
	if(velocity.y <12 && (jumping || falling)):
		velocity.y += grav
		#If we have stopped rising, we have started falling
		if(velocity.y >= 0):
			falling = true
			jumping = false
			$AnimatedSprite.animation = "falling"
	#Temporary bottom, needs replaced for when collisions are applied
	if(falling && position.y == screen_bot):
		falling = false
		velocity.y = 0
	
	#check the timer on the Red Jelly
	if(redTimer > 0):
		red = true
		$AnimatedSprite.modulate = Color(1.5,0,0)
		redTimer = clamp(redTimer-delta,0.0,999.0)
	if(redTimer==0):
		red = false
		$AnimatedSprite.modulate = Color(1,1,1)
	
	#Update player position with the current velocity
	position += velocity
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screen_bot)
	
func _on_Player_body_entered(body):
	emit_signal("hit")

func respawn():
	position = spawn

func start(pos):
	position = pos
	spawn = pos
	show()