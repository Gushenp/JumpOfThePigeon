extends Node

func _disable_visibility(root:Node):
	root.hide()

func disable_collisions(root:Node):
	if root.has_method("ed_gravity"):
		root.ed_gravity(false)
		
	for node in root.find_children("*", "", true, false):
		if node is CollisionShape2D or node is CollisionPolygon2D:
			node.disabled = true
			
		elif node is PhysicsBody2D:
			node.set_collision_layer(0)
			node.set_collision_mask(0)
			
		elif node is Area2D:
			node.monitoring = false
			node.monitorable = false
