extends Node2D

@onready var transition = $Canvas_ransition/ColorRect/AnimationPlayer
@onready var audio_exit = $Audio_Exit

func _ready() -> void:
	$".".visible = false

# animation control
func _animacao_fade_in(audio:AudioStreamPlayer, volumeDB:float, time:float) -> void:
	_sound_effect()
	transition.play("fade_in")
	_music_fade("in", audio, volumeDB, time)
	
func _animacao_fade_out(audio:AudioStreamPlayer,  volumeDB:float, time:float):
	_sound_effect()
	transition.play("fade_out")
	_music_fade("out", audio, volumeDB, time)
	await get_tree().create_timer(3.3).timeout


# visible control
func _is_visible(value: bool) -> void:
	if value:
		visible = true
	else: 
		visible = false

# audio control 
func _sound_effect() -> void:
	audio_exit.play()

func _music_fade(fadeInOut:String, audio:AudioStreamPlayer, volumeDB:float, time:float) -> void:
	if fadeInOut == "in":
		audio.volume_db = -80
		audio.play()
		var tween = create_tween()
		tween.tween_property(audio, "volume_db", volumeDB, time)
	if fadeInOut == "out":
		_is_visible(true)
		var tween = create_tween()
		tween.tween_property(audio, "volume_db", volumeDB, time)
