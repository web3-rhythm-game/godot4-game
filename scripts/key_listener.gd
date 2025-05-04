extends Sprite2D

@onready var falling_key = preload("res://scenes/falling_key.tscn")
@onready var press_text = preload("res://scenes/score_press_text.tscn")
@export var key_name: String = ""
@export var key_array_num: int

var falling_key_queue = []
var not_first_time:bool = false
var missed_row:int = 0
var last_press_text: Control

#If distance is less than threshold, give that score or miss
var perfect_press_threshold:int = 20
var good_press_threshold:int = 40
var normal_press_threshold:int = 80
var check_threshold:int = 160

var perfect_press_score:int = 250
var good_press_score:int = 100
var normal_press_score:int = 30
var bad_score:int = -50


func _ready() -> void:
	Signals.CreateFallingKey.connect(CreateFallingKey)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	

	if Input.is_action_just_pressed(key_name):
		Signals.KeyListenerPress.emit(key_name, key_array_num)

	#make sure that there is falling key
	if falling_key_queue.size() > 0:
		var key_to_check = falling_key_queue.front()
		var distance = abs(key_to_check.exact_y_position - key_to_check.global_position.y)
		
		#free that node when the key has gone below screen
		if key_to_check.has_passed:
			#miss logic(stack num, score logic)
			CreateJudgementText("Miss")
			Signals.ResetCombo.emit()
			missed_row += 1	
			print("missed "+ str(missed_row) +" notes in a row.")
			falling_key_queue.pop_front().queue_free()
			
		#key pressed situation
		if Input.is_action_just_pressed(key_name) && distance <= check_threshold:
			missed_row = 0
			
			var press_score_text: String = ""
			if distance <= perfect_press_threshold:
				Signals.IncrementScore.emit(perfect_press_score)
				press_score_text = "Perfect"
				Signals.IncrementCombo.emit()
			elif distance <= good_press_threshold:
				Signals.IncrementScore.emit(good_press_score)
				press_score_text = "Good"
				Signals.IncrementCombo.emit()
			elif distance <= normal_press_threshold:
				Signals.IncrementScore.emit(normal_press_score)
				press_score_text = "Normal"
				Signals.IncrementCombo.emit()
			else:
				Signals.IncrementScore.emit(bad_score)
				press_score_text = "Bad"
				Signals.ResetCombo.emit()
				

			falling_key_queue.pop_front().queue_free()
			
			CreateJudgementText(press_score_text)

			#get_tree().get_root().call_deferred("add_child", pressText_inst)
			#pressText_inst.global_position = global_position + Vector2(0, -35)
		
func CreateJudgementText(press_score_text: String):
	var game_ui = get_node("/root/GameLevel/GameUI")
	
	#check if there is press_text instantiated, if so queue_free() that node first
	print("Check afssign: ", last_press_text,"Valid: ", is_instance_valid(last_press_text) )	
	
	if last_press_text and is_instance_valid(last_press_text):
		last_press_text.queue_free()

	var pressText_inst = press_text.instantiate()
	pressText_inst.name = "PressText"
	pressText_inst.SetTextInfo(press_score_text)
	game_ui.add_child(pressText_inst)
	pressText_inst.position = game_ui.get_size() * 0.5 + Vector2(-50, -180)
	last_press_text = pressText_inst
	print("Assigned:", last_press_text)
	print("Valid?", is_instance_valid(last_press_text))

		
func CreateFallingKey(button_name: String):
	if button_name == key_name:
		var fk_inst = falling_key.instantiate()
		get_tree().get_root().call_deferred("add_child", fk_inst)
		fk_inst.Setup(position.x)
	
		falling_key_queue.push_back(fk_inst)
	
#func _on_random_spawn_timer_timeout() -> void:
	#not_first_time && CreateFallingKey()
	#not_first_time = true
	#$RandomSpawnTimer.wait_time = randf_range(0.5,2)
	#$RandomSpawnTimer.start()
