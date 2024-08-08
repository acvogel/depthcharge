extends Node

@export var submarine_scene: PackedScene
var game_timer = 0.0 # sec

func _ready():
	new_game()

func new_game():
	$SubmarineTimer.start()

func end_game():
	get_tree().call_group("submarines", "queue_free")
	get_tree().call_group("mines", "queue_free")
	get_tree().call_group("depth_charges", "queue_free")
	$SubmarineTimer.stop()

func _process(delta):
	game_timer += delta
	$HUD.set_game_timer(game_timer)
	$HUD.set_score($Player.score)

func _on_submarine_timer_timeout():
	var submarine = submarine_scene.instantiate()
	var side = randi() % 2 # 0 left, 1 right
	var depths = [300.0, 500.0, 700.0]
	var depth = depths[randi() % depths.size()]
	var x = 0
	if side == 1:
		x = $Player.screen_size.x
	submarine.position = Vector2(x, depth)
	submarine.rotation = 0.0
	if side == 1:
		submarine.get_node("Sprite2D").flip_h = true
	submarine.linear_velocity = Vector2(200.0, 0.0)
	if side == 1:
		submarine.linear_velocity = -1.0 * submarine.linear_velocity
	submarine.score = depth
	add_child(submarine)

func _on_player_player_hit():
	end_game()
