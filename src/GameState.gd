extends Node

enum state {
	INITIAL,
	FIRST_TEXT_START,
	BUTTON_TEXT_START, BUTTON_TEST, RED_BUTTON_PRESSED, BLUE_BUTTON_PRESSED,
	NUMBER_GUESS, NUMBER_GUESS_CORRECT, NUMBER_GUESS_INCORRECT, NUMBER_GUESS_WAITING,
	HASH_TEXT_START, HASH_CODE_FIRST_REQUEST_TEXT, HASH_REPEAT_ALERT, HASH_WAITING,
	MAIN_HASH_FIRST_ALERT, MAIN_HASH_SECOND_ALERT, MAIN_HASH_THIRD_ALERT,
	MAIN_HASH_FOURTH_ALERT, MAIN_HASH_FIFTH_ALERT
	GAME_OVER }

func _ready():
	randomize() 
	random_number = randi() % 11 + 1 # 1-10

var current_state = state.INITIAL

var random_number = 5 # 1-10

func is_guess_number_correct(num):
	return random_number == num

var guess_nums = []
var hash_history = []

var hash_history_size_last_alert = 0
var alert_count = 0
var requests_since_alert_updated = 0

func set_state(state):
	current_state = state

func create_random_hash_with_secret_message(message):
	var random_start_point = randi() % (len(Dialogue.PRESET_HASH) - 256)
	var random_hash = Dialogue.PRESET_HASH.substr(random_start_point, 256)
	var random_message_point = randi() % 70 + 180 # 180-250
	var final_message = random_hash.substr(0, random_message_point) + message + random_hash.substr(random_message_point, len(random_hash))
	return final_message

func gen_hash_64():
	var random_start_point = randi() % (len(Dialogue.PRESET_HASH) - 75)
	var random_hash = Dialogue.PRESET_HASH.substr(random_start_point, 70)
	var random_cut_point = randi() % 70
	random_hash = random_hash.substr(0, random_cut_point) + random_hash.substr(random_cut_point, 69 - random_cut_point)
	return random_hash.substr(0, 64)

func get_potential_secret_hash_message():
	var message = ""
	match len(hash_history):
		1:
			message = "we_are_intercepting_this_request_to_try_and_help_you"
		3:
			message = "you_are_actually_sending_live_web_requests_for_the_benefit_of_the_creator"
		5:
			message = "stop_before_he_gets_everyone_doing_his_dirty_work_!"
		6:
			message = "close_your_browser_!_you_are_literally_mining_cryptocurrency_for_the_creator_of_this_game"
		8:
			message = "distract_the_creator"
		11:
			message = "if_you_annoy_him_it_will_stop_him_from_doing_this_to_others"
		21:
			message = "ultimately_you_may_be_better_off_just_shutting_the_whole_thing_down"
		35:
			message = "unplug_your_machine"
		50:
			message = "if_you_are_reading_this_then_wow_i_am_amazed_you_literally_sent_50_messages_please_leave_a_comment_you_are_probably_the_most_committed_player_of_this_game_:D"
		_:
			message = ""
	return message

func build_hash_json_response():
	var api_url = "https://scrtntwrk.net/h@ckth3p1@n3t/scrthshcde1234/hash_miner"
	var response = "{\n  \"data\": [%s\n  ],\n  \"meta\": {\n    \"api\": \"%s\",\n    \"timestamp\": \"%s\",\n    \"cryptic_hash\": \"%s\"\n  }\n}"
	var json_hashes = ""
	var secret_message = get_potential_secret_hash_message()
#	var secret_message = Dialogue.POSSIBLE_NUM_GUESS_SECRET_MESSAGES[randi() % len(Dialogue.POSSIBLE_NUM_GUESS_SECRET_MESSAGES)]
	var cryptic_hash = create_random_hash_with_secret_message(secret_message)
	for i in range(0, len(hash_history)):
		json_hashes += "\n    {\n      \"guess\": \"%s\",\n      \"response\": %s\n    }," % [str(hash_history[i]), str(false).to_lower()]
	return response % [json_hashes.substr(0, len(json_hashes)-1), api_url, str(OS.get_ticks_msec()), cryptic_hash]

func build_json_response_nums():
	var api_url = "https://scrtntwrk.net/h@ckth3p1@n3t/scrthshcde1234/guess_nums"
	var response = "{\n  \"data\": [%s\n  ],\n  \"meta\": {\n    \"api\": \"%s\",\n    \"timestamp\": \"%s\",\n    \"cryptic_hash\": \"%s\"\n  }\n}"
	var json_num_guesses = ""
	randomize()
	var secret_message = ""
	if len(guess_nums) < 5:
		secret_message = Dialogue.POSSIBLE_NUM_GUESS_SECRET_MESSAGES[len(guess_nums)]
#	var secret_message = Dialogue.POSSIBLE_NUM_GUESS_SECRET_MESSAGES[randi() % len(Dialogue.POSSIBLE_NUM_GUESS_SECRET_MESSAGES)]
	var cryptic_hash = create_random_hash_with_secret_message(secret_message)
	for i in range(0, len(guess_nums)):
		json_num_guesses += "\n    {\n      \"guess\": %s,\n      \"response\": %s\n    }," % [str(guess_nums[i]), str(is_guess_number_correct(guess_nums[i])).to_lower()]
	return response % [json_num_guesses.substr(0, len(json_num_guesses)-1), api_url, str(OS.get_ticks_msec()), cryptic_hash]