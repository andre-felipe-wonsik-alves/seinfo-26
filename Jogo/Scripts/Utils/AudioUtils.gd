class_name AudioUtils extends Node

static func play_audio(node: Node, audio: AudioStream, volume_db: float = 0.0):
	if not node or not audio:
		return
		
	var audio_player := AudioStreamPlayer.new()
	audio_player.stream = audio
	audio_player.volume_db = volume_db
	node.add_child(audio_player)
	audio_player.play()
	audio_player.finished.connect(audio_player.queue_free)
