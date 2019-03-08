extends Node

export (PackedScene) var Mob
var score
var player = Player.instance()

func _ready():
	randomize()
	new_game()
	
func game_over():
	$scoreTimer.stop()
	$mobTimer.stop()

func new_game():
	score = 0
	$Player.spawn($startPosition.position)
	$startTimer.start()

func _on_startTimer_timeout():
    $mobTimer.start()
    $scoreTimer.start()

func _on_scoreTimer_timeout():
    score += 1

func _on_mobTimer_timeout():
	# Choose a random location on Path2D.
	$mobPath/mobSpawn.set_offset(randi())
	# Create a Mob instance and add it to the scene.
	var mob = Mob.instance()
	
	player.connect("eat_mob",mob,"_on_Eaten")
	
	add_child(mob)
	# Set the mob's direction perpendicular to the path direction.
	var direction = $mobPath/mobSpawn.rotation + PI / 2
	# Set the mob's position to a random location.
	mob.position = $mobPath/mobSpawn.position
	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	# Choose the velocity.
	mob.set_linear_velocity(Vector2(rand_range(mob.min_speed, mob.max_speed), 0).rotated(direction))