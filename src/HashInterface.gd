extends Polygon2D

signal sent_request
signal alert_pressed

func _ready():
	$ResponseText.text = ""
	$InputField.text = ""

func update_response_field(response):
	$ResponseText.text = response

func get_current_hash():
	return $InputField.text

func set_current_hash(hash_val):
	$InputField.text = hash_val

func reset_input_field():
	$InputField.text = ""

func _on_SendRequestButton_pressed():
	emit_signal("sent_request", get_current_hash())
	reset_input_field()

func _on_GenHashButton_pressed():
	set_current_hash(GameState.gen_hash_64())

func _on_DelHashButton_pressed():
	set_current_hash("")

func _on_AlertButton_pressed():
	emit_signal("alert_pressed")