extends StaticBody2D

var plat_types = ["moving", "static", "falling", "hazard"] #types that a platform can be

var size #the size of the platform

var movespeed #tracks how fast this platform moves if it is a moving platform
var direction #tracks the direction that it is moving if it is a moving platform

var plattype #tracks what platform this object is

func _ready():
	make_static()

func make_static():
	set_name("platform")
	$AnimatedSprite.animation = "static"
	$platformCollision.disabled = false

func _on_Visibility_screen_exited():
	queue_free()