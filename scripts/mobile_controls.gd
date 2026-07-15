extends Node

class_name MobileControls

# Sistema de controles optimizado para móvil y desktop

var is_mobile = false
var button_size = Vector2(80, 80)
var touch_input_active = false
var joystick_active = false
var joystick_center = Vector2.ZERO
var current_input_direction = Vector2.ZERO

signal movement_input(direction: Vector2)
signal action_input(action: String)
signal menu_input(option: String)

func _ready():
	is_mobile = OS.get_name() in ["Android", "iOS"]
	print("[CONTROLS] Sistema de controles inicializado")
	print("[CONTROLS] Móvil: ", is_mobile)

func _input(event: InputEvent):
	if not is_mobile:
		handle_desktop_input(event)
	else:
		handle_mobile_input(event)

func handle_desktop_input(event: InputEvent) -> void:
	"""Maneja entrada de teclado/mouse en desktop"""
	if event is InputEventKey:
		var key_event = event as InputEventKey
		if key_event.pressed:
			match key_event.keycode:
				KEY_UP, KEY_W:
					movement_input.emit(Vector2.UP)
				KEY_DOWN, KEY_S:
					movement_input.emit(Vector2.DOWN)
				KEY_LEFT, KEY_A:
					movement_input.emit(Vector2.LEFT)
				KEY_RIGHT, KEY_D:
					movement_input.emit(Vector2.RIGHT)
				KEY_Z, KEY_ENTER:
					action_input.emit("select")
				KEY_X, KEY_ESCAPE:
					action_input.emit("cancel")
				KEY_SPACE:
					action_input.emit("interact")
				KEY_P:
					action_input.emit("pause")

func handle_mobile_input(event: InputEvent) -> void:
	"""Maneja entrada táctil en móvil"""
	if event is InputEventScreenTouch:
		var touch = event as InputEventScreenTouch
		if touch.pressed:
			handle_touch_press(touch.position)
		else:
			handle_touch_release()
	
elif event is InputEventScreenDrag:
		var drag = event as InputEventScreenDrag
		handle_touch_drag(drag.position)

func handle_touch_press(position: Vector2) -> void:
	"""Maneja presión de pantalla táctil"""
	touch_input_active = true
	joystick_center = position
	print("[TOUCH] Toque en: ", position)

func handle_touch_drag(position: Vector2) -> void:
	"""Maneja deslizamiento en pantalla táctil"""
	if not touch_input_active:
		return
	
	var delta = position - joystick_center
	var distance = delta.length()
	
	if distance > 30:  # Dead zone
		var direction = delta.normalized()
		
		# Snap a 4 direcciones
		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				movement_input.emit(Vector2.RIGHT)
			else:
				movement_input.emit(Vector2.LEFT)
		else:
			if direction.y > 0:
				movement_input.emit(Vector2.DOWN)
			else:
				movement_input.emit(Vector2.UP)

func handle_touch_release() -> void:
	"""Maneja liberación de pantalla táctil"""
	touch_input_active = false
	joystick_active = false
	print("[TOUCH] Liberado")

func create_mobile_buttons() -> void:
	"""Crea botones virtuales para móvil"""
	print("[CONTROLS] Creando botones virtuales para móvil...")
	print("[CONTROLS] Botón Arriba (↑)")
	print("[CONTROLS] Botón Abajo (↓)")
	print("[CONTROLS] Botón Izquierda (←)")
	print("[CONTROLS] Botón Derecha (→)")
	print("[CONTROLS] Botón A (Aceptar)")
	print("[CONTROLS] Botón B (Cancelar)")
	print("[CONTROLS] Botón PAUSA")
