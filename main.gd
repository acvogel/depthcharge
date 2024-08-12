extends Node

@export var submarine_scene: PackedScene
var game_timer = 0.0 # sec

enum GameState {INTRO, GAME, GAME_OVER}
@export var game_state = GameState.INTRO

var player_starting_position = Vector2(563.0, 85.0)

func _ready():
	$IntroHUD.show()
	$HUD.hide()
	$SubmarineTimer.stop()

func new_game():
	$Player.start(player_starting_position)
	$SubmarineTimer.start(0.0)
	game_timer = 0.0
	$Player.score = 0
	game_state = GameState.GAME
	$HUD.show()
	$IntroHUD.get_node("GameOverLabel").visible = false
	$IntroHUD.hide()

func end_game():
	game_state = GameState.GAME_OVER
	get_tree().call_group("submarines", "queue_free")
	get_tree().call_group("mines", "queue_free")
	get_tree().call_group("depth_charges", "queue_free")
	$SubmarineTimer.stop()
	#game_timer = 0.0
	#score = 0.0
	$IntroHUD.get_node("GameOverLabel").visible = true
	$IntroHUD.get_node("TitleLabel").visible = false
	$IntroHUD.show()

func _process(delta):
	if game_state == GameState.INTRO || game_state == GameState.GAME_OVER:
		if Input.is_action_pressed("start_game"):
			new_game()
	if game_state == GameState.GAME:
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
