extends Node

class_name EnemyAI

# Sistema de IA inteligente para enemigos

var enemy_data: Dictionary
var current_health: int
var is_aggressive = true
var attack_pattern_index = 0
var emotion = "neutral"  # neutral, angry, scared, confused

func _ready():
	print("[AI] Sistema de IA de enemigos inicializado")

func initialize_enemy(data: Dictionary) -> void:
	"""Inicializa los datos del enemigo"""
	enemy_data = data
	current_health = data.get("hp", 30)
	is_aggressive = data.get("aggressive", true)

func decide_action(player_hp: int, player_max_hp: int, round_number: int) -> String:
	"""Decide la acción del enemigo basada en IA"""
	var health_percentage = float(current_health) / enemy_data.get("max_hp", 30)
	var player_health_percentage = float(player_hp) / player_max_hp
	
	# Determinar emoción
	if health_percentage < 0.3:
		emotion = "scared"
	elif health_percentage > 0.7 and player_health_percentage < 0.5:
		emotion = "angry"
	else:
		emotion = "neutral"
	
	print("[AI] ", enemy_data.name, " - Emoción: ", emotion)
	
	match emotion:
		"angry":
			# Atacar agresivamente
			return "ATTACK"
		"scared":
			# Intentar sanar o defenderse
			if randf() > 0.6:
				return "DEFEND"
			else:
				return "ATTACK"
		_:
			# Acción normal
			return "ATTACK"

func get_attack_damage(difficulty: int = 1) -> int:
	"""Calcula daño base del ataque"""
	var pattern = enemy_data.get("attack_pattern", [3, 3, 5])
	var damage = pattern[attack_pattern_index % pattern.size()]
	var variance = randi() % 3 - 1
	
	attack_pattern_index += 1
	return max(damage + variance, 1)

func take_damage(damage: int) -> void:
	"""Aplica daño al enemigo"""
	current_health -= max(damage, 1)
	if current_health < 0:
		current_health = 0

func get_attack_description() -> String:
	"""Genera descripción de ataque dinaminada"""
	match enemy_data.name:
		"Flowey":
			return "Flowey ataca con sus raíces venenosas"
		"Toriel":
			return "Toriel dispara fuego malévolo"
		"Sans":
			return "Sans invoca magia azul destructiva"
		_:
			return enemy_data.name + " ataca"
