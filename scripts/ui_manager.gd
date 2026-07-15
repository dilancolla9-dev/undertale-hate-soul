extends Control

class_name UIManager

# Gestor de interfaz de usuario adaptable a móvil y desktop

var is_mobile = false
var current_screen = "main_menu"
var touch_enabled = true
var ui_scale = 1.0

signal menu_option_selected(option: String)
signal combat_action_selected(action: String)
signal pause_toggled(paused: bool)

func _ready():
	detect_platform()
	print("[UI] Gestor de UI inicializado")
	print("[UI] Plataforma: ", "MÓVIL" if is_mobile else "DESKTOP")

func detect_platform() -> void:
	"""Detecta si es móvil o desktop"""
	if OS.get_name() in ["Android", "iOS"]:
		is_mobile = true
		ui_scale = 1.2
		print("[UI] Plataforma detectada: MÓVIL")
	else:
		is_mobile = false
		ui_scale = 1.0
		print("[UI] Plataforma detectada: DESKTOP")

func show_main_menu() -> void:
	"""Muestra el menú principal"""
	current_screen = "main_menu"
	print("\n" + "="*60)
	print("MENÚ PRINCIPAL - UNDERTALE: HATE SOUL")
	print("="*60)
	print("\n[OPCIONES]")
	print("  1. NUEVO JUEGO")
	print("  2. CARGAR JUEGO")
	print("  3. CONFIGURACIÓN")
	print("  4. CRÉDITOS")
	print("  5. SALIR")
	print("\n" + "="*60 + "\n")

func show_pause_menu() -> void:
	"""Muestra el menú de pausa"""
	current_screen = "pause_menu"
	print("\n" + "="*60)
	print("MENÚ DE PAUSA")
	print("="*60)
	print("\n[OPCIONES]")
	print("  1. REANUDAR")
	print("  2. GUARDAR")
	print("  3. CARGAR")
	print("  4. CONFIGURACIÓN")
	print("  5. MENÚ PRINCIPAL")
	print("\n" + "="*60 + "\n")

func show_combat_ui(enemy_name: String, enemy_hp: int, player_hp: int) -> void:
	"""Muestra la interfaz de combate"""
	current_screen = "combat"
	print("\n" + "="*60)
	print("COMBATE - UNDERTALE: HATE SOUL")
	print("="*60)
	print("\nEnemigo: ", enemy_name, " | HP: ", enemy_hp)
	print("Tu HP: ", player_hp)
	print("\n[ACCIONES]")
	print("  A. ATACAR")
	print("  B. DEFENDER")
	print("  C. OBJETO")
	print("  D. HUIR")
	print("\n" + "="*60 + "\n")

func show_inventory_ui(inventory_system: InventorySystem) -> void:
	"""Muestra el inventario"""
	current_screen = "inventory"
	inventory_system.display_inventory()

func show_dialogue_box(character: String, text: String) -> void:
	"""Muestra una caja de diálogo"""
	print("\n" + "="*60)
	print(character.to_upper())
	print("="*60)
	print("\n", text)
	print("\n" + "="*60 + "\n")

func show_stats_screen(game_manager: GameManager) -> void:
	"""Muestra pantalla de estadísticas"""
	print("\n" + "="*60)
	print("ESTADÍSTICAS")
	print("="*60)
	print("\nNivel: ", game_manager.player_level)
	print("Zona: ", game_manager.current_zone)
	print("Ruta: ", game_manager.current_route)
	print("Estadística de Odio: ", game_manager.hate_stat, "%")
	print("Actos Pacíficos: ", game_manager.pacifist_acts)
	print("Actos Violentos: ", game_manager.violent_acts)
	print("\n" + "="*60 + "\n")

func handle_touch_input(event: InputEvent) -> void:
	"""Maneja entrada táctil en móvil"""
	if not is_mobile:
		return
	
	if event is InputEventScreenTouch:
		var touch_event = event as InputEventScreenTouch
		if touch_event.pressed:
			print("[UI] Touch en posición: ", touch_event.position)
	
func handle_swipe_input(from: Vector2, to: Vector2) -> void:
	"""Detecta gestos de deslizamiento"""
	var delta = to - from
	
	if abs(delta.x) > abs(delta.y):
		if delta.x > 0:
			print("[UI] Gesto: Deslizar a la DERECHA")
		else:
			print("[UI] Gesto: Deslizar a la IZQUIERDA")
	else:
		if delta.y > 0:
			print("[UI] Gesto: Deslizar hacia ABAJO")
		else:
			print("[UI] Gesto: Deslizar hacia ARRIBA")
