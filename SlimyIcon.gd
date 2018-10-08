extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	#translate to center of the parent, in this case, the viewport
	var newPos = Vector2(self.get_parent().get_visible_rect().size.x/2,self.get_parent().get_visible_rect().size.y/2)
	Position2D = newPos
	   
   #rotate by 90 degrees.  set_rot takes radians so we need to convert using in-built function
	rotate(deg2rad(90))
   
   #scale by 2x
	apply_scale(Vector2(2,2))
	pass	
	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
