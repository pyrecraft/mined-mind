extends Polygon2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_SPACE) or Input.is_mouse_button_pressed(BUTTON_LEFT) or Input.is_key_pressed(KEY_ENTER):
		get_tree().change_scene("res://src/Main.tscn")

func _on_Timer_timeout():
	get_tree().change_scene("res://src/Main.tscn")