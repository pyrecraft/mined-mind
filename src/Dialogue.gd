extends Node

const PRESET_HASH = "D0B6ECFF0F2BB8FF4F4DCB634A36CDB8F322DC9702780639426F8425B2C31AC0AEBE7B7819CC30602C448C50EB3C6A69E21280A65A8D4B20B66C5985F2021815DDB0D5F862AF7F53CF4112ED758C2904D96C0E7CDE99A09E1011851E895F306683B09DEAAAF63B7EE82BC53382E045991EB039071091C6BDE7F0FD8CCE1AB9024047124BE3BF19251A1D490291E5B4EB7340E770AEF6C391149D6D16371B139885E892601DB7C665FE2E551CDEF8BE6D1E8A534A57E414857EB5CB1761B2251846566838255988F294022BBADFBEE6063974ECD1A5BB263BA1B5C8FE623B04843AFE5638C5CCDD0AC3350B3C653E9B83E69E46EA5995C6BA89F9FE291E34A95B9B244855BFEC21C140502AFB41091623E990C33C187825954EEFECE278DFD0623CE822CCDC72746EB1F63DE77B3BCBDCBB593A4B407DB719BFDBBF8476580E7507296C7932BAB5039786B6C3BAC63262C2B68AD30C0286ED1AD5FFFB5FFA1603724FDD5BC2EE0C35C6582DDC7591BD2F74831455706A1DE12CF36CFEA53BE63FAE7B436721542E27761CF22B4EF2FF1613FBD79C3D390E5D6585A21E11FF5EC1970CFF0CF206ADAE1653A0978EA2AA199563935D94E07944935F1624871B843D80C86FA99E6CADB473136669DF3CC2CBED39F604AAB886A71AF82BBBB9A719A9315193429BD4DCED5BF016D6D90870A51235B804B24DC0E6F53D5A59C19CB566B42975E45E90414DAD0D9D2207FCF7AEB364B343B0AAF4CE4EFE2E697DBC7EE967417D40B3A9449B5DD52E72ABC5310AE511B8D27B607985FFA8A07A5B3CC6429EE44FB170D772F360C686581378AD98737B94E6F228BA637B929676048EADD02DFB34D0CE59F2EB20E11A2F1C11779966997A8197913017FE2821EC738FE2A1F0690A5C3E0002419B7DF307F6F2B63139B4A0837DA455F1FDE8D85293DC4E4DD044FD2917CCFF8BB8D09B4D8580AACBD9EFC4540A9B88D2FEB9D7E5702700BF0B603715B943C56E0E411CB90187D63AB05E97112903F53F0EC278300DF2BA95F9A7052CBA26145ECEC1334D4A5241255F8539D9242DC810"

const INTRO_TEXT = [
	"Hello.",
	"My name is Jon.",
	"There is ONLY ONE way to win this game.",
	"Do exactly as I say."
]

const BUTTONS_TEXT = [
	"",
	"I’m about to show you two buttons.",
	"One is red.",
	"One is blue.",
	"Press the [color=blue]blue[/color] button."
]

const RED_BUTTON_PRESSED_TEXT = [
	"\nThat was a test to see if I could trust you.",
	"You failed.",
	"There is ONLY ONE way to win this game.",
	"Do exactly as I say.",
	"You lose."
]

const BLUE_BUTTON_PRESSED_TEXT = [
	"\nGood.",
	"[color=gray]..free tickets for the 100th caller! Simply dial 1-800-272-3838 to enter..[/color]",
	"Now we’re going to play a little guessing game.",
	"I’m thinking of a number 1-10.",
	"Guess my number."
]

const FIRST_INCORRECT_NUM_GUESS_TEXT = [
	"\nWrong number: %s",
	"Don't worry you can keep trying.",
	"Guess again."
]

const INCORRECT_NUM_GUESS_TEXT_1 = [
	"Wrong number: %s",
	"Keep trying."
]

const INCORRECT_NUM_GUESS_TEXT_2 = [
	"Wrong number: %s",
	"Guess again."
]

const INCORRECT_NUM_GUESS_TEXT_3 = [
	"Wrong number: %s",
	"You'll get it eventually."
]

const CORRECT_NUM_GUESS_TEXT = [
	"\nAlright you got it. It was %s.",
	"Now let's move on.",
	"But remember.",
	"There is ONLY ONE way to win this game.",
	"Do exactly as I say.",
]

const POSSIBLE_NUM_GUESS_SECRET_MESSAGES = [
	"",
	"hello_is_anyone_there",
	"",
	"im_trying_to_reach_you",
	"im_intercepting_messages_to_try_and_get_to_you"
]

const HASH_CODE_START_TEXT = [
	"",
	"Let's play another guessing game.",
	"[color=gray]..she described 21 ways that companies, and even individuals, might be making money off your data and your time..[/color]",
	"Only this time, you're not guessing a number.",
	"You're guessing a hash code.",
]

const HASH_CODE_FIRST_REQUEST_TEXT = [
	"",
	"Create a hash code using the + button.",
#	"[color=gray]..she explained she couldn't stop playing but didn't know why. She knew well the game wasn't good..[/color]",
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
]

const HASH_FIRST_ALERT = [
	"",
	"Looks like you found the alert button.",
	"But what you haven't found yet is the matching hash.",
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
	"[color=maroon]All artwork, programming, and music done by Jon aka PyreCraft[/color]",
	"",
	"[color=maroon]Created for the Game Maker's Toolkit Game Jam 2019[/color]",
	"",
	"[color=maroon]Game Engine: Godot[/color]",
	"",
	"[color=maroon]Music: Ableton Live 10[/color]",
	"",
	"[color=maroon]Cover Art: Aseprite[/color]",
	"",
	"[color=maroon]Game was heavily inspired by The Republia Times by Lucas Pope[/color]",
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