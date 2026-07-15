extends Node

class_name SaveSystem

# Sistema de guardado y carga persistente

var save_path = "user://hate_soul_saves/"
var current_save_slot = 0
var max_saves = 10

signal save_completed(slot: int)
signal load_completed(slot: int)
signal save_deleted(slot: int)

func _ready():
	if not DirAccess.dir_exists_absolute(save_path):
		DirAccess.make_absolute(save_path)
	print("[SAVE SYSTEM] Sistema de guardado inicializado")

func save_game(game_data: Dictionary, slot: int = 0) -> bool:
	"""Guarda el juego en un slot"""
	if slot < 0 or slot >= max_saves:
		print("[SAVE] Slot inválido: ", slot)
		return false
	
	var save_file = save_path + "save_" + str(slot) + ".json"
	var json_string = JSON.stringify(game_data)
	
	var file = FileAccess.open(save_file, FileAccess.WRITE)
	if file:
		file.store_string(json_string)
		print("[SAVE] Juego guardado en slot ", slot)
		print("[SAVE] Ruta: ", save_file)
		save_completed.emit(slot)
		return true
	else:
		print("[SAVE] Error al guardar en slot ", slot)
		return false

func load_game(slot: int = 0) -> Dictionary:
	"""Carga el juego desde un slot"""
	if slot < 0 or slot >= max_saves:
		print("[SAVE] Slot inválido: ", slot)
		return {}
	
	var save_file = save_path + "save_" + str(slot) + ".json"
	
	if not FileAccess.file_exists(save_file):
		print("[SAVE] No existe guardado en slot ", slot)
		return {}
	
	var file = FileAccess.open(save_file, FileAccess.READ)
	if file:
		var json_string = file.get_as_text()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		
		if parse_result == OK:
			var game_data = json.get_data()
			print("[SAVE] Juego cargado desde slot ", slot)
			load_completed.emit(slot)
			return game_data
	
print("[SAVE] Error al cargar desde slot ", slot)
	return {}

func delete_save(slot: int = 0) -> bool:
	"""Borra un guardado"""
	if slot < 0 or slot >= max_saves:
		print("[SAVE] Slot inválido: ", slot)
		return false
	
	var save_file = save_path + "save_" + str(slot) + ".json"
	
	if FileAccess.file_exists(save_file):
		DirAccess.remove_absolute(save_file)
		print("[SAVE] Guardado eliminado del slot ", slot)
		save_deleted.emit(slot)
		return true
	return false

func list_saves() -> Array:
	"""Lista todos los guardados disponibles"""
	var saves: Array = []
	for i in range(max_saves):
		var save_file = save_path + "save_" + str(i) + ".json"
		if FileAccess.file_exists(save_file):
			saves.append({
				"slot": i,
				"path": save_file,
				"exists": true
			})
		else:
			saves.append({
				"slot": i,
				"exists": false
			})
	return saves

func get_save_data(slot: int = 0) -> Dictionary:
	"""Obtiene información del guardado"""
	var saves = list_saves()
	if slot >= 0 and slot < saves.size():
		return saves[slot]
	return {}

func create_game_data(game_manager: GameManager, inventory: InventorySystem) -> Dictionary:
	"""Crea un diccionario con los datos del juego"""
	return {
		"timestamp": Time.get_ticks_msec(),
		"level": game_manager.player_level,
		"zone": game_manager.current_zone,
		"route": game_manager.current_route,
		"hate_stat": game_manager.hate_stat,
		"pacifist_acts": game_manager.pacifist_acts,
		"violent_acts": game_manager.violent_acts,
		"gold": inventory.gold,
		"experience": inventory.experience,
		"inventory_items": [], # Se completaría con items reales
		"equipment": inventory.equipment,
		"defeated_enemies": game_manager.defeated_enemies,
		"completed_events": game_manager.completed_events
	}
