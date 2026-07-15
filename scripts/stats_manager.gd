extends Node2D

class_name StatsManager

# Sistema de Estadísticas y Progresión

var player_stats = {
	"level": 1,
	"experience": 0,
	"hp": 20,
	"max_hp": 20,
	"attack": 5,
	"defense": 1,
	"speed": 10,
	"magic": 5,
	"luck": 1
}

var skill_tree = {
	"skills": [
		{"name": "Ataque Fuerte", "level": 0, "max_level": 5},
		{"name": "Defensa Reforzada", "level": 0, "max_level": 5},
		{"name": "Velocidad Mejorada", "level": 0, "max_level": 5},
		{"name": "Magia del Odio", "level": 0, "max_level": 3},
		{"name": "Curación del Alma", "level": 0, "max_level": 4}
	]
}

var achievement_system = {
	"achievements": []
}

signal stats_changed
signal skill_unlocked(skill_name: String)
signal achievement_unlocked(achievement_name: String)

func _ready():
	print("[STATS] Sistema de estadísticas inicializado")
	
func level_up() -> void:
	"""Sube de nivel al jugador"""
	player_stats["level"] += 1
	var level = player_stats["level"]
	
	# Aumentar stats
	player_stats["max_hp"] += 5
	player_stats["hp"] = player_stats["max_hp"]
	player_stats["attack"] += 1
	player_stats["defense"] += 1
	player_stats["speed"] += 1
	player_stats["magic"] += 1 if level % 2 == 0 else 0
	
	print("\n[STATS] ¡NIVEL SUBIÓ!")
	print("[STATS] Nuevo Nivel: ", level)
	print("[STATS] HP Máx: ", player_stats["max_hp"])
	print("[STATS] Ataque: ", player_stats["attack"])
	print("[STATS] Defensa: ", player_stats["defense"])
	print("[STATS] Velocidad: ", player_stats["speed"])
	print("[STATS] Magia: ", player_stats["magic"])
	
	stats_changed.emit()

func add_experience(amount: int) -> void:
	"""Agrega experiencia"""
	var exp_needed = player_stats["level"] * 100
	player_stats["experience"] += amount
	
	print("[STATS] +", amount, " EXP")
	print("[STATS] EXP: ", player_stats["experience"], "/", exp_needed)
	
	if player_stats["experience"] >= exp_needed:
		player_stats["experience"] -= exp_needed
		level_up()
func upgrade_skill(skill_name: String) -> bool:
	"""Sube el nivel de una habilidad"""
	for skill in skill_tree["skills"]:
		if skill["name"] == skill_name:
			if skill["level"] < skill["max_level"]:
				skill["level"] += 1
				print("[SKILLS] Habilidad mejorada: ", skill_name, " - Nivel ", skill["level"])
				skill_unlocked.emit(skill_name)
				return true
			else:
				print("[SKILLS] Habilidad al máximo nivel")
				return false
	return false

func unlock_achievement(achievement_name: String) -> void:
	"""Desbloquea un logro"""
	if achievement_name not in achievement_system["achievements"]:
		achievement_system["achievements"].append(achievement_name)
		print("[ACHIEVEMENTS] ¡LOGRO DESBLOQUEADO! ", achievement_name)
		achievement_unlocked.emit(achievement_name)

func get_stat(stat_name: String) -> int:
	"""Obtiene el valor de una estadística"""
	if stat_name in player_stats:
		return player_stats[stat_name]
	return 0

func display_stats() -> void:
	"""Muestra todas las estadísticas"""
	print("\n" + "="*50)
	print("ESTADÍSTICAS DEL JUGADOR")
	print("="*50)
	print("Nivel: ", player_stats["level"])
	print("HP: ", player_stats["hp"], "/", player_stats["max_hp"])
	print("EXP: ", player_stats["experience"], "/", player_stats["level"] * 100)
	print("\nESTADÍSTICAS:")
	print("  Ataque: ", player_stats["attack"])
	print("  Defensa: ", player_stats["defense"])
	print("  Velocidad: ", player_stats["speed"])
	print("  Magia: ", player_stats["magic"])
	print("  Suerte: ", player_stats["luck"])
	print("\nHABILIDADES:")
	for skill in skill_tree["skills"]:
		print("  ", skill["name"], ": ", skill["level"], "/", skill["max_level"])
	print("\nLOGROS DESBLOQUEADOS: ", achievement_system["achievements"].size())
	print("="*50 + "\n")
