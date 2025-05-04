extends Node

@onready var title_label: Label = $CenterContainer/VBoxContainer/TitleLabel
@onready var bpm_label: Label = $CenterContainer/VBoxContainer/BPMLabel
@onready var duration_label: Label = $CenterContainer/VBoxContainer/DurationLabel
@onready var difficulty_label: Label = $CenterContainer/VBoxContainer/DifficultyLabel

func _ready():
	print("게임 시작됨, 데이터 가져오는 중...")
	load_song_data()

func load_song_data():
	var http = HTTPRequest.new()
	add_child(http)
	http.request_completed.connect(_on_request_completed)

	var url = "https://127.0.0.1:8000/song.json"  # index.html과 같은 폴더에 song.json 있어야 함
	var err = http.request(url)

	if err != OK:
		print("요청 실패: ", err)

func _on_request_completed(result, response_code, headers, body):
	if response_code != 200:
		print("HTTP 응답 오류: ", response_code)
		return

	var text = body.get_string_from_utf8()
	var json = JSON.parse_string(text)

	if json == null:
		print("JSON 파싱 실패")
		return
		
	#print(json["duration"], typeof(json["duration"]))

	title_label.text += json["title"]
	bpm_label.text += json["bpm"]
	duration_label.text += json["duration"]
	difficulty_label.text += json["difficulty"]
	print("데이터 불러오기 완료")


func _on_play_button_pressed() -> void:
	JavaScriptBridge.eval("console.log('transaction confirmed')")
	get_tree().change_scene_to_file("res://scenes/game_level.tscn")
