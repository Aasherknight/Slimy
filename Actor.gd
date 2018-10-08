extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func moveLeft():
	var newPos = Vector2(self.get_parent().get_rect().size.width/2,
		self.get_parent().get_rect().size.height/2)
	self.set_pos(newPos)
	
	self.set_rot(deg2rad(90))
	pass
	
func _draw():
	self.draw_rect(self.get_item_rect(),Color(0,0,1,0.2))
	pass
	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
