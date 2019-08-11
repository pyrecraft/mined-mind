extends Polygon2D

signal sent_guess

# Called when the node enters the scene tree for the first time.
func _ready():
	$ResponseText.text = ""
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func update_response_field(response):
	$ResponseText.text = response

func get_current_number():
	return int($InputField.text)

func set_current_number(str_num):
	$InputField.text = str_num

func _on_IncButton_pressed():
	var current_num = get_current_number()
	if current_num < 10:
		set_current_number(str(current_num + 1))

func _on_DecButton_pressed():
	var current_num = get_current_number()
	if current_num > 1:
		set_current_number(str(current_num - 1))

func _on_SendRequestButton_pressed():
	emit_signal("sent_guess", get_current_number())
