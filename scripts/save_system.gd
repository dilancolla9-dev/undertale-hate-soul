extends Node

class_name SaveSystem

# Sistema de Guardado y Carga Persistente

var save_path = "user://saves/"
var current_save_slot = 0
var saves: Array[SaveData] = []

signal game_saved(slot: int)
signal game_loaded(slot: int)
signal save_deleted(slot: int)

func _ready():
	print("[SAVE] Sistema de guardado inicializado")
	
	# Crear carpeta de guardado si no existe
	if not DirAccess.dir_exists_absolute(save_path):
		DirAccess.make_absolute(save_path)
		print("[SAVE] Carpeta de guardado creada")
	
	load_all_saves()

func save_game(slot: int, game_state: Dictionary) -> void:
	"""Guarda la partida en un slot"""
	if slot < 0 or slot > 9:
		print("[SAVE] Slot inválido: ", slot)
		return
	
	var save_data = SaveData.new()
	save_data.slot = slot
	save_data.timestamp = Time.get_ticks_msec()
	save_data.player_level = game_state.get("level", 1)
	save_data.player_hp = game_state.get("hp", 20)
	save_data.player_max_hp = game_state.get("max_hp", 20)
	save_data.gold = game_state.get("gold", 0)
	save_data.experience = game_state.get("experience", 0)
	save_data.current_zone = game_state.get("zone", 1)
	save_data.route = game_state.get("route", "neutral")
	save_data.playtime = game_state.get("playtime", 0)
	save_data.inventory = game_state.get("inventory", [])
	save_data.killed_enemies = game_state.get("killed_enemies", [])
	
	var json = JSON.new()
	var json_string = json.stringify(save_data.to_dict())
	
	var file = FileAccess.open(save_path + "save_" + str(slot) + ".json", FileAccess.WRITE)
	if file:
		file.store_string(json_string)
		print("[SAVE] Partida guardada en slot ", slot)
		game_saved.emit(slot)
	else:
		print("[SAVE] Error al guardar en slot ", slot)

func load_game(slot: int) -> Dictionary:
	"""Carga la partida de un slot"""
	if slot < 0 or slot > 9:
		print("[SAVE] Slot inválido: ", slot)
		return {}
	
	var file_path = save_path + "save_" + str(slot) + ".json"
	if FileAccess.file_exists(file_path):
		var file = FileAccess.open(file_path, FileAccess.READ)
		if file:
			var json = JSON.new()
			var content = file.get_as_text()
			var data = json.parse(content)
			print("[SAVE] Partida cargada desde slot ", slot)
			game_loaded.emit(slot)
			return data as Dictionary
	else:
		print("[SAVE] No hay partida en slot ", slot)
		return {}

func load_all_saves() -> void:
	"""Carga todos los archivos de guardado disponibles"""
	saves.clear()
	
	for i in range(10):
		var file_path = save_path + "save_" + str(i) + ".json"
		if FileAccess.file_exists(file_path):
			var file = FileAccess.open(file_path, FileAccess.READ)
			if file:
				var json = JSON.new()
				var content = file.get_as_text()
				var data = json.parse(content)
				var save_data = SaveData.from_dict(data)
				saves.append(save_data)
	
	print("[SAVE] ", saves.size(), " partidas cargadas")

func delete_save(slot: int) -> void:
	"""Elimina un archivo de guardado"""
	var file_path = save_path + "save_" + str(slot) + ".json"
	if FileAccess.file_exists(file_path):
		DirAccess.remove_absolute(file_path)
		print("[SAVE] Partida eliminada del slot ", slot)
		save_deleted.emit(slot)

func get_save_info(slot: int) -> SaveData:
	"""Obtiene información de una partida"""
	for save in saves:
		if save.slot == slot:
			return save
	return null

func list_saves() -> void:
	"""Lista todas las partidas disponibles"""
	print("\n" + "="*50)
	print("PARTIDAS DISPONIBLES")
	print("="*50)
	
	for i in range(10):
		var save_data = get_save_info(i)
		if save_data:
			var time_str = _milliseconds_to_time(save_data.playtime)
			print("[Slot ", i, "] Nivel ", save_data.player_level, " - Zona ", save_data.current_zone, " - ", save_data.route.to_upper(), " - Tiempo: ", time_str)
		else:
			print("[Slot ", i, "] [VACÍÓ]")
	
	print("="*50 + "\n")

func _milliseconds_to_time(milliseconds: int) -> String:
	"""Convierte milisegundos a formato HH:MM:SS"""
	var seconds = milliseconds / 1000
	var minutes = seconds / 60
	var hours = minutes / 60
	
	seconds = seconds % 60
	minutes = minutes % 60
	
	return "%02d:%02d:%02d" % [hours, minutes, seconds]

class SaveData:
	var slot: int
	var timestamp: int
	var playtime: int
	var player_level: int
	var player_hp: int
	var player_max_hp: int
	var gold: int
	var experience: int
	var current_zone: int
	var route: String  # "pacifista", "neutral", "genocida", "genocidio_real"
	var inventory: Array
	var killed_enemies: Array[String]
	
	func _init():
		slot = 0
		timestamp = 0
		playtime = 0
		player_level = 1
		player_hp = 20
		player_max_hp = 20
		gold = 0
		experience = 0
		current_zone = 1
		route = "neutral"
		inventory = []
		killed_enemies = []
	
	func to_dict() -> Dictionary:
		return {
			"slot": slot,
			"timestamp": timestamp,
			"playtime": playtime,
			"player_level": player_level,
			"player_hp": player_hp,
			"player_max_hp": player_max_hp,
			"gold": gold,
			"experience": experience,
			"current_zone": current_zone,
			"route": route,
			"inventory": inventory,
			"killed_enemies": killed_enemies
		}
	
	static func from_dict(data: Dictionary) -> SaveData:
		var save = SaveData.new()
		save.slot = data.get("slot", 0)
		save.timestamp = data.get("timestamp", 0)
		save.playtime = data.get("playtime", 0)
		save.player_level = data.get("player_level", 1)
		save.player_hp = data.get("player_hp", 20)
		save.player_max_hp = data.get("player_max_hp", 20)
		save.gold = data.get("gold", 0)
		save.experience = data.get("experience", 0)
		save.current_zone = data.get("current_zone", 1)
		save.route = data.get("route", "neutral")
		save.inventory = data.get("inventory", [])
		save.killed_enemies = data.get("killed_enemies", [])
		return save
