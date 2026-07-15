extends Node2D

class_name CinematicController

# Controlador de cinemáticas y escenas narrativas

var dialogue_speed = 0.05  # Segundos por carácter
var current_scene = "intro"
var is_playing = false

signal cinematic_started(scene_name: String)
signal cinematic_ended(scene_name: String)
signal dialogue_displayed(text: String)

func _ready():
	print("[CINEMATIC] Sistema de cinemáticas inicializado")

func play_cinematic(scene_name: String) -> void:
	"""Reproduce una cinemática específica"""
	is_playing = true
	current_scene = scene_name
	cinematic_started.emit(scene_name)
	
	match scene_name:
		"intro_awakening":
			await play_intro_awakening()
		"zone_1_fall":
			await play_zone_1_fall()
		"zone_2_discovery":
			await play_zone_2_discovery()
		"flowey_encounter":
			await play_flowey_encounter()
		"flowey_defeat":
			await play_flowey_defeat()
		"toriel_meeting":
			await play_toriel_meeting()
		"bad_ending":
			await play_bad_ending()
		"true_ending":
			await play_true_ending()
	
	is_playing = false
	cinematic_ended.emit(scene_name)

func play_intro_awakening() -> void:
	"""Cinemática inicial - Despertar del Alma de Odio"""
	print("\n" + "="*60)
	print("CINEMÁTICA: DESPERTAR DEL ALMA DE ODIO")
	print("="*60)
	await display_text("[...]", 2.0)
	await display_text("[...¿Dónde estoy?]", 2.0)
	await display_text("[La oscuridad es absoluta.]", 2.0)
	await display_text("[No puedo ver nada...]", 2.0)
	await display_text("[Solo siento... ODIO.]", 2.5)
	await display_text("[Un odio profundo, antiguo...]", 2.0)
	await display_text("[¿De dónde viene?]", 1.5)
	await display_text("[¿Es mío... o es algo más?]", 2.0)

func play_zone_1_fall() -> void:
	"""Cinemática de la caída en Zona 1"""
	print("\n" + "="*60)
	print("CINEMÁTICA: LA CAÍDA - ZONA 1")
	print("="*60)
	await display_text("[Caes.]", 1.0)
	await display_text("[Una caída interminable...]", 1.5)
	await display_text("[El viento rasga tu alma.]", 1.5)
	await display_text("[Segundos? ¿Minutos? ¿Horas?]", 2.0)
	await display_text("[Ya no lo sabes.]", 1.5)
	await display_text("[De repente...]", 1.0)
	await display_text("[IMPACTO.]", 2.0)
	await display_text("[Tu cuerpo golpea el suelo duro.]", 1.5)
	await display_text("[El dolor es... extraño. Casi placentero.]", 2.0)

func play_zone_2_discovery() -> void:
	"""Cinemática del descubrimiento de Zona 2"""
	print("\n" + "="*60)
	print("CINEMÁTICA: DESCUBRIMIENTO - ZONA 2")
	print("="*60)
	await display_text("[Avanzas lentamente por la caverna...]", 1.5)
	await display_text("[La neblina rosada es más densa aquí.]", 1.5)
	await display_text("[Tóxica. Venenosa. Deliciosa.]", 1.5)
	await display_text("[Tu alma resuena con ella.]", 1.5)
	await display_text("[Como si fueran lo mismo.]", 1.5)
	await display_text("[De pronto, el terreno cambia.]", 1.5)
	await display_text("[Plantas. Raíces. Vida distorsionada.]", 1.5)
	await display_text("[Algo está aquí. Lo sientes.]", 2.0)

