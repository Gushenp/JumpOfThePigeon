extends Node

func disable_sound_node(value:Node2D):
	for child in value.get_children():
		_disable_recursive_sound(child)

func _disable_recursive_sound(node):
	if node is AudioStreamPlayer or node is AudioStreamPlayer2D:
		node.volume_db = -100
		
	for child in node.get_children():
		_disable_recursive_sound(child)

func enable_sound_node(value:Node2D, VolumeDB:float):
	for child in value.get_children():
		_enable_recursive_sound(child, VolumeDB)

func _enable_recursive_sound(node, volumeDB):
	if node is AudioStreamPlayer or node is AudioStreamPlayer2D:
		node.volume_db = volumeDB
		
	for child in node.get_children():
		_enable_recursive_sound(child, volumeDB)
