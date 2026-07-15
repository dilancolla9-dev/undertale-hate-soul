extends Node

class_name RouteManager

# Gestor de las 4 Rutas del Juego

var current_route: String = "neutral"
var killed_enemies: Array[String] = []
var spared_enemies: Array[String] = []
var total_enemy_count: int = 0
var players_kills: int = 0

signal route_changed(new_route: String)
signal ending_triggered(ending_name: String)

func _ready():
	print("[ROUTE] Sistema de rutas inicializado")
	total_enemy_count = 47  # Total de enemigos en el juego

func update_route(enemies_killed: int, enemies_spared: int) -> void:
	"""Actualiza la ruta basada en las acciones del jugador"""
	var kill_percentage = float(enemies_killed) / total_enemy_count * 100.0
	
	print("\n[ROUTE] Estadísticas:")
	print("[ROUTE] Enemigos Matados: ", enemies_killed, "/", total_enemy_count)
	print("[ROUTE] Enemigos Perdonados: ", enemies_spared)
	print("[ROUTE] Porcentaje de Matanzas: ", kill_percentage, "%")
	
	var old_route = current_route
	
	# Determinar ruta
	if kill_percentage == 100.0 and enemies_killed == total_enemy_count:
		current_route = "genocidio_real"
	elif kill_percentage >= 90.0:
		current_route = "genocida"
	elif kill_percentage >= 50.0:
		current_route = "neutral"
	else:
		current_route = "pacifista"
	
	if old_route != current_route:
		print("[ROUTE] ¡RUTA CAMBIADA! ", old_route, " -> ", current_route)
		route_changed.emit(current_route)

func trigger_ending() -> void:
	"""Dispara el final correspondiente a la ruta"""
	print("\n" + "="*60)
	print("FINAL: ", current_route.to_upper())
	print("="*60)
	
	match current_route:
		"pacifista":
			trigger_pacifist_ending()
		"neutral":
			trigger_neutral_ending()
		"genocida":
			trigger_genocidal_ending()
		"genocidio_real":
			trigger_true_genocide_ending()

func trigger_pacifist_ending() -> void:
	"""Final PACIFISTA - Piedad a todos"""
	print("\n[ENDING] FINAL PACIFISTA - LA COMPASIÓN")
	print("\nTu viaje terminó con misericordia.")
	print("Incluso en tu odio, elegiste no destruir.")
	print("Tus enemigos vieron la luz en tu alma rosa.")
	print("Y decidieron dejar de luchar.")
	print("\nAhora, el mundo roto se reconstruye.")
	print("Y tú eres el símbolo de esperanza.")
	print("\nFIN - FINAL VERDADERO")
	
	ending_triggered.emit("pacifist")

func trigger_neutral_ending() -> void:
	"""Final NEUTRAL - Decisiones Mixtas"""
	print("\n[ENDING] FINAL NEUTRAL - EL EQUILIBRIO")
	print("\nNo fuiste totalmente misericordioso.")
	print("Pero tampoco destruiste todo.")
	print("Tu odio estuvo balanceado con algo de compaéón.")
	print("\nAlgunos sobrevivieron. Otros no.")
	print("El mundo quedó en un estado liminal.")
	print("Ni redentor, ni condenado.")
	print("\nJusto... neutral.")
	print("\nFIN - FINAL NORMAL")
	
	ending_triggered.emit("neutral")

func trigger_genocidal_ending() -> void:
	"""Final GENOCIDA - Destrucción Masiva"""
	print("\n[ENDING] FINAL GENOCIDA - LA MASACRE")
	print("\nDejaste un rastro de destrucción.")
	print("Casi todo fue aniquilado por tu odio.")
	print("\nLos sobrevivientes viven en el miedo.")
	print("Su mundo es ahora una ruina.")
	print("Y tú, el Único que quedó de pie.")
	print("\nSolo en la desolación que creaste.")
	print("\nFIN - FINAL MALO")
	
	ending_triggered.emit("genocidal")

func trigger_true_genocide_ending() -> void:
	"""Final GENOCIDIO REAL - La Verdad Absoluta"""
	print("\n" + "*"*60)
	print("FINAL OCULTO - GENOCIDIO REAL - LA VERDAD INFINITA")
	print("*"*60)
	print("\nMataste a todos.")
	print("Literalmente. TODOS.")
	print("\nAhora el mundo es tuyo.")
	print("Pero está vacío.")
	print("\n[LA PANTALLA SE VUELVE NEGRA]")
	print("\nUna voz resuena en la negrura:")
	print("\n\"Ya viste todo. Ya hiciste todo.")
	print("Ya mataste a todos.\"")
	print("\n\"Solo queda... TU ODIO.\"")
	print("\n\"Y es... HERMOSO.\"")
	print("\n[FIN - FINAL SECRETO]")
	print("\n\"Te volveré a ver... en la siguiente carga.\"")
	print("*"*60)
	
	ending_triggered.emit("true_genocide")

func display_route_info() -> void:
	"""Muestra información de la ruta actual"""
	print("\nRuta Actual: ", current_route.to_upper())
	print("Enemigos Matados: ", killed_enemies.size())
	print("Enemigos Perdonados: ", spared_enemies.size())
