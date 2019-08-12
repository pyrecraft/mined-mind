extends Polygon2D

signal page_completed

#var prev_state = GameState.State.INITIAL
var text_queue = []
var next_line_queued = false
var is_processing_first_line = true

# Called when the node enters the scene tree for the first time.
func _ready():
	clear_text()
	$RichTextLabel.visible_characters = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_SPACE) or Input.is_mouse_button_pressed(BUTTON_LEFT) or Input.is_key_pressed(KEY_ENTER):
		if has_text_to_display():
			$RichTextLabel.visible_characters = $RichTextLabel.get_total_character_count()
			if text_queue.empty():
				emit_signal("page_completed") 
	
	if !next_line_queued and !text_queue.empty() and !has_text_to_display():
		if is_processing_first_line:
			append_next_line()
			$RichTextLabel/QueueVarTimer.start()
		else:
			$RichTextLabel/NextLineTimer.start()
		next_line_queued = true
		is_processing_first_line = false

func queue_single_line_grey(line):
	line = "[color=grey]" + line + "[/color]"
	text_queue.push_back(line)

func queue_hash_code_sent_first_request():
	queue_text_array(Dialogue.FIRST_HASH_REQUEST_SENT)

func queue_hash_first_alert():
	queue_text_array(Dialogue.HASH_FIRST_ALERT)

func queue_hash_second_alert():
	queue_text_array(Dialogue.HASH_SECOND_ALERT)

func queue_hash_third_alert():
	queue_text_array(Dialogue.HASH_THIRD_ALERT)

func queue_hash_fourth_alert():
	queue_text_array(Dialogue.HASH_FOURTH_ALERT)

func queue_hash_repeat_alert_text():
	queue_text_array(Dialogue.HASH_ALERT_SAME_HISTORY_COUNT)

func queue_hash_fifth_alert():
	queue_text_array(Dialogue.HASH_FIFTH_ALERT)

func queue_hash_code_request_sequence():
	queue_text_array(Dialogue.HASH_CODE_FIRST_REQUEST_TEXT)

func queue_number_guess_correct(nums):
	for i in range(0, len(Dialogue.CORRECT_NUM_GUESS_TEXT)):
		if i == 0:
			text_queue.push_back(Dialogue.CORRECT_NUM_GUESS_TEXT[i] % str(nums[0]))
		else:
			text_queue.push_back(Dialogue.CORRECT_NUM_GUESS_TEXT[i])

func queue_hash_text_start_sequence():
	queue_text_array(Dialogue.HASH_CODE_START_TEXT)

func queue_number_guess_incorrect(nums):
	var dialogue_arr
	is_processing_first_line = true
	if len(nums) == 1:
		dialogue_arr = Dialogue.FIRST_INCORRECT_NUM_GUESS_TEXT
	else:
		randomize()
		var rand_num = randi() % 4 + 1
		match rand_num:
			1:
				dialogue_arr = Dialogue.INCORRECT_NUM_GUESS_TEXT_1
			2:
				dialogue_arr = Dialogue.INCORRECT_NUM_GUESS_TEXT_2
			3:
				dialogue_arr = Dialogue.INCORRECT_NUM_GUESS_TEXT_3
			_:
				dialogue_arr = Dialogue.INCORRECT_NUM_GUESS_TEXT_1
	for i in range(0, len(dialogue_arr)):
		if i == 1:
			text_queue.push_back(dialogue_arr[i] % str(nums[0]))
		else:
			text_queue.push_back(dialogue_arr[i])

func queue_blue_button_pressed_sequence():
	queue_text_array(Dialogue.BLUE_BUTTON_PRESSED_TEXT)

# Preempts game over screen
func queue_red_button_pressed_sequence():
#	clear_text()
	queue_text_array(Dialogue.RED_BUTTON_PRESSED_TEXT)

func queue_first_text_sequence():
	queue_text_array(Dialogue.INTRO_TEXT)

func queue_text_array(text_arr):
	is_processing_first_line = true
	for i in range(0, len(text_arr)):
		text_queue.push_back(text_arr[i])

func queue_button_text_start_sequence():
	is_processing_first_line = true
#	for i in range(0, len(Dialogue.BUTTONS_TEXT)):
#		text_queue.push_back(Dialogue.BUTTONS_TEXT[i])
	queue_text_array(Dialogue.BUTTONS_TEXT)

func clear_text():
	$RichTextLabel.clear()
	$RichTextLabel.visible_characters = 0
	for i in range(0, 30):
		$RichTextLabel.append_bbcode("\n")

func has_text_to_display():
	return $RichTextLabel.visible_characters < $RichTextLabel.get_total_character_count()

func _on_VisibleTextTimer_timeout():
	if has_text_to_display():
		$RichTextLabel.visible_characters += 1
		if ($RichTextLabel.visible_characters % 3 == 0):
			$AudioStreamPlayer.play()
		# Just finished a page
		if text_queue.empty() and $RichTextLabel.visible_characters == $RichTextLabel.get_total_character_count():
			emit_signal("page_completed")

func _on_NextLineTimer_timeout():
	append_next_line()
	$RichTextLabel/QueueVarTimer.start()

func append_next_line():
	var next_line = text_queue.pop_front()
	if "[color=gray]" in next_line or "[color=grey]" in next_line:
		$RichTextLabel.visible_characters += len(next_line)
		$RichTextLabel.append_bbcode("\n\n")
		$RichTextLabel.append_bbcode(next_line)
		if !text_queue.empty():
			append_next_line()
	else:
		$RichTextLabel.append_bbcode("\n\n")
		$RichTextLabel.append_bbcode(next_line)
		

func _on_QueueVarTimer_timeout():
	next_line_queued = false