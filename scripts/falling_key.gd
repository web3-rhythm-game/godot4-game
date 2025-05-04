extends Sprite2D

@export var fall_speed: float = 5

var init_y_pos:float = -356
var has_passed:bool = false
var pass_threshold = 356
var exact_y_position = 292

func _init():
	set_process(false)

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += Vector2(0, fall_speed)
	
	if position.y > pass_threshold and not $Timer.is_stopped():
		#print(str($Timer.wait_time - $Timer.time_left) + " seconds to get out of frame.")
		$Timer.stop()
		has_passed = true
		
func Setup(target_x:float):
	global_position = Vector2(target_x, init_y_pos)
	set_process(true)


func _on_destroy_timer_timeout() -> void:
	queue_free()
