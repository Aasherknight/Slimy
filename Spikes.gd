extends RigidBody2D

export (int) var min_speed = 100  # Minimum speed range.
export (int) var max_speed = 200 # Maximum speed range.

const platform = preload("platform.gd")

func _ready():
	pass

func _on_Visibility_screen_exited():
    queue_free()