class_name AudioUtils extends Node

static func play_audio(node: Node, audio: AudioStream, volume_db: float) -> void:
	if not audio or not node:
		return
	
	var audio_player = AudioStreamPlayer.new()
	audio_player.stream = audio
	audio_player.volume_db = volume_db
	
	node.add_child(audio_player)
	audio_player.play()
	audio_player.finished.connect(audio_player.queue_free)
