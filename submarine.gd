extends RigidBody2D

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func despawn():
	hide()
	$CollisionShape2D.set_deferred("disabled", true)
