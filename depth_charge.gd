extends RigidBody2D

signal depth_charge_hit(score)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_body_entered(body):
	# despawn depth charge (todo explosion)
	hide()
	depth_charge_hit.emit(body.score)
	$CollisionShape2D.set_deferred("disabled", true)
	
	# despawn submarine (todo explosion animation)
	body.despawn()
