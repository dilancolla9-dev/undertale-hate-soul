extends Node2D

class_name Zone1Controller

# Controlador de Zona 1: LA CAÍDA

var dialogue_system: DialogueSystem
var player: HateSoul
var ghost: GhostCompanion
var fall_animation_complete = false

func _ready():
	print("\n" + "="*50)
	print("ZONA 1: LA CAÍDA")
	print("="*50)
	
	dialogue_system = DialogueSystem.new()
	
	print("\n[ZONA 1] El Alma de Odio cae a través de la negrura...")
	print("[ZONA 1] Oscuridad absoluta te rodea...")
	print("[ZONA 1] ...")
	print("[ZONA 1] ...")
	
	await get_tree().create_timer(2.0).timeout
	
	print("[ZONA 1] De repente, tus pies tocan el suelo.")
	print("[ZONA 1] El impacto te deja sin aliento.")
	print("[ZONA 1] A medida que tus ojos se adaptan...")
	
	await get_tree().create_timer(1.5).timeout
	
	print("[ZONA 1] Ves que estás en una caverna extraña.")
	print("[ZONA 1] Paredes de piedra negra te rodean.")
	print("[ZONA 1] Neblina rosada flota en el aire.")
	print("[ZONA 1] Parece... tóxica.")
	
	await get_tree().create_timer(2.0).timeout
	
	print("\n[ZONA 1] A lo lejos, ves algo brillar.")
	print("[ZONA 1] Parece una flor... pero hay algo mal en ella.")
	print("[ZONA 1] Sus pétalos tienen un color rosado oscuro...")
	print("[ZONA 1] Y... ¿está sonriendo?")
	
	await get_tree().create_timer(1.0).timeout
	
	print("\n[ZONA 1] Avanzas lentamente hacia la flor...")
	print("[ZONA 1] Cada paso resuena en la caverna vacía.")
	print("[ZONA 1] La neblina rosada se espesa.")
	print("[ZONA 1] La flor se hace más grande conforme te acercas...\n")
	
	fall_animation_complete = true

func _process(delta):
	if fall_animation_complete:
		pass
