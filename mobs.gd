extends RigidBody2D

export (int) var min_speed # Minimum speed range.
export (int) var max_speed # Maximum speed range.
var mob_types = ["bat", "imp","skelly"]
var rest = "_resting" #the suffix for the standing animation
var moving = "_moving" #the suffix for the moving animation
var mobtype #stores the mob type in use so it can be referenced later

func _ready():
	mobtype = randi() % mob_types.size()
	print(mobtype)
	$AnimatedSprite.animation = mob_types[mobtype]+moving
	print($AnimatedSprite.animation)
	if $AnimatedSprite.animation == "bat_moving":
		$AnimatedSprite.rotation_degrees = -25
	if(mob_types[mobtype] == "bat"):
		$batCollision.disabled = false
	if(mob_types[mobtype] == "imp"):
		$impCollision.disabled = false
	if(mob_types[mobtype] == "skelly"):
		$skellyCollision.disabled = false
	
	pass



func _on_Visibility_screen_exited():
    queue_free()