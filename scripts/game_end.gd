extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CenterContainer/VBoxContainer/Label2.text = str(Signals.score) + $CenterContainer/VBoxContainer/Label2.text


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
