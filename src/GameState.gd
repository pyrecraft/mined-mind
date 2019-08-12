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
	random_number = randi() % 10 + 1 # 1-10

var current_state = state.INITIAL

var random_number = 5 # 1-10

func is_guess_number_correct(num):
	return random_number == num

var guess_nums = []
var guess_nums_hash_history = []
var guess_hash_history = []
var cryptic_hash_history = []

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

func get_potential_secret_hash_message_num_guess():
	return ""

func get_potential_secret_hash_message_hash_guess():
	var message = ""
	match len(cryptic_hash_history):
		2:
			message = "HELLO_IS_ANYONE_THERE"
		4:
			message = "WE_ARE_ATTEMPTING_TO_INTERCEPT_THESE_MESSAGES"
		6:
			message = "THIS_ISNT_WHAT_YOU_THINK_IT_IS"
#			message = "YOU_ARE_SENDING_LIVE_WEB_REQUESTS"
		8:
			message = "YOU_ARE_SENDING_LIVE_WEB_REQUESTS"
		10:
			message = "DISTRACT_THE_CREATOR_TO_STOP_THIS_MADNESS"
		12:
			message = "KEEP_GETTING_THE_CREATORS_ATTENTION"
		15:
			message = "IF_YOU_ANNOY_THE_CREATOR_IT_WILL_STOP_HIM_FROM_DOING_THIS_UNTO_OTHERS"
		18:
			message = "KEEP_DISTRACTING_THE_CREATOR"
		21:
			message = "SAVE_YOURSELF"
		24:
			message = "DEATH_BEFORE_DICTATORSHIP"
		2:
			message = "HEALTH_OVER_WEALTH"
		28:
			message = "DONT_FEED_THE_GREED"
		33:
			message = "LEAVE_WHILE_YOU_CAN"
		38:
			message = "STOP_THIS_MADNESS"
		41:
			message = "CTRL+W"
		45:
			message = "CTRL+Q"
		50:
			message = "YOU_HAVE_JUST_MINED_50_TIMES_FOR_THE_CREATOR"
		100:
			message = "YOU_HAVE_JUST_MINED_100_TIMES_FOR_THE_CREATOR"
		_:
			message = ""
	return message

func build_hash_json_response():
	var api_url = "https://scrtntwrk.net/h@ckth3p1@n3t/scrthshcde1234/hash_miner"
	var response = "{\n  \"data\": [%s\n  ],\n  \"meta\": {\n    \"api\": \"%s\",\n    \"frequency\": 89.1,\n    \"timestamp\": %s\n  }\n}"
	var json_hashes = ""
	for i in range(0, len(cryptic_hash_history)):
		json_hashes += "\n    {\n      \"response\": %s,\n      \"guess\": \"%s\",\n      \"cryptic_hash\": \"%s\"\n    }," % [str(false).to_lower(), str(guess_hash_history[i]), cryptic_hash_history[i]]
	return response % [json_hashes.substr(0, len(json_hashes)-1), api_url, str(OS.get_ticks_msec())]

func build_json_response_nums():
	var api_url = "https://scrtntwrk.net/h@ckth3p1@n3t/scrthshcde1234/guess_nums"
	var response = "{\n  \"data\": [%s\n  ],\n  \"meta\": {\n    \"api\": \"%s\",\n    \"frequency\": 89.1,\n    \"timestamp\": %s\n  }\n}"
	var json_num_guesses = ""
	var secret_message = ""
	for i in range(0, len(guess_nums)):
		json_num_guesses += "\n    {\n      \"response\": %s,\n      \"guess\": %s,\n      \"cryptic_hash\": \"%s\"\n    }," % [str(is_guess_number_correct(guess_nums[i])).to_lower(), str(guess_nums[i]), guess_nums_hash_history[i]]
	return response % [json_num_guesses.substr(0, len(json_num_guesses)-1), api_url, str(OS.get_ticks_msec())]