extends RigidBody2D

signal mine_miss
# wait how is mine hit working??

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func handle_miss():
	hide()
	mine_miss.emit()
	$CollisionShape2D.set_deferred("disabled", true)
