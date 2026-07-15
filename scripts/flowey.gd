extends Node2D

class_name FloweyVicious

# Propiedades de Flowey (versión carnívora)
var is_hostile = true
var dialogue_index = 0
var has_attacked = false
var attack_range = 200.0
var player_detected = false

# Diálogos únicos de Flowey carnívoro
var dialogues = [
	"Hola... ¿Otra alma que cae?",
	"Qué adorable...",
	"Déjame mostrarte lo que sucede cuando alguien como tú aparece aquí.",
	"Mis raíces siempre tienen hambre de almas rosa como la tuya...",
	"¿Acaso crees que eres especial? Solo eres otra presa.",
	"Bienvenido al infierno, pequeña alma."
]

func _ready():
	print("[FLOWEY] Ha aparecido - Versión Carnívora")
	print("[FLOWEY] Esperando al Alma de Odio...")

func _process(delta):
	if player_detected and not has_attacked:
		display_dialogue()

func player_entered_range():
	player_detected = true
	print("[FLOWEY] Ahahaha... Te veo...")

func display_dialogue():
	if dialogue_index < dialogues.size():
		print("[FLOWEY] ", dialogues[dialogue_index])
		dialogue_index += 1
		if dialogue_index >= dialogues.size():
			has_attacked = true
			attack()

func attack():
	print("[FLOWEY] ¡ATAQUE! ¡Mis raíces salen del suelo!")
	print("[FLOWEY] Espinas carnívoras lanzan hacia ti...")

func take_damage(damage: int):
	print("[FLOWEY] ¡Auch! Una de mis raíces se daña...")
