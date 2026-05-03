extends Node

func _disable_visibility(root:Node):
	root.hide()

func change_property(node: Node, property: String, value) -> void:
	if property in node:
		node.set(property, value)
	
	for child in node.get_children():
		if property in child:
			child.set(property, value)
			
		if child.get_child_count() > 0:
			change_property(child, property, value)		
