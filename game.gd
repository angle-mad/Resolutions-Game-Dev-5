extends Node

@onready var http_request = %WordapiRequester
var words = []

func _ready():
	Global.player_jump = 1
	fetch_words()

func fetch_words():
	var url = "https://random-words-api.kushcreates.com/api?language=en&category=wordle&words=1"  # Adjust for more words
	http_request.request(url)

func spawn_words():
	for word in words:
		# create a word node (we'll define this next)
		var word_node = preload("res://area_2d.tscn").instantiate()
		word_node.word_completed.connect(fetch_words)
		word_node.set_word(word["word"])
		var player = $CharacterBody2D
		word_node.position = Vector2(-140,-109)
		player.add_child(word_node)



func _on_wordapi_requester_request_completed(_result: int, response_code: int, _headers: PackedStringArray, body: PackedByteArray) -> void:
	if response_code == 200:
		var json = JSON.parse_string(body.get_string_from_utf8())
		words = json  # Assuming it returns an array of strings
		print("Fetched words: ", words)
		# now, spawn word objects in the game
		spawn_words()
	else:
		print("Failed to fetch words")
