extends Area2D

var screen_size # Size of the game window.
@export var speed = 400
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	position.x = screen_size.x/2
	position.y = screen_size.y/2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		
		
	if velocity.length() > 0:
		# $ 是 get_node() 的简写
		velocity = velocity.normalized() * speed
		get_node("AnimatedSprite2D").play()
	else:
		get_node("AnimatedSprite2D").stop()
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if velocity.x != 0:
		# 执行移动x走路的动画
		get_node("AnimatedSprite2D").animation = "walk"
		get_node("AnimatedSprite2D").flip_v = false
		# See the note below about boolean assignment.
		get_node("AnimatedSprite2D").flip_h = velocity.x < 0
	elif velocity.y != 0:
		get_node("AnimatedSprite2D").animation = "up"
		get_node("AnimatedSprite2D").flip_v = velocity.y > 0
