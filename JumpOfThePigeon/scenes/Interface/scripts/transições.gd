extends Node2D

@onready var transition = $Canvas_transition/ColorRect/AnimationPlayer
# animation control

func animation_fade_in() -> void:
	transition.play("fade_in")

func animation_fade_out() -> void:
	transition.play("fade_out")
