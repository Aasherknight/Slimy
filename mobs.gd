extends RigidBody2D

export (int) var min_speed # Minimum speed range.
export (int) var max_speed # Maximum speed range.
var mob_types = ["bat", "imp","skelly"]
var rest = "_resting" #the suffix for the standing animation
var moving = "_moving" #the suffix for the moving animation
var mobtype #stores the mob type in use so it can be referenced later

signal mob_touch

func _ready():
	mobtype = randi() % mob_types.size()
	#print(mobtype)
	$AnimatedSprite.animation = mob_types[mobtype]+moving
	#print($AnimatedSprite.animation)
	if $AnimatedSprite.animation == "bat_moving":
		$AnimatedSprite.rotation_degrees = -25
	if(mob_types[mobtype] == "bat"):
		$batCollision.disabled = false
	if(mob_types[mobtype] == "imp"):
		$impCollision.disabled = false
	if(mob_types[mobtype] == "skelly"):
		$skellyCollision.disabled = false
	pass

func _spawn_bat(pos):
	position = pos
	$AnimatedSprite.animation = "bat_moving"
	$AnimatedSprite.rotation_degrees = -25
	$batCollision.disabled = false

func _spawn_imp(pos):
	position = pos
	$AnimatedSprite.animation = "imp_moving"
	$AnimatedSprite.rotation_degrees = -25
	$impCollision.disabled = false

func _spawn_skelly(pos):
	position = pos
	$AnimatedSprite.animation = "imp_moving"
	$AnimatedSprite.rotation_degrees = -25
	$skellyCollision.disabled = false

func _on_Area2D_body_entered(body):
	if (not body.get("is_player") == null):
		emit_signal("mob_touch")

func _on_Eaten():
	print("hi")
	hide()
	queue_free()

func _on_Visibility_screen_exited():
    queue_free()
