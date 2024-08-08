extends RigidBody2D

@export var mine_scene: PackedScene
@export var mine_probability = 0.01
var score = 0 # score points for destroying this submarine

func _ready():
	pass 

func _process(_delta):
	if randf() < mine_probability:
		spawn_mine()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func despawn():
	hide()
	queue_free()
	$CollisionShape2D.set_deferred("disabled", true)

func spawn_mine():
	var mine = mine_scene.instantiate()
	mine.position = Vector2.ZERO
	add_child(mine)
