extends Node

const FirstButtonsResource = preload("res://src/FirstButtons.tscn")
const NumberGuessResource = preload("res://src/NumberGuess.tscn")
const HashInterfaceResource = preload("res://src/HashInterface.tscn")

var queued_next_state = GameState.state.INITIAL
var prev_state = GameState.state.INITIAL

var first_buttons_child
var number_guess_child
var hash_interface_child
var is_first_guess = true

# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.current_state = GameState.state.INITIAL
#	GameState.current_state = GameState.state.BUTTON_TEST
#	GameState.current_state = GameState.state.NUMBER_GUESS
#	GameState.current_state = GameState.state.NUMBER_GUESS_CORRECT
#	GameState.current_state = GameState.state.HASH_TEXT_START
#	GameState.current_state = GameState.state.MAIN_HASH_FIFTH_ALERT

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameState.current_state != prev_state or GameState.current_state == GameState.state.INITIAL:
		prev_state = GameState.current_state
		# Only match when there is a new state
		match GameState.current_state:
			GameState.state.INITIAL:
				GameState.set_state(GameState.state.FIRST_TEXT_START)
			GameState.state.FIRST_TEXT_START:
				$AudioStreamPlayer.play()
				$TextBox.queue_first_text_sequence()
			GameState.state.BUTTON_TEXT_START:
				$TextBox.queue_button_text_start_sequence()
			GameState.state.BUTTON_TEST:
				instance_buttons()
			GameState.state.RED_BUTTON_PRESSED:
				$TextBox.queue_red_button_pressed_sequence()
			GameState.state.BLUE_BUTTON_PRESSED:
				$TextBox.queue_blue_button_pressed_sequence()
				first_buttons_child.call_deferred('free')
			GameState.state.NUMBER_GUESS:
				instance_number_guess()
			GameState.state.NUMBER_GUESS_WAITING:
				pass
			GameState.state.NUMBER_GUESS_CORRECT:
				update_response_field_guess()
				$TextBox.queue_number_guess_correct(GameState.guess_nums)
				pass
			GameState.state.NUMBER_GUESS_INCORRECT:
				$TextBox.queue_number_guess_incorrect(GameState.guess_nums)
				update_response_field_guess()
			GameState.state.HASH_TEXT_START:
				if number_guess_child:
					number_guess_child.call_deferred('free')
				$TextBox.queue_hash_text_start_sequence()
			GameState.state.HASH_CODE_FIRST_REQUEST_TEXT:
				$TextBox.queue_hash_code_request_sequence()
			GameState.state.MAIN_HASH_FIRST_ALERT:
				$TextBox.queue_hash_first_alert()
			GameState.state.MAIN_HASH_SECOND_ALERT:
				$TextBox.queue_hash_second_alert()
			GameState.state.MAIN_HASH_THIRD_ALERT:
				$TextBox.queue_hash_third_alert()
			GameState.state.MAIN_HASH_FOURTH_ALERT:
				$TextBox.queue_hash_fourth_alert()
			GameState.state.MAIN_HASH_FIFTH_ALERT:
				$TextBox.queue_hash_fifth_alert()
				if hash_interface_child:
					hash_interface_child.call_deferred('free')
			GameState.state.HASH_REPEAT_ALERT:
				$TextBox.queue_hash_repeat_alert_text()
				GameState.set_state(GameState.state.HASH_WAITING)
			GameState.state.HASH_WAITING:
				pass
			GameState.state.GAME_OVER:
				print("Game over!")
				load_game_over_scene()

func load_game_over_scene():
	get_tree().change_scene("res://src/GameOver.tscn")

func update_response_field_guess():
	number_guess_child.update_response_field(GameState.build_json_response_nums())
	
func instance_buttons():
	first_buttons_child = FirstButtonsResource.instance()
	self.add_child(first_buttons_child)
	first_buttons_child.get_child(0).connect("pressed", self, "_on_RedButton_pressed")
	first_buttons_child.get_child(1).connect("pressed", self, "_on_BlueButton_pressed")

func instance_hash_interface():
	hash_interface_child = HashInterfaceResource.instance()
	self.add_child(hash_interface_child)
	hash_interface_child.connect("sent_request", self, "_on_HashInterface_sent_request")
	hash_interface_child.connect("alert_pressed", self, "_on_HashInterface_alert_pressed")

func _on_HashInterface_alert_pressed():
	if len(GameState.cryptic_hash_history) > GameState.hash_history_size_last_alert:
		GameState.hash_history_size_last_alert = len(GameState.cryptic_hash_history)
		GameState.alert_count = GameState.alert_count + 1
		GameState.requests_since_alert_updated = 0
		match GameState.alert_count:
			1:
				GameState.set_state(GameState.state.MAIN_HASH_FIRST_ALERT)
			2:
				GameState.set_state(GameState.state.MAIN_HASH_SECOND_ALERT)
			3:
				GameState.set_state(GameState.state.MAIN_HASH_THIRD_ALERT)
			4:
				GameState.set_state(GameState.state.MAIN_HASH_FOURTH_ALERT)
			5:
				GameState.set_state(GameState.state.MAIN_HASH_FIFTH_ALERT)
			_:
				pass
	else:
		GameState.set_state(GameState.state.HASH_REPEAT_ALERT)

