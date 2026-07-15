extends Node

class_name RouteSystem

# Sistema de rutas: Pacifista, Neutral, Genocida, Genocidio Real

var current_route = "none"
var pacifist_acts = 0  # Actos de piedad
var violent_acts = 0   # Actos violentos
var neutral_points = 0 # Puntos neutrales

var route_progress = {
	"pacifist": 0.0,
	"neutral": 0.0,
	"genocidal": 0.0,
	"true_genocide": 0.0
}

signal route_changed(new_route: String)
signal route_locked(route_name: String)

func _ready():
	print("[ROUTES] Sistema de rutas inicializado")

func record_action(action_type: String, value: int = 1) -> void:
	"""Registra una acción que afecta la ruta"""
	match action_type:
		"pacifist":
			pacifist_acts += value
			route_progress["pacifist"] += 5.0
			print("[ROUTE] +5% Ruta Pacifista")
		"violent":
			violent_acts += value
			route_progress["genocidal"] += 5.0
			print("[ROUTE] +5% Ruta Genocida")
		"neutral":
			neutral_points += value
			route_progress["neutral"] += 3.0
			print("[ROUTE] +3% Ruta Neutral")
	
	check_route_lock()

func check_route_lock() -> void:
	"""Verifica si se bloquea una ruta"""
	# Si mataste 10+ enemigos, Pacifista está bloqueada
	if violent_acts >= 10:
		if current_route == "pacifist":
			print("[ROUTE] ¡La ruta Pacifista ha sido bloqueada!")
			route_locked.emit("pacifist")
			current_route = "neutral"

func determine_final_route() -> String:
	"""Determina la ruta final al completar el juego"""
	print("\n" + "="*60)
	print("DETERMINANDO RUTA FINAL...")
	print("="*60)
	print("Actos Pacíficos: ", pacifist_acts)
	print("Actos Violentos: ", violent_acts)
	print("Puntos Neutrales: ", neutral_points)
	
	if violent_acts >= 80:  # Casi todos los enemigos asesinados
		if pacifist_acts == 0:  # Ningún acto de piedad
			current_route = "true_genocide"
			print("\n>>> RUTA DESBLOQUEADA: GENOCIDIO REAL <<<")
		else:
			current_route = "genocidal"
			print("\n>>> RUTA: GENOCIDA <<<")
	elif violent_acts >= 30:
		current_route = "genocidal"
		print("\n>>> RUTA: GENOCIDA <<<")
	elif pacifist_acts >= 30:
		current_route = "pacifist"
		print("\n>>> RUTA: PACIFISTA <<<")
	else:
		current_route = "neutral"
		print("\n>>> RUTA: NEUTRAL <<<")
	
	print("="*60 + "\n")
	route_changed.emit(current_route)
	return current_route

func get_route_description() -> String:
	"""Retorna descripción de la ruta actual"""
	match current_route:
		"pacifist":
			return "Ruta Pacifista: El camino de la piedad y la compasión"
		"neutral":
			return "Ruta Neutral: El camino del equilibrio"
		"genocidal":
			return "Ruta Genocida: El camino del odio y la destrucción"
		"true_genocide":
			return "Ruta Genocidio Real: El camino del VERDADERO ODIO"
		_:
			return "Ruta Desconocida"

func display_route_status() -> void:
	"""Muestra el estado de todas las rutas"""
	print("\n" + "="*60)
	print("ESTADO DE RUTAS")
	print("="*60)
	for route in route_progress:
		var progress = route_progress[route]
		var bar = "[" + "="*int(progress/5) + "-"*(20-int(progress/5)) + "] "
		print(route.to_upper() + " " + bar + str(int(progress)) + "%")
	print("\nRuta Actual: ", current_route.to_upper())
	print("="*60 + "\n")
