extends Node2D

class_name CombatSystem

# Sistema de combate Undertale-like

var is_combat_active = false
var player_hp = 20
var player_max_hp = 20
var enemy: Enemy
var turn_count = 0
var is_player_turn = true

signal combat_started(enemy_name: String)
signal player_attacked(damage: int)
signal enemy_attacked(damage: int)
signal combat_ended(victory: bool)

func _ready():
	print("[COMBAT] Sistema de combate inicializado")

func start_combat(enemy_data: Dictionary) -> void:
	print("\n[COMBAT] ¡COMBATE INICIADO!")
	print("[COMBAT] Enemigo: ", enemy_data.name)
	is_combat_active = true
	turn_count = 0
	is_player_turn = true
	
	enemy = Enemy.new(enemy_data)
	combat_started.emit(enemy_data.name)

func player_attack(damage: int = 5) -> void:
	if not is_player_turn or not is_combat_active:
		return
	
	var actual_damage = damage + randi() % 4 - 1  # Daño aleatorio
	enemy.take_damage(actual_damage)
	player_attacked.emit(actual_damage)
	
	print("[COMBAT] ¡Atacaste! Daño: ", actual_damage)
	print("[COMBAT] HP del enemigo: ", enemy.current_hp, "/", enemy.max_hp)
	
	if enemy.current_hp <= 0:
		end_combat(true)
	else:
		is_player_turn = false
		await get_tree().create_timer(1.0).timeout
		enemy_turn()

func player_defend() -> void:
	if not is_player_turn or not is_combat_active:
		return
	
	print("[COMBAT] ¡Te defendiste! El próximo ataque hará menos daño.")
	is_player_turn = false
	await get_tree().create_timer(1.0).timeout
	enemy_turn()

func enemy_turn() -> void:
	if not is_combat_active:
		return
	
	var damage = enemy.calculate_damage()
	player_hp -= damage
	enemy_attacked.emit(damage)
	
	print("[COMBAT] El enemigo ataca. Daño recibido: ", damage)
	print("[COMBAT] Tu HP: ", player_hp, "/", player_max_hp)
	
	if player_hp <= 0:
		end_combat(false)
	else:
		is_player_turn = true

func end_combat(player_won: bool) -> void:
	is_combat_active = false
	
	if player_won:
		print("\n[COMBAT] ¡VICTORIA!")
		print("[COMBAT] Derrotaste a ", enemy.name)
	else:
		print("\n[COMBAT] DERROTA...")
		print("[COMBAT] Fuiste vencido por ", enemy.name)
	
	combat_ended.emit(player_won)

func heal_player(amount: int) -> void:
	player_hp = min(player_hp + amount, player_max_hp)
	print("[COMBAT] Curado. HP actual: ", player_hp)

class Enemy:
	var name: String
	var max_hp: int
	var current_hp: int
	var attack_power: int
	var defense: int
	var attack_pattern: Array
	var pattern_index: int = 0
	
	func _init(data: Dictionary):
		name = data.get("name", "Enemigo")
		max_hp = data.get("max_hp", 30)
		current_hp = max_hp
		attack_power = data.get("attack_power", 3)
		defense = data.get("defense", 1)
		attack_pattern = data.get("attack_pattern", [3, 3, 5, 2])
	
	func take_damage(damage: int) -> void:
		current_hp -= max(damage - defense, 1)
	
	func calculate_damage() -> int:
		var damage = attack_pattern[pattern_index % attack_pattern.size()]
		pattern_index += 1
		return damage + randi() % 2