func play_flowey_encounter() -> void:
	"""Cinemática del encuentro con Flowey"""
	print("\n" + "="*60)
	print("CINEMÁTICA: ENCUENTRO CON FLOWEY")
	print("="*60)
	await display_text("[En el centro del claro...]", 1.5)
	await display_text("[Una flor gigante.]", 1.0)
	await display_text("[Sus pétalos son rosa oscuro. Rojo sangre.]", 2.0)
	await display_text("[Está absolutamente inmóvil.]", 1.5)
	await display_text("[Pero sabes que te observa.]", 1.5)
	await display_text("[Lentamente...]", 1.0)
	await display_text("[Sus ojos se abren.]", 1.5)
	await display_text("[Dos esferas negras vacías.]", 1.5)
	await display_text("[Te están mirando directamente a TÍ.]", 2.0)
	await display_text("[Una sonrisa grotesca se forma.]", 1.5)
	await display_text("[...", 2.0)

func play_flowey_defeat() -> void:
	"""Cinemática de la derrota de Flowey"""
	print("\n" + "="*60)
	print("CINEMÁTICA: DERROTA DE FLOWEY")
	print("="*60)
	await display_text("[¡Lo hiciste!]", 1.5)
	await display_text("[La flor cae, sus pétalos se esparcen...]", 2.0)
	await display_text("[Su risa maléfica cesa abruptamente.]", 1.5)
	await display_text("[Las raíces se retraen en el suelo.]", 1.5)
	await display_text("[El jardín oscuro comienza a colapsar.]", 2.0)
	await display_text("[Una puerta aparece en el horizonte.]", 1.5)
	await display_text("[Hacia... los verdaderos horrores.]", 2.0)

func play_toriel_meeting() -> void:
	"""Cinemática del encuentro con Toriel"""
	print("\n" + "="*60)
	print("CINEMÁTICA: ENCUENTRO CON TORIEL - LA GUARDIANA RESENTIDA")
	print("="*60)
	await display_text("[Pasas por la puerta...]", 1.5)
	await display_text("[El paisaje cambia drásticamente.]", 1.5)
	await display_text("[Ruinas antiguas. Polvo de siglos.]", 1.5)
	await display_text("[Una sombra se mueve entre las piedras.]", 2.0)
	await display_text("[Una cabra roja. Enorme. Aterradora.]", 1.5)
	await display_text("[Sus ojos arden en llamas negras.]", 1.5)
	await display_text("[Habla con voz ronca y profunda...]", 1.5)
	await display_text("[Así que... otra alma.]", 2.0)

func play_bad_ending() -> void:
	"""Cinemática del final malo"""
	print("\n" + "="*60)
	print("CINEMÁTICA: FINAL MALO - EL ODIO CONSUMIDO")
	print("="*60)
	await display_text("[Tu cuerpo cae.]", 1.5)
	await display_text("[Las fuerzas te abandonan.]", 1.5)
	await display_text("[Tu alma... se desvanece lentamente.]", 2.0)
	await display_text("[Ves a tus enemigos riendo...]", 2.0)
	await display_text("[El odio fue tu perdición.]", 1.5)
	await display_text("[.
	.
	.
	]", 3.0)
	await display_text("[FIN]", 2.0)

func play_true_ending() -> void:
	"""Cinemática del final verdadero"""
	print("\n" + "="*60)
	print("CINEMÁTICA: FINAL VERDADERO - TRASCENDENCIA DEL ODIO")
	print("="*60)
	await display_text("[Lo lograste.]", 1.5)
	await display_text("[Todos tus enemigos han caído.]", 1.5)
	await display_text("[El odio que te consumía...]", 1.5)
	await display_text("[Se ha transformado en algo nuevo.]", 2.0)
	await display_text("[Una fuerza. Un propósito.]", 1.5)
	await display_text("[Las barreras alrededor tuyo se disuelven.]", 2.0)
	await display_text("[Eres libre.]", 2.0)
	await display_text("[Finalmente... eres libre.]", 2.0)

func display_text(text: String, duration: float = 1.0) -> void:
	"""Muestra texto con efecto de escritura"""
	print(text)
	dialogue_displayed.emit(text)
	await get_tree().create_timer(duration).timeout
