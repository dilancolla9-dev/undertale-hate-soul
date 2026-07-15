extends Node2D

class_name GameManager

# Gestor general del juego

var is_running = false
var current_zone = 1
var player_level = 1
var player_experience = 0

func _ready():
	print("\n" + "="*50)
	print("UNDERTALE: HATE SOUL")
	print("El Alma de Odio despierta...")
	print("="*50 + "\n")
	
	print("[GAME] Inicializando juego...")
	print("[GAME] Zona Actual: ", current_zone)
	print("[GAME] Nivel: ", player_level)
	
	# Inicializar sprites procedurales
	var sprite_gen = ProceduralSpriteGenerator.new()
	var player_sprite = sprite_gen.create_hate_soul_sprite()
	var flowey_sprite = sprite_gen.create_flowey_sprite()
	var ghost_sprite = sprite_gen.create_ghost_companion_sprite()
	
	print("[GAME] Sprites procedurales generados exitosamente")
	
	# Inicializar tilesets
	var tileset_gen = ProceduralTilesetGenerator.new()
	var zone1_tileset = tileset_gen.create_zone1_tileset()
	var zone2_tileset = tileset_gen.create_zone2_tileset()
	
	print("[GAME] Tilesets procedurales generados exitosamente")
	
	# Inicializar personajes
	print("\n[GAME] Personajes disponibles:")
	var characters = ReinterpretedCharacters.get_all_characters()
	for char in characters:
		var char_data = ReinterpretedCharacters.get_character_data(char)
		print("  - ", char_data.name)
	
	print("\n[GAME] ¡El juego ha iniciado!")

func _process(delta):
	pass

func load_zone(zone_number: int):
	current_zone = zone_number
	print("\n[GAME] Cargando Zona ", zone_number)
	
	match zone_number:
		1:
			print("[ZONE 1] LA CAÍDA")
			print("[ZONE 1] Caes a través de la oscuridad...")
			print("[ZONE 1] Neblina rosada envuelve todo...")
		
		2:
			print("[ZONE 2] JARDÍN OSCURO")
			print("[ZONE 2] Una flor carnívora te espera...")
			print("[ZONE 2] ¡FLOWEY APARECE!")

func add_experience(amount: int):
	player_experience += amount
	var experience_for_next_level = player_level * 100
	
	if player_experience >= experience_for_next_level:
		level_up()

func level_up():
	player_level += 1
	player_experience = 0
	print("[GAME] ¡NIVEL SUBIÓ! Ahora eres nivel ", player_level)
