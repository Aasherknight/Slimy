extends Node

export (PackedScene) var Spikes
var score
var lives

const Spike = preload("Spikes.gd")

func _ready():
	randomize()
	new_game()
	
func game_over():
	lives = lives-1
	if(lives==0):
		$scoreTimer.stop()
		$mobTimer.stop()
		print(score)
		_ready()
		for child in get_children():
			if(child is Spike):
				child.queue_free()
	else:
		$Player.respawn()

func new_game():
	lives = 3
	score = 0
	$Player.start($startPosition.position)
	$startTimer.start()
	$mobTimer.set_wait_time(0.5)

func _on_startTimer_timeout():
    $mobTimer.start()
    $scoreTimer.start()

func _on_scoreTimer_timeout():
	score += 1
	if($mobTimer.get_wait_time()>0.05):
		$mobTimer.set_wait_time($mobTimer.get_wait_time()-0.05)

func _on_mobTimer_timeout():
	# Choose a random location on Path2D.
	$Pipe1/Pipe1Spawn.set_offset(randi())
	# Create a Spike instance and add it to the scene.
	var mob = Spikes.instance()
	add_child(mob)
	# Set the mob's direction perpendicular to the path direction.
	var direction = $Pipe1/Pipe1Spawn.rotation
	# Set the mob's position to a random location.
	mob.position = $Pipe1/Pipe1Spawn.position
	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	# Choose the velocity.
	mob.set_axis_velocity(Vector2(rand_range(mob.min_speed, mob.max_speed), 0).rotated(180-direction))