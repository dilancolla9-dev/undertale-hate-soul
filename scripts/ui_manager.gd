extends CanvasLayer

class_name UIManager

# Gestor de Interfaz para PC y Móvil

var is_mobile = OS.get_name() in ["Android", "iOS"]
var screen_size = get_viewport().get_visible_rect().size
var current_menu = "main"
var ui_elements: Dictionary = {}

signal menu_opened(menu_name: String)
signal menu_closed(menu_name: String)
signal button_pressed(button_name: String)

func _ready():
	print("[UI] Sistema de UI inicializado")
	print("[UI] Plataforma detectada: ", "MÓVIL" if is_mobile else "PC")
	print("[UI] Resolución: ", screen_size)
	
	if is_mobile:
		setup_mobile_ui()
	else:
		setup_pc_ui()

func setup_mobile_ui() -> void:
	"""Configura la UI para celular"""
	print("[UI] Configurando interfaz para MÓVIL...")
	
	# Botónes más grandes para táctil
	var button_size = Vector2(150, 80)
	var button_spacing = 20
	
	# Menú Principal
	ui_elements["btn_play"] = {
		"position": Vector2(screen_size.x / 2 - button_size.x / 2, screen_size.y / 3),
		"size": button_size,
		"text": "JUGAR"
	}
	
	ui_elements["btn_inventory"] = {
		"position": Vector2(screen_size.x / 2 - button_size.x / 2, screen_size.y / 3 + button_size.y + button_spacing),
		"size": button_size,
		"text": "INVENTARIO"
	}
	
	ui_elements["btn_settings"] = {
		"position": Vector2(screen_size.x / 2 - button_size.x / 2, screen_size.y / 3 + (button_size.y + button_spacing) * 2),
		"size": button_size,
		"text": "OPCIONES"
	}
	
	ui_elements["btn_load"] = {
		"position": Vector2(screen_size.x / 2 - button_size.x / 2, screen_size.y / 3 + (button_size.y + button_spacing) * 3),
		"size": button_size,
		"text": "CARGAR"
	}
	
	print("[UI] Interfaz móvil configurada")

func setup_pc_ui() -> void:
	"""Configura la UI para PC"""
	print("[UI] Configurando interfaz para PC...")
	
	var button_size = Vector2(200, 50)
	var button_spacing = 15
	
	ui_elements["btn_play"] = {
		"position": Vector2(screen_size.x / 2 - button_size.x / 2, screen_size.y / 2 - 100),
		"size": button_size,
		"text": "JUGAR"
	}
	
	ui_elements["btn_inventory"] = {
		"position": Vector2(screen_size.x / 2 - button_size.x / 2, screen_size.y / 2 - 30),
		"size": button_size,
		"text": "INVENTARIO"
	}
	
	ui_elements["btn_settings"] = {
		"position": Vector2(screen_size.x / 2 - button_size.x / 2, screen_size.y / 2 + 40),
		"size": button_size,
		"text": "OPCIONES"
	}
	
	ui_elements["btn_load"] = {
		"position": Vector2(screen_size.x / 2 - button_size.x / 2, screen_size.y / 2 + 110),
		"size": button_size,
		"text": "CARGAR"
	}
	
	print("[UI] Interfaz PC configurada")

func open_menu(menu_name: String) -> void:
	"""Abre un menú"""
	current_menu = menu_name
	print("[UI] Abriendo menú: ", menu_name)
	
	match menu_name:
		"main":
			display_main_menu()
		"settings":
			display_settings_menu()
		"inventory":
			display_inventory_menu()
		"save":
			display_save_menu()
		"load":
			display_load_menu()
		"combat":
			display_combat_menu()
		"pause":
			display_pause_menu()
	
	menu_opened.emit(menu_name)

func display_main_menu() -> void:
	"""Muestra el menú principal"""
	print("\n" + "="*50)
	print("MENÚ PRINCIPAL")
	print("="*50)
	print("[1] JUGAR")
	print("[2] INVENTARIO")
	print("[3] OPCIONES")
	print("[4] CARGAR")
	print("[5] SALIR")
	print("="*50 + "\n")

func display_settings_menu() -> void:
	"""Muestra el menú de configuración"""
	print("\n" + "="*50)
	print("OPCIONES")
	print("="*50)
	print("[1] VOLÚM ENES")
	print("  - Música: 70%")
	print("  - Efectos: 80%")
	print("  - General: 100%")
	print("[2] PANTALLA")
	print("  - Resolución: ", screen_size)
	print("  - Modo: ", "MÓVIL" if is_mobile else "ESCRITORIO")
	print("[3] CONTROLES")
	print("[4] ATRÁS")
	print("="*50 + "\n")

func display_inventory_menu() -> void:
	"""Muestra el menú de inventario"""
	print("\n" + "="*50)
	print("INVENTARIO")
	print("="*50)
	print("[Aquí se mostrará el inventario]")
	print("="*50 + "\n")

func display_save_menu() -> void:
	"""Muestra el menú de guardado"""
	print("\n" + "="*50)
	print("GUARDAR PARTIDA")
	print("="*50)
	print("[Selecciona una ranura de guardado]")
	print("="*50 + "\n")

func display_load_menu() -> void:
	"""Muestra el menú de carga"""
	print("\n" + "="*50)
	print("CARGAR PARTIDA")
	print("="*50)
	print("[Partidas disponibles:]")
	print("="*50 + "\n")

func display_combat_menu() -> void:
	"""Muestra el menú de combate"""
	print("\n" + "-"*50)
	print("ACCIONES DE COMBATE")
	print("-"*50)
	print("[1] ATACAR")
	print("[2] DEFENDER")
	print("[3] OBJETO")
	print("[4] HUIR")
	print("-"*50 + "\n")

func display_pause_menu() -> void:
	"""Muestra el menú de pausa"""
	print("\n" + "="*50)
	print("PAUSA")
	print("="*50)
	print("[1] REANUDAR")
	print("[2] INVENTARIO")
	print("[3] GUARDAR")
	print("[4] OPCIONES")
	print("[5] MENÚ PRINCIPAL")
	print("="*50 + "\n")

func close_menu() -> void:
	"""Cierra el menú actual"""
	print("[UI] Cerrando menú: ", current_menu)
	menu_closed.emit(current_menu)
	current_menu = ""

func show_hud_combat() -> void:
	"""Muestra el HUD durante el combate"""
	print("\n[HUD] Mostrando interfaz de combate...")
	print("Tu HP: [=======] 20/20")
	print("Enemigo HP: [===-----] 15/25")
	print("\nAcciones disponibles: ATACAR | DEFENDER | OBJETO | HUIR\n")

func show_dialogue_box(character: String, text: String) -> void:
	"""Muestra una caja de diálogo"""
	print("\n" + "="*50)
	print("[", character, "]")
	print(text)
	print("="*50 + "\n")

func show_notification(text: String, duration: float = 2.0) -> void:
	"""Muestra una notificación"""
	print("[NOTIFICACIÓN] ", text)

func show_choice_dialog(title: String, choices: Array[String]) -> void:
	"""Muestra un diálogo de elección"""
	print("\n" + "="*50)
	print(title)
	print("="*50)
	for i in range(choices.size()):
		print("[", i + 1, "] ", choices[i])
	print("="*50 + "\n")
