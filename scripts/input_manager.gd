extends Node2D

class_name InputManager

# Gestor de Controles para PC y Móvil

var is_mobile = OS.get_name() in ["Android", "iOS"]
var current_action = ""
var touch_positions: Dictionary = {}

signal action_pressed(action: String)
signal action_released(action: String)
signal touch_input(position: Vector2)

func _ready():
	print("[INPUT] Sistema de controles inicializado")
	print("[INPUT] Plataforma: ", "MÓVIL" if is_mobile else "PC")
	
	if is_mobile:
		setup_mobile_controls()
	else:
		setup_pc_controls()

func setup_mobile_controls() -> void:
	"""Configura los controles táctiles para móvil"""
	print("[INPUT] Configurando controles táctiles...")
	
	# Los toques se capturan en _input()

func setup_pc_controls() -> void:
	"""Configura los controles de teclado para PC"""
	print("[INPUT] Configurando controles de teclado...")
	
	# Usar InputMap de Godot

func _input(event: InputEvent) -> void:
	if is_mobile and event is InputEventScreenTouch:
		handle_touch_input(event)
	elif event is InputEventKey and event.pressed:
		handle_keyboard_input(event)

func handle_touch_input(event: InputEventScreenTouch) -> void:
	"""Maneja entrada táctil"""
	if event.pressed:
		var position = event.position
		var screen_size = get_viewport().get_visible_rect().size
		
		# Dividir pantalla en zonas
		if position.y < screen_size.y / 3:
			# Zona superior
			if position.x < screen_size.x / 2:
				handle_action("up_left")
			else:
				handle_action("up_right")
		elif position.y > screen_size.y * 2 / 3:
			# Zona inferior
			if position.x < screen_size.x / 2:
				handle_action("down_left")
			else:
				handle_action("down_right")
		else:
			# Zona central
			if position.x < screen_size.x / 3:
				handle_action("move_left")
			elif position.x > screen_size.x * 2 / 3:
				handle_action("move_right")
			else:
				handle_action("select")
	
		touch_input.emit(position)
else:
		# Dedo levantado
		handle_action("release")

func handle_keyboard_input(event: InputEventKey) -> void:
	"""Maneja entrada de teclado"""
	match event.keycode:
		KEY_UP:
			handle_action("move_up")
		KEY_DOWN:
			handle_action("move_down")
		KEY_LEFT:
			handle_action("move_left")
		KEY_RIGHT:
			handle_action("move_right")
		KEY_Z:
			handle_action("select")
		KEY_X:
			handle_action("cancel")
		KEY_ESCAPE:
			handle_action("pause")
		KEY_I:
			handle_action("inventory")

func handle_action(action: String) -> void:
	"""Procesa una acción"""
	current_action = action
	print("[INPUT] Acción: ", action)
	action_pressed.emit(action)
