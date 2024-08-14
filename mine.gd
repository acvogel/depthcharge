extends RigidBody2D

signal mine_miss

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func handle_miss():
	mine_miss.emit()
	$AnimatedSprite2D.play("explosion")
	$CollisionShape2D.set_deferred("disabled", true)

	# downward impulse to slow the rise
	var impulse_y = 0.8 * abs(mass * linear_velocity.y)
	apply_impulse(Vector2(0.0, impulse_y))


func _on_animated_sprite_2d_animation_finished():
	hide()
	queue_free()
