extends Node

export (PackedScene) var Spikes
export (PackedScene) var Platform
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
		for child in get_children():
			if(child is Spike):
				child.queue_free()
		$Player.respawn()

func new_game():
	$Platform1.make_static()
	$Platform2.make_static()
	$Platform2.scale.x = 10
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
	if(score%10==0):
		$mobTimer.set_wait_time($mobTimer.get_wait_time()-0.05)

func _on_mobTimer_timeout():
	# Create a Spike instance and add it to the scene.
	var spike = Spikes.instance()
	add_child(spike)
	
	var degrees = 0
	
	#select the spawn point
	match(randi() % 2):
		0:
			spike.position = $Pipe1.position
			degrees = rand_range(15,75)
		1:
			spike.position = $Pipe2.position
			degrees = rand_range(285,345)
	
	spike.rotation = (degrees*PI)/180
	spike.set_axis_velocity(Vector2(0,rand_range(spike.min_speed, spike.max_speed)).rotated((degrees*PI)/180))

	