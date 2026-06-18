extends Area2D

signal word_completed

var word: String
var typed = ""

func set_word(w: String):
	word = w
	$Label.text = word

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.unicode == 0:
			return
		var chara = char(event.unicode)
		if chara.is_valid_identifier():  # simple check for letters
			typed += chara
			update_display()
			if typed.length() == word.length():
				if typed == word:
					Global.player_jump += 1
				# word typed correctly!
				queue_free()  # Remove word
				# maybe give player a boost or points
				word_completed.emit()

func update_display():
	$Label.text = word.substr(typed.length())  # Show remaining letters
