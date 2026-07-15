extends CharacterBody2D

class_name HateSoul

# Propiedades del jugador - Alma de Odio
var speed = 150.0
var soul_name = "Hate Soul"
var soul_color = Color(1.0, 0.0, 1.0)  # Magenta/Rosa
var max_hp = 20
var current_hp = 20
var is_moving = false

# Referencias
var ghost_companion: Node2D
var sprite_2d: Sprite2D
var animation_player: AnimationPlayer

func _ready():
	print("[PLAYER] Jugador creado: ", soul_name)
	print("[PLAYER] Alma: ", soul_color)
	print("[PLAYER] HP: ", current_hp, "/", max_hp)
	
func _physics_process(delta):
	var input_vector = Vector2.ZERO
	
	# Entrada del jugador - Movimiento en 4 direcciones
	if Input.is_action_pressed("ui_right"):
		input_vector.x += 1
	if Input.is_action_pressed("ui_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("ui_down"):
		input_vector.y += 1
	if Input.is_action_pressed("ui_up"):
		input_vector.y -= 1
	
	input_vector = input_vector.normalized()
	velocity = input_vector * speed
	move_and_slide()
	
	is_moving = input_vector.length() > 0

func take_damage(damage: int) -> void:
	current_hp -= damage
	print("[PLAYER] ¡Ouch! HP: ", current_hp, "/", max_hp)
	
func heal(amount: int) -> void:
	current_hp = min(current_hp + amount, max_hp)
	print("[PLAYER] Curado. HP: ", current_hp, "/", max_hp)
