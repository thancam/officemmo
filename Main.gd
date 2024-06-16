extends Node

@export var mob_scene: PackedScene
var score 




func _ready():
	pass 


func _process(delta):
	pass


func _on_player_hit():
	pass 

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()

func new_game():
	score = 0 
	$Player.start($StartPosition.position)
	$StartTimer.start()
	

func _on_mob_timer_timeout():
	#create a new instance of mob scene
	var mob = mob_scene.instantiate()
	
	#choose a random location on path2d
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ration = randf()
	
	#set the mob's direction prependicular to the player
	var direction = mob_spawn_location.rotation + PI / 2 
	
	#set the mob's position to a random location.
	mob.position = mob_spawn_location.position
	
	# add some randomness to the direction
	direction += randf_range(-PI/ 4, PI / 4)
	mob.rotation = direction
	
	#choose the velocity for the mob
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	#spawn the mob by adding it to the main scnene
	add_child(mob)
	
	
pass





	