func _on_HashInterface_sent_request(hash_val):
	GameState.requests_since_alert_updated += 1
	if str(hash_val) != "":
		GameState.guess_hash_history.push_front(hash_val)
		GameState.cryptic_hash_history.push_front(GameState.create_random_hash_with_secret_message(GameState.get_potential_secret_hash_message_hash_guess()))
		hash_interface_child.update_response_field(GameState.build_hash_json_response())
		if GameState.alert_count == 0 && len(GameState.guess_hash_history) == 1:
			$TextBox.queue_hash_code_sent_first_request()
		
	if GameState.requests_since_alert_updated == 2:
		match GameState.alert_count:
			1:
				$TextBox.queue_single_line_grey("\"..similar to the stanford prison experiment. They kept going because they were told to do something and were afraid of the repercussions..\"")
			2:
				$TextBox.queue_single_line_grey("\"..used this idea of a \"game jam\" to trick people into getting him rich..\"")
			3:
				pass
			4:
				pass
			5:
				pass
			_:
				pass
	elif GameState.requests_since_alert_updated == 3:
		match GameState.alert_count:
			1:
				pass
			2:
				pass
			3:
				$TextBox.queue_single_line_grey("\"..legislators lobbying for new laws around giving full information about what a game is and what kind of information is being sent to and from it..\"")
			4:
				$TextBox.queue_single_line_grey("\"..some still thought it was part of the game after playing for minutes, hours, even days..\"")
			5:
				pass
			_:
				pass
	elif GameState.requests_since_alert_updated == 7:
		match GameState.alert_count:
			1:
				pass
				$TextBox.queue_single_line_grey("\"..my daughter wouldn’t stop playing it. I kept telling her, \"you’re mining!\".. I eventually yelled \"You’re a slave to the machine!..\"")
			2:
				pass
				$TextBox.queue_single_line_grey("\"..some enjoyed the meta aspect of the game such as the self-referential signals, while others criticized it as corny or cheap..\"")
			3:
				pass
			4:
				pass
			5:
				pass
			_:
				pass

func instance_number_guess():
	number_guess_child = NumberGuessResource.instance()
	self.add_child(number_guess_child)
	number_guess_child.connect("sent_guess", self, "_on_NumberGuess_sent_guess")
	GameState.set_state(GameState.state.NUMBER_GUESS_WAITING)

func _on_NumberGuess_sent_guess(guess_num):
	if GameState.current_state != GameState.state.NUMBER_GUESS_WAITING:
		return
	GameState.guess_nums.push_front(guess_num)
	GameState.guess_nums_hash_history.push_front(GameState.create_random_hash_with_secret_message(GameState.get_potential_secret_hash_message_num_guess()))
	if is_first_guess and guess_num == GameState.random_number:
		randomize()
		if guess_num == 1:
			GameState.random_number = randi() % 9 + 2
		elif guess_num == 10:
			GameState.random_number = randi() % 9 + 1
		else:
			GameState.random_number = guess_num + 1
		GameState.set_state(GameState.state.NUMBER_GUESS_INCORRECT)
	elif guess_num == GameState.random_number:
		GameState.set_state(GameState.state.NUMBER_GUESS_CORRECT)
	else:
		GameState.set_state(GameState.state.NUMBER_GUESS_INCORRECT)
	is_first_guess = false

func _on_TextBox_first_text_completed():
	queued_next_state = GameState.state.BUTTON_TEXT_START
	$ChangeStateTimer.start()

func _on_ChangeStateTimer_timeout():
	GameState.set_state(queued_next_state)

func _on_GameOverDelayTimer_timeout():
	GameState.set_state(queued_next_state)

func _on_TextBox_page_completed():
	print("Completed a page!")
	match GameState.current_state:
		GameState.state.FIRST_TEXT_START:
			queued_next_state = GameState.state.BUTTON_TEXT_START
			$ChangeStateTimer.start()
		GameState.state.BUTTON_TEXT_START:
			queued_next_state = GameState.state.BUTTON_TEST
			$ChangeStateTimer.start()
		GameState.state.RED_BUTTON_PRESSED:
			queued_next_state = GameState.state.GAME_OVER
			$GameOverDelayTimer.start()
		GameState.state.BLUE_BUTTON_PRESSED:
			queued_next_state = GameState.state.NUMBER_GUESS
			$ChangeStateTimer.start()
		GameState.state.NUMBER_GUESS_INCORRECT:
			GameState.set_state(GameState.state.NUMBER_GUESS_WAITING)
		GameState.state.NUMBER_GUESS_CORRECT:
			GameState.set_state(GameState.state.HASH_TEXT_START)
		GameState.state.HASH_TEXT_START:
			instance_hash_interface()
			GameState.set_state(GameState.state.HASH_CODE_FIRST_REQUEST_TEXT)
		GameState.state.MAIN_HASH_FIFTH_ALERT:
			queued_next_state = GameState.state.GAME_OVER
			$GameOverDelayTimer.start()
		

func _on_BlueButton_pressed():
	print("BlueButton pressed!")
	GameState.set_state(GameState.state.BLUE_BUTTON_PRESSED)

func _on_RedButton_pressed():
	print("RedButton pressed!")
	GameState.set_state(GameState.state.RED_BUTTON_PRESSED)

func _on_AudioStreamPlayer_finished():
	$AudioStreamPlayer.play()
