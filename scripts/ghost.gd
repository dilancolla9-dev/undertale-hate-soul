extends Node2D

class_name GhostCompanion

# Propiedades del fantasma compañero
var color = Color(1.0, 0.5, 0.75)  # Rosado-rojizo
var follow_distance = 30.0
var player: Node2D
var is_following = true
var opacity = 0.8

func _ready():
	print("[GHOST] Fantasma compañero creado")
	print("[GHOST] Color: Rosado-Rojizo")

func _process(delta):
	if player and is_following:
		follow_player()

func follow_player():
	if player:
		var direction = (player.global_position - global_position).normalized()
		var distance = global_position.distance_to(player.global_position)
		
		if distance > follow_distance:
			global_position += direction * 150.0 * get_physics_process_delta_time()

func set_player(p: Node2D):
	player = p

func speak(text: String):
	print("[GHOST] ", text)
