extends Area2D

export (int) var speed # how fast the player will move (pixels/sec)
var screensize # size of the game window
var velocity = Vector2(0,0) #player's movement vector.

#Jumping variables
var falling = false
var screen_bot = 590
var jumping = false

#collision detection
signal hit

func _ready():
	screensize = get_viewport_rect().size

func _process(delta):
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		if(falling == false && jumping == false):
			$AnimatedSprite.animation = "right"
			$AnimatedSprite.set_flip_h(false)
	if Input.is_action_pressed("ui_left"):
		velocity.x += -1
		if(falling == false && jumping == false):
			$AnimatedSprite.animation = "right"
			$AnimatedSprite.set_flip_h(true)
	if Input.is_action_pressed("ui_up"):
		if(falling == false && jumping == false):
			velocity.y -= 9
			jumping = true
			$AnimatedSprite.animation = "jumping"
	if Input.is_action_pressed("ui_down"):
		if(velocity.y == 0):
			$AnimatedSprite.animation = "start_jump"
	else:
		if(velocity.x > 0):
			velocity.x -= 0.5
		if(velocity.x < 0):
			velocity.x += 0.5
		if(velocity.y <12 && (jumping || falling)):
			velocity.y += 0.25
			if(velocity.y >= 0):
				falling = true
				jumping = false
				$AnimatedSprite.animation = "falling"
		if(falling && position.y == screen_bot):
			falling = false
			velocity.y = 0
		if(velocity.y == 0 && velocity.x == 0 && falling == false && jumping == false):
			$AnimatedSprite.animation = "default"
			$AnimatedSprite.stop()
		else:
			$AnimatedSprite.play()
		
	position += velocity
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screen_bot)
	