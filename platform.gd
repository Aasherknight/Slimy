extends RigidBody2D

export var position = Vector2( 0, 0) #location of this object

var platform_types = ["moving", "static", "falling", "hazard"] #types that a platform can be

var size #the size of the platform

var movespeed #tracks how fast this platform moves if it is a moving platform
var direction #tracks the direction that it is moving if it is a moving platform

var plattype #tracks what platform this object is

func _ready():
	plattype = randi() % platform_types.size()
	$AnimatedSprite.animation = plat_types[plattype]
	if(platform_types[plattype] != "hazard"):
		$platformCollision.disabled = false
	else:
		$hazardCollision.disabled = false
		
	pass
	
func _on_Visibility_screen_exited():
    queue_free()