extends Node2D

@onready var transition = $Canvas_transition/ColorRect/AnimationPlayer
@onready var audio_exit = $Audio_Exit

# animation control
func animation_fade_in(audio:AudioStreamPlayer, volumeDB:float, time:float) -> void:
	_sound_effect()
	
	transition.play("fade_in")
	_music_fade("in", audio, volumeDB, time)
	
func animation_fade_out(audio:AudioStreamPlayer,  volumeDB:float, time:float):
	_sound_effect()
	
	_sound_effect()
	transition.play("fade_out")
	_music_fade("out", audio, volumeDB, time)
	$Canvas_transition/TransitionTimer.start(4)
	await $Canvas_transition/TransitionTimer.timeout

# visible control
func is_it_visible(value:bool) -> void:
	if value:
		$Canvas_transition.visible = true
	else: 
		$Canvas_transition.visible = false

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
		is_it_visible(true)
		var tween = create_tween()
		tween.tween_property(audio, "volume_db", volumeDB, time)
