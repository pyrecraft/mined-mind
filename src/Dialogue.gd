extends Node

const PRESET_HASH = "d634727437eafe01ea5baae9f36e03c6df0181392a3927049db8cdd5e7512b6c679775e9c095305b2430ff6861047c5ef3544baab45b5580b3d0b63c7241f74c8ad3da3323231ba3507336f75a43e06c24d055d35633b21bca8f6f56ce02e013121577a8b7be9fd53bacf5dc3933d2fe222f8130c4823f4b42c0b92a3927049db8cdd5e7512b6c679775e9c095305b2430ff680052f9118d246c9ee408e74d318b2b3dec9b776012ab1570ea04ce24ba1428575529f33b21bca8f6f56ce02e013121572a3927049db8cdd5e7512b6c679775e9c095305b2430ff687a8b7be9fd53bacf5dc3933d2fe222f8130c4823f4b42c0b9bfdb8d0941b1081cda1d2962a3927049db8cdd5e7512b6c679775e9c095305b2430ff68f78afd9f3af2100550012fa3f9dfa87f86ff0342b503590c9e577976c6b2157e5ddc8bd9407293a2692d1adc1801b1490d8bdfb9b0c24b4f3284c0318f222ef2d3393cd5fcab35df9eb7b8a786ff0342b503590c9e577976c6b2157e5ddc8bd9407293a275121310e20ec65f6f8acb12b33f9255758241ab42ec40ae0751ba210677b9ced3b2b813d47e804ee9c642d8119f250086ff0342b503590c9e577976c6b2157e5ddc8bd9407293a29b0c24b4f3284c0318f222ef2d3393cd5fcab35df9eb7b8a775121310e20ec65f6f8acb12b33653d550d42c60e34a57f6337053ab1323233ad3da8c47f1427c36b0d3b0855b54baab4453fe5c7401686ff0342b503590c9e577976c6b2157e5ddc8bd9407293a2931810fd6c30e63f9eaab5ae10efae734727436d"

const INTRO_TEXT = [
	"Hello.",
	"My name is Jon.",
	"There is ONLY ONE way to win this game.",
	"Do exactly as I say.",
]

const BUTTONS_TEXT = [
	"",
	"I’m about to show you two buttons.",
	"One is red.",
	"One is blue.",
	"Press the [color=blue]blue[/color] button."
]

const RED_BUTTON_PRESSED_TEXT = [
	"",
	"That was a test to see if I could trust you.",
	"You failed.",
	"There is ONLY ONE way to win this game.",
	"Do exactly as I say.",
	"",
	"You lose."
]

const BLUE_BUTTON_PRESSED_TEXT = [
	"\nGood.",
	"[color=gray]\"..coming at you LIVE from 88.3 FM! The #1 hit music station since 1984..\"[/color]",
	"Now we’re going to play a little guessing game.",
	"I’m thinking of a number 1-10.",
	"Guess my number."
]

const FIRST_INCORRECT_NUM_GUESS_TEXT = [
	"",
	"You guessed %s and it was wrong.",
	"Don't worry you can keep trying."
]

const INCORRECT_NUM_GUESS_TEXT_1 = [
	"",
	"You guessed %s and it was wrong.",
	"Keep trying."
]

const INCORRECT_NUM_GUESS_TEXT_2 = [
	"",
	"You guessed %s and it was wrong.",
	"Guess again."
]

const INCORRECT_NUM_GUESS_TEXT_3 = [
	"",
	"You guessed %s and it was wrong.",
	"You'll get it eventually."
]

const CORRECT_NUM_GUESS_TEXT = [
	"\nAlright you got it. It was %s.",
	"Notice the \"true\" value in the response field.",
	"",
	"Now let's move on.",
	"But remember.",
	"There is ONLY ONE way to win this game.",
	"Do exactly as I say.",
]

const HASH_CODE_START_TEXT = [
	"",
	"Let's play another guessing game.",
	"[color=gray]\"..she described 21 ways that companies, and even individuals, might be making money off your data and your time..\"[/color]",
	"Only this time, you're not guessing a number.",
	"You're guessing a hash code.",
]

const HASH_CODE_FIRST_REQUEST_TEXT = [
	"",
	"Create a hash code using the + button.",
	"Then send it just like before.",
	"When you get a match, notify me with the alert button.",
]

const FIRST_HASH_REQUEST_SENT = [
	"",
	"Good.",
	"Keep sending those requests until you see a successful response."
]

const HASH_ALERT_SAME_HISTORY_COUNT = [
	"",
	"Not much has changed since the last time you alerted me.",
	"Keep searching for that hash."
]

const HASH_FIRST_ALERT = [
	"",
	"Looks like you found the alert button.",
	"But what you haven't found yet is the matching hash.",
	"[color=gray]\"..mind control? What world do you think we live in? No crazy talk here at 91.5 FM!\"[/color]",
	"There is ONLY ONE way to win this game.",
	"Do exactly as I say.",
	"Find that hash."
]

const HASH_SECOND_ALERT = [
	"",
	"What is it?",
	"Why are you slowing down?",
	"Keep sending requests.",
	"Remember.",
	"There is ONLY ONE way to win this game.",
	"Do exactly as I say.",
	"Find that hash."
]

const HASH_THIRD_ALERT = [
	"",
	"Why aren't you working?",
	"You are wasting my time.",
	"Stop alerting me before you find the hash.",
	"There is ONLY ONE way to win this game.",
	"Do exactly as I say.",
	"Find that hash."
]

const HASH_FOURTH_ALERT = [
	"",
	"You are the laziest worker I've ever encountered.",
	"Pleaing for help rather than doing your job.",
	"The next alert better be when you find that hash.",
	"[color=gray]\"..what they didn’t realize is that they were literally mining. Every request was a real web request to a remote server..\"[/color]",	
	"Remember.",
	"There is ONLY ONE way to win this game.",
	"Do exactly as I say.",
	"Find that hash."
]

const HASH_FIFTH_ALERT = [
	"",
	"It's clear you are just wasting everybody's time.",
	"",
	"You can't win this game.",
	"You never could have.",
	"",
	"There is ONLY ONE way to win this game.",
	"Do exactly as I say.",
	"",
	"I never told you WHO wins.",
	"",
	"I win.",
	"You do the dirty work.",
	"I win.",
	"",
	"Don't be the sheep.",
	"Be the wolf.",
	"And you'll win the real game.",
	"",
	"The ONLY ONE way to win was won (by Jon the creator).",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"[color=maroon]Credits[/color]",
	"",
	"[color=maroon]All artwork, programming, and music done by Jon aka Pyre Craft[/color]",
	"",
	"[color=maroon]Created for the Game Maker's Toolkit Game Jam 2019[/color]",
	"",
	"[color=maroon]Game Engine: Godot[/color]",
	"[color=maroon]Music: Ableton Live 10[/color]",
	"[color=maroon]Cover Art: Adobe Illustrator[/color]",
	"",
	"[color=maroon]Game was partially inspired by The Republia Times by Lucas Pope[/color]",
	"",
	"[color=maroon]Thanks for playing![/color]",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	":D"
]