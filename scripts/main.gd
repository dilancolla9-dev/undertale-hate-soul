extends Node

class_name Main

# Script principal que integra TODO el sistema del juego

# Managers
var game_manager: GameManager
var audio_manager: AudioManager
var ui_manager: UIManager
var save_system: SaveSystem
var inventory_system: InventorySystem
var stats_system: StatsSystem
var combat_system: CombatSystem
var route_system: RouteSystem
var mobile_controls: MobileControls
var cinematic_controller: CinematicController
var additional_zones: AdditionalZones
var sprite_generator: ProceduralSpriteGenerator
var tileset_generator: ProceduralTilesetGenerator
var dialogue_system: DialogueSystem
var reinterpreted_characters: ReinterpretedCharacters

var is_game_running = false
var is_paused = false

func _ready():
	print("\n" + "="*70)
	print("UNDERTALE: HATE SOUL - INICIALIZANDO SISTEMA COMPLETO")
	print("="*70 + "\n")
	
	# Inicializar todos los managers
	initialize_managers()
	
	# Mostrar menú principal
	show_main_menu()

func initialize_managers() -> void:
	"""Inicializa todos los sistemas del juego"""
	print("[MAIN] Inicializando managers...\n")
	
	# Crear instancias de todos los sistemas
	game_manager = GameManager.new()
	audio_manager = AudioManager.new()
	ui_manager = UIManager.new()
	save_system = SaveSystem.new()
	inventory_system = InventorySystem.new()
	stats_system = StatsSystem.new()
	combat_system = CombatSystem.new()
	route_system = RouteSystem.new()
	mobile_controls = MobileControls.new()
	cinematic_controller = CinematicController.new()
	additional_zones = AdditionalZones.new()
	sprite_generator = ProceduralSpriteGenerator.new()
	tileset_generator = ProceduralTilesetGenerator.new()
	dialogue_system = DialogueSystem.new()
	reinterpreted_characters = ReinterpretedCharacters.new()
	
	# Añadir nodos al árbol
	add_child(game_manager)
	add_child(audio_manager)
	add_child(ui_manager)
	add_child(save_system)
	add_child(inventory_system)
	add_child(stats_system)
	add_child(combat_system)
	add_child(route_system)
	add_child(mobile_controls)
	add_child(cinematic_controller)
	add_child(additional_zones)
	
	print("[MAIN] ✅ Todos los managers inicializados\n")

func show_main_menu() -> void:
	"""Muestra el menú principal"""
	ui_manager.show_main_menu()
	
	print("[MAIN] ¿Qué deseas hacer?")
	print("(Escribe: new, load, settings, credits, quit)\n")

func start_new_game() -> void:
	"""Inicia un nuevo juego"""
	print("\n[MAIN] Iniciando nuevo juego...\n")
	
	is_game_running = true
	game_manager.is_running = true
	
	# Generar sprites procedurales
	print("[MAIN] Generando sprites procedurales...")
	var player_sprite = sprite_generator.create_hate_soul_sprite()
	var flowey_sprite = sprite_generator.create_flowey_sprite()
	var ghost_sprite = sprite_generator.create_ghost_companion_sprite()
	print("[MAIN] ✅ Sprites generados\n")
	
	# Generar tilesets
	print("[MAIN] Generando tilesets...")
	var zone1_tileset = tileset_generator.create_zone1_tileset()
	var zone2_tileset = tileset_generator.create_zone2_tileset()
	print("[MAIN] ✅ Tilesets generados\n")
	
	# Reproducir música de intro
	audio_manager.play_music("zone_1_ambience")
	
	# Mostrar cinemática de intro
	await cinematic_controller.play_cinematic("intro_awakening")
	await cinematic_controller.play_cinematic("zone_1_fall")
	
	# Cargar Zona 1
	load_zone(1)

