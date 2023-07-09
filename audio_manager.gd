extends Node

@export var test_sound : AudioStream

var players = []

func play_sound(stream):
	var free_player = null
	for p in players:
		if not p.playing:
			free_player = p
			break
			
	if free_player == null:
		free_player = AudioStreamPlayer.new()
		players.append(free_player)
		add_child(free_player)
		
	free_player.stream = stream
	free_player.play()
