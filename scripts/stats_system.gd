extends Node

class_name StatsSystem

# Sistema avanzado de estadísticas del jugador

var player_stats = {
	"max_hp": 20,
	"current_hp": 20,
	"attack": 5,
	"defense": 1,
	"magic": 3,
	"speed": 4,
	"luck": 2
}

var derived_stats = {
	"critical_chance": 0.0,
	"dodge_chance": 0.0,
	"damage_reduction": 0.0
}

var level = 1
var experience = 0
var experience_next_level = 100

func _ready():
	print("[STATS] Sistema de estadísticas inicializado")
	calculate_derived_stats()

func level_up() -> void:
	"""Sube de nivel y aumenta estadísticas"""
	level += 1
	experience = 0
	experience_next_level = level * 100
	
	# Aumento de stats por nivel
	player_stats["max_hp"] += 5
	player_stats["current_hp"] = player_stats["max_hp"]
	player_stats["attack"] += 1
	player_stats["defense"] += 1
	player_stats["magic"] += randi() % 2
	player_stats["speed"] += randi() % 2
	
	calculate_derived_stats()
	print("\n[STATS] ¡¡¡ SUBISTE DE NIVEL !!!")
	print("[STATS] Nivel: ", level)
	print_stats()

func calculate_derived_stats() -> void:
	"""Calcula estadísticas derivadas"""
	# Probabilidad crítica = Luck * 0.5%
	derived_stats["critical_chance"] = player_stats["luck"] * 0.005
	
	# Probabilidad de esquivar = Speed * 0.3%
	derived_stats["dodge_chance"] = player_stats["speed"] * 0.003
	
	# Reducción de daño = Defense * 0.1
	derived_stats["damage_reduction"] = player_stats["defense"] * 0.1

func add_experience(amount: int) -> void:
	"""Suma experiencia"""
	experience += amount
	if experience >= experience_next_level:
		level_up()

func take_damage(damage: int) -> int:
	"""Calcula y aplica daño"""
	var final_damage = max(damage - player_stats["defense"], 1)
	
	# Chance de esquivar
	if randf() < derived_stats["dodge_chance"]:
		print("[STATS] ¡Esquivaste el ataque!")
		final_damage = 0
	
	player_stats["current_hp"] -= final_damage
	if player_stats["current_hp"] < 0:
		player_stats["current_hp"] = 0
	
	return final_damage

func heal(amount: int) -> void:
	"""Cura al jugador"""
	player_stats["current_hp"] = min(player_stats["current_hp"] + amount, player_stats["max_hp"])

func calculate_damage(base_damage: int) -> int:
	"""Calcula daño con crítica"""
	var damage = base_damage + randi() % 3 - 1
	
	# Chance de crítica
	if randf() < derived_stats["critical_chance"]:
		damage = int(damage * 1.5)
		print("[STATS] ¡GOLPE CRÍTICO!")
	
	return damage

func print_stats() -> void:
	"""Muestra las estadísticas actuales"""
	print("\n" + "="*50)
	print("ESTADÍSTICAS DEL JUGADOR")
	print("="*50)
	print("Nivel: ", level)
	print("EXP: ", experience, "/", experience_next_level)
	print("\nEstadísticas Base:")
	print("  HP: ", player_stats["current_hp"], "/", player_stats["max_hp"])
	print("  ATK: ", player_stats["attack"])
	print("  DEF: ", player_stats["defense"])
	print("  MAG: ", player_stats["magic"])
	print("  SPD: ", player_stats["speed"])
	print("  LCK: ", player_stats["luck"])
	print("\nEstadísticas Derivadas:")
	print("  Crítica: ", "%.1f" % (derived_stats["critical_chance"] * 100), "%")
	print("  Esquiva: ", "%.1f" % (derived_stats["dodge_chance"] * 100), "%")
	print("  Reducción Daño: ", "%.1f" % (derived_stats["damage_reduction"] * 100), "%")
	print("="*50 + "\n")
