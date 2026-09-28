extends Node2D

@onready var global_elements = $"."

#==================================
# ==== Desativar e ativar mapa ====
#==================================
func _desativar_realidade():
	global_elements.get_node("tileMap").hide() #visual - tilemap 
	global_elements.get_node("tileMap/solo").enabled = false
	global_elements._desativar_sons()

func _reativar_realidade():
	global_elements.get_node("tileMap").show() #visual - tilemap
	global_elements.get_node("tileMap/solo").enabled = true
	global_elements._reativar_sons()
