extends Area2D

@export var speed = 400 # how fast the layer will move( in pixles per secods)
var screen_size # size of the game windwo

func _ready():
	screen_size = get_viewport_rect().size
	

func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		#boolean assignments in the code are shorthand ig, 
		# examples are the followng 
		# if velocity.x < 0:
		#	$AnimatedSprite2D.flip_h = true
		# else :
		#		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y !=0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0
		
signal hit 


		
					
	


func _on_body_entered(body):
	hide() #Player disappears after being hit .
	hit.emit()
	#must be deferred as we cant change physics properties on a physics call back
	$CollisionShape2D.set_deferred("disabled", true)
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false 
	
