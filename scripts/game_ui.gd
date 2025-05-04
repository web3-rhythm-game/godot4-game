extends Control

var combo_count:int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.IncrementScore.connect(IncrementScore)
	Signals.IncrementCombo.connect(IncrementCombo)
	Signals.ResetCombo.connect(ResetCombo)
	ResetCombo()
	var screen_size = get_viewport().get_visible_rect().size
	%ComboLabel.position = screen_size * 0.5 - %ComboLabel.size * 0.5 + Vector2(0, -80)
	
func IncrementScore(amount: int):
	Signals.score += amount
	%ScoreLabel.text = " " + str(Signals.score)
	
func IncrementCombo():
	combo_count += 1
	%ComboLabel.text = " " + str(combo_count) + "x"
	$ComboLabelRefresh.start()
	
func ResetCombo():
	combo_count = 0
	%ComboLabel.text = ""


func _on_combo_label_refresh_timeout() -> void:
	%ComboLabel.text = ""
