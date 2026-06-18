extends CharacterBody2D

@onready var animated_sprite = $Sprite2D
var can_move = true

const SPEED = 400.0
const JUMP_VELOCITY = -400.0

func _process(_delta: float) -> void:
	
	$Jump_Count.text = "Jumps: " + str(Global.player_jump)

func _physics_process(delta: float) -> void:
	
	if !is_on_floor():
		velocity += get_gravity() * delta
		
	if can_move:
		if Input.is_action_just_pressed("jump") and !is_on_floor() and Global.player_jump  >= 1:
			velocity.y = JUMP_VELOCITY
			Global.player_jump -= 1
			
		if Input.is_action_just_pressed("jump") and is_on_floor() and Global.player_jump >= 1:
			velocity.y = JUMP_VELOCITY
			Global.player_jump -= 1
			
		var direction := Input.get_axis("left","right")
		if direction:
			velocity.x = direction * SPEED
			animated_sprite.flip_h = (direction > 0)
		else:
			velocity.x = move_toward(velocity.x,0,SPEED)
		
		
	move_and_slide()
	
func die():
	
	can_move = false
	velocity.x = move_toward(velocity.x,5,SPEED)
	
	
	
