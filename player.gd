extends Area2D

signal player_hit

@export var speed = 400 # pixels / sec
var screen_size
@export var depth_charge_scene: PackedScene
var score = 0

func _ready():
	screen_size = get_viewport_rect().size
	
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	if Input.is_action_just_pressed("fire_depth_charge_right"):
		fire_depth_charge_right()
	if Input.is_action_just_pressed("fire_depth_charge_left"):
		fire_depth_charge_left()

func fire_depth_charge_right():
	fire_depth_charge(Vector2(60.0, -10.0), PI / 4.0, Vector2(200.0, -200.0))

func fire_depth_charge_left():
	fire_depth_charge(Vector2(-60.0, -10.0), PI / 4.0, Vector2(-200.0, -200.0))

func fire_depth_charge(position, rotation, linear_velocity):
	var depth_charge = depth_charge_scene.instantiate()
	depth_charge.position = position # relative to parent (player)
	depth_charge.rotation = rotation
	depth_charge.linear_velocity = linear_velocity
	depth_charge.depth_charge_hit.connect(_on_depth_charge_hit)
	add_child(depth_charge)

func _on_body_entered(_body):
	hide()
	_body.hide()
	player_hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _on_depth_charge_hit(submarine_score):
	score += submarine_score
