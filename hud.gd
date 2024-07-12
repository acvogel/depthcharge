extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func set_game_timer(millis):
	var seconds = floori(millis)
	var minutes = floori(seconds / 60.0)
	$GameTimerLabel.text = str("%02d:%02d" % [minutes, seconds % 60])
