extends Node2D

class_name DialogueSystem

# Sistema de diálogos del juego
var current_dialogue = ""
var dialogue_queue = []
var is_displaying = false
var text_speed = 0.05  # Velocidad de escritura

var dialogues = {
	"flowey_first_encounter": [
		"Hola... ¿Otra alma que cae?",
		"Qué adorable...",
		"Déjame mostrarte lo que sucede cuando alguien como tú aparece aquí.",
		"Mis raíces siempre tienen hambre de almas rosa como la tuya...",
		"¿Acaso crees que eres especial? Solo eres otra presa.",
		"Bienvenido al infierno."
	],
	"zone_1_intro": [
		"Caes a través de la negrura...",
		"De repente, tus pies tocan el suelo.",
		"Te encuentras en una caverna extraña y envuelta en neblina rosada.",
		"A lo lejos, ves una flor brillar con una sonrisa malévola..."
	]
}

func _ready():
	print("[DIALOGUE SYSTEM] Inicializado")

func display_dialogue(dialogue_key: String):
	if dialogue_key in dialogues:
		dialogue_queue = dialogues[dialogue_key].duplicate()
		show_next_dialogue()

func show_next_dialogue():
	if dialogue_queue.size() > 0:
		is_displaying = true
		current_dialogue = dialogue_queue.pop_front()
		print(current_dialogue)

func skip_dialogue():
	if is_displaying:
		is_displaying = false
		show_next_dialogue()
