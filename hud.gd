extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func set_game_timer(seconds):
	var minutes = floori(seconds / 60.0)
	$GameTimerLabel.text = str("%02d:%02d" % [minutes, floori(seconds) % 60])

func set_score(score):
	$ScoreLabel.text = "%04d" % score