func load_zone(zone_number: int) -> void:
	"""Carga una zona del juego"""
	print("\n[MAIN] Cargando Zona ", zone_number, "...\n")
	game_manager.load_zone(zone_number)
	
	match zone_number:
		1:
			await cinematic_controller.play_cinematic("zone_1_fall")
		2:
			await cinematic_controller.play_cinematic("zone_2_discovery")
			await cinematic_controller.play_cinematic("flowey_encounter")
			start_boss_fight("Flowey - La Planta Carnívora", 80)
		3:
			additional_zones.load_zone("zone_3_mines")
			var alphys_data = reinterpreted_characters.get_character_data("alphys_hate")
			start_boss_fight(alphys_data.name, alphys_data.hp)
		4:
			additional_zones.load_zone("zone_4_tower")
			var mettaton_data = reinterpreted_characters.get_character_data("mettaton_hate")
			start_boss_fight(mettaton_data.name, mettaton_data.hp)
		5:
			additional_zones.load_zone("zone_5_castle")
			var asgore_data = reinterpreted_characters.get_character_data("asgore_hate")
			start_boss_fight(asgore_data.name, asgore_data.hp)

func start_boss_fight(boss_name: String, boss_hp: int) -> void:
	"""Inicia un combate de jefe"""
	print("\n" + "="*70)
	print("COMBATE: ", boss_name)
	print("="*70 + "\n")
	
	ui_manager.show_combat_ui(boss_name, boss_hp, stats_system.player_stats["current_hp"])
	
	var enemy_data = {
		"name": boss_name,
		"max_hp": boss_hp,
		"attack_power": 8,
		"defense": 2,
		"attack_pattern": [5, 6, 7, 8]
	}
	
	combat_system.start_combat(enemy_data)
	
	# Simular combate
	await combat_system.player_attack(stats_system.calculate_damage(5))

func handle_player_choice(choice: String) -> void:
	"""Maneja las decisiones del jugador que afectan la ruta"""
	match choice:
		"kill":
			route_system.record_action("violent")
			audio_manager.play_sfx("attack")
		"spare":
			route_system.record_action("pacifist")
			audio_manager.play_sfx("heal")
		"talk":
			route_system.record_action("neutral")
			audio_manager.play_sfx("menu_select")

func show_ending(route: String) -> void:
	"""Muestra el final correspondiente a la ruta"""
	print("\n" + "="*70)
	print("DETERMINANDO FINAL...")
	print("="*70 + "\n")
	
	var final_route = route_system.determine_final_route()
	
	match final_route:
		"pacifist":
			await cinematic_controller.play_cinematic("true_ending")
			audio_manager.play_music("victory")
		"neutral":
			print("[ENDING] Has completado el juego en ruta Neutral.")
			print("[ENDING] No todos fueron perdonados, ni todos fueron destruidos.")
		"genocidal":
			print("[ENDING] Has elegido la destrucción.")
			print("[ENDING] El odio te consumó completamente.")
			audio_manager.play_music("defeat")
		"true_genocide":
			await cinematic_controller.play_cinematic("true_ending")
			print("\n" + "="*70)
			print("CARGA...")
			print(".
			.
			.")
			await get_tree().create_timer(2.0).timeout
			print("\nNo hay nada que cargar.")
			print("Eliminaste TODO.")
			print("\nLos archivos de guardado se borraron.")
			print("\n... Espero que hayas aprendido algo.")
			print("="*70 + "\n")

func pause_game() -> void:
	"""Pausa el juego"""
	is_paused = true
	get_tree().paused = true
	ui_manager.show_pause_menu()

func resume_game() -> void:
	"""Reanuda el juego"""
	is_paused = false
	get_tree().paused = false

func save_game(slot: int = 0) -> void:
	"""Guarda el juego"""
	var game_data = save_system.create_game_data(game_manager, inventory_system)
	save_system.save_game(game_data, slot)

func load_game(slot: int = 0) -> void:
	"""Carga el juego"""
	var game_data = save_system.load_game(slot)
	if not game_data.is_empty():
		print("[MAIN] Juego cargado exitosamente")
		print("[MAIN] Nivel: ", game_data.get("level"))
		print("[MAIN] Zona: ", game_data.get("zone"))

func quit_game() -> void:
	"""Sale del juego"""
	print("\n[MAIN] ¡Gracias por jugar UNDERTALE: HATE SOUL!")
	print("[MAIN] Ruta completada: ", route_system.current_route)
	get_tree().quit()

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if is_game_running and not is_paused:
			pause_game()
		elif is_paused:
			resume_game()
