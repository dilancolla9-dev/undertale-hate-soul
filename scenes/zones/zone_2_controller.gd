extends Node2D

class_name Zone2Controller

# Controlador de Zona 2: JARDÍN OSCURO

var flowey: FloweyVicious
var combat_system: CombatSystem
var flowey_intro_complete = false

func _ready():
	print("\n" + "="*50)
	print("ZONA 2: JARDÍN OSCURO")
	print("="*50 + "\n")
	
	combat_system = CombatSystem.new()
	flowey = FloweyVicious.new()
	
	await get_tree().create_timer(0.5).timeout
	
	print("[ZONA 2] Llegas a un claro en la caverna.")
	print("[ZONA 2] Aquí, el aire es diferente.")
	print("[ZONA 2] Cálido... orgánico... peligroso.\n")
	
	await get_tree().create_timer(1.0).timeout
	
	print("[ZONA 2] A tu alrededor crecen plantas extrañas.")
	print("[ZONA 2] Sus formas son retorcidas, antinaturales.")
	print("[ZONA 2] Algunas parecen tener bocas...\n")
	
	await get_tree().create_timer(1.5).timeout
	
	print("[ZONA 2] En el centro del claro...")
	print("[ZONA 2] Hay una flor gigante.")
	print("[ZONA 2] Sus pétalos son rosa oscuro con vetas rojas.")
	print("[ZONA 2] Está completamente inmóvil.\n")
	
	await get_tree().create_timer(1.0).timeout
	
	print("[ZONA 2] Lentamente...")
	print("[ZONA 2] Sus ojos se abren.")
	print("[ZONA 2] Dos esferas negras vacías te miran fijamente.")
	print("[ZONA 2] Una sonrisa aparece en su rostro floral.\n")
	
	await get_tree().create_timer(0.5).timeout
	
	print("" + "="*50)
	print("FLOWEY HA APARECIDO")
	print("="*50 + "\n")
	
	flowey_intro_complete = true
	start_flowey_dialogue()

func start_flowey_dialogue():
	var dialogues = [
		"Hola... ¿otra alma que cae?",
		"Qué adorable...",
		"Déjame mostrarte lo que sucede cuando alguien como tú aparece aquí.",
		"Mis raíces siempre tienen hambre de almas rosa como la tuya...",
		"¿Acaso crees que eres especial? Solo eres otra presa.",
		"Bienvenido al infierno, pequeña alma."
	]
	
	for dialogue in dialogues:
		print("[FLOWEY] ", dialogue)
		await get_tree().create_timer(1.5).timeout
	
	print("\n[FLOWEY] ¡Prepárate, Alma de Odio!")
	print("[COMBAT] Iniciando batalla con FLOWEY...\n")
	
	# Aquí comenzaría el combate real con Flowey

func _process(delta):
	pass
