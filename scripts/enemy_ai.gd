extends Node2D

class_name EnemyAI

# IA Avanzada para Enemigos

var enemy_name: String
var current_hp: int
var max_hp: int
var attack_power: int
var defense: int
var state: String = "idle"  # idle, alert, attacking, fleeing, dead
var mood: String = "neutral"  # neutral, angry, scared, confused
var attack_pattern: Array
var pattern_index: int = 0
var distance_to_player: float = 999.0

signal state_changed(new_state: String)
signal attacked(damage: int)

func _init(data: Dictionary):
	enemy_name = data.get("name", "Enemigo")
	max_hp = data.get("max_hp", 30)
	current_hp = max_hp
	attack_power = data.get("attack_power", 5)
	defense = data.get("defense", 1)
	attack_pattern = data.get("attack_pattern", [3, 3, 5, 2])

mood = data.get("mood", "neutral")
func _process(delta):
	match state:
		"idle":
			updnate_idle_behavior()
		"alert":
			update_alert_behavior()
		"attacking":
			update_attacking_behavior()
		"fleeing":
			update_fleeing_behavior()
func update_idle_behavior() -> void:
	"""Comportamiento en reposo"""
	if distance_to_player < 100:
		change_state("alert")
func update_alert_behavior() -> void:
	"""Comportamiento alerta"""
	if distance_to_player < 50:
		change_state("attacking")
	elif distance_to_player > 150:
		change_state("idle")
func update_attacking_behavior() -> void:
	"""Comportamiento atacando"""
	if current_hp < max_hp * 0.3:
		if randf() > 0.7:
			change_state("fleeing")
	elif distance_to_player > 100:
		change_state("alert")
func update_fleeing_behavior() -> void:
	"""Comportamiento huyendo"""
	if current_hp > max_hp * 0.6:
		change_state("attacking")
func change_state(new_state: String) -> void:
	"""Cambia el estado del enemigo"""
	if state != new_state:
		print("[", enemy_name, "] Estado: ", state, " -> ", new_state)
		state = new_state
		state_changed.emit(new_state)
func calculate_next_action() -> Dictionary:
	"""Calcula la siguiente acción basada en la IA"""
	var action = {"type": "attack", "damage": 0}
	
	match state:
		"attacking":
			action = {"type": "attack", "damage": get_attack_damage()}
		"fleeing":
			action = {"type": "defend", "defense_boost": 2}
		"alert":
			if randf() > 0.5:
				action = {"type": "attack", "damage": get_attack_damage()}
			else:
				action = {"type": "defend", "defense_boost": 1}
	
	return action
func get_attack_damage() -> int:
	"""Obtiene el daño del siguiente ataque"""
	var damage = attack_pattern[pattern_index % attack_pattern.size()]
	pattern_index += 1
	return damage
func take_damage(damage: int) -> void:
	"""El enemigo recibe daño"""
	var actual_damage = max(damage - defense, 1)
	current_hp -= actual_damage
	
	print("[", enemy_name, "] Recibe ", actual_damage, " de daño")
	print("[", enemy_name, "] HP: ", current_hp, "/", max_hp)
	
	if current_hp <= 0:
		change_state("dead")
	
	attacked.emit(actual_damage)
func set_distance_to_player(distance: float) -> void:
	"""Actualiza la distancia al jugador"""
	distance_to_player = distance
func get_mood_string() -> String:
	"""Retorna string del estado emocional"""
	match mood:
		"angry":
			return "¡Furioso!"
		"scared":
			return "Asustado..."
		"confused":
			return "Confundido?"
		_:
			return "Normal"
