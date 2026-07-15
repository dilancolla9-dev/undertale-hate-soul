extends Node2D

class_name AdditionalZones

# Controlador de zonas adicionales: Minas, Torre, Castillo

var current_zone = ""
var zone_data = {}

func _ready():
	print("[ZONES] Sistema de zonas adicionales inicializado")

func load_zone(zone_name: String) -> void:
	"""Carga una zona específica"""
	current_zone = zone_name
	
	match zone_name:
		"zone_3_mines":
			load_zone_3_mines()
		"zone_4_tower":
			load_zone_4_tower()
		"zone_5_castle":
			load_zone_5_castle()
		"zone_secret_void":
			load_zone_secret_void()
		_:
			print("[ZONES] Zona desconocida: ", zone_name)

func load_zone_3_mines() -> void:
	"""Zona 3: Las Minas Oscuras"""
	print("\n" + "="*60)
	print("ZONA 3: LAS MINAS OSCURAS")
	print("="*60)
	print("\n[Descripción]")
	print("Profundas minas excavadas en la roca negra.")
	print("Minerales que brillan con luz roja oscura.")
	print("El aire es pesado, tóxico, lleno de peligro.")
	print("\n[Enemigos]")
	print("  - Minero Corrompido (HP: 35)")
	print("  - Golem de Piedra Oscura (HP: 50)")
	print("  - Especro de la Mina (HP: 28)")
	print("\n[Jefe de Zona]")
	print("  - ALPHYS - La Científica Corrompida (HP: 45)")
	print("\n" + "="*60 + "\n")

func load_zone_4_tower() -> void:
	"""Zona 4: La Torre Prohibida"""
	print("\n" + "="*60)
	print("ZONA 4: LA TORRE PROHIBIDA")
	print("="*60)
	print("\n[Descripción]")
	print("Una torre infinita que se eleva hacia la oscuridad.")
	print("Cada piso es más aterrador que el anterior.")
	print("En la cima... algo espera.")
	print("\n[Enemigos]")
	print("  - Fantasma de la Torre (HP: 32)")
	print("  - Guardia Espectral (HP: 42)")
	print("  - Sombra Antigua (HP: 55)")
	print("\n[Jefe de Zona]")
	print("  - METTATON - El Artista Vanidoso (HP: 50)")
	print("\n" + "="*60 + "\n")

func load_zone_5_castle() -> void:
	"""Zona 5: El Castillo del Odio"""
	print("\n" + "="*60)
	print("ZONA 5: EL CASTILLO DEL ODIO")
	print("="*60)
	print("\n[Descripción]")
	print("El castillo ancestral, sede del poder máximo.")
	print("Sus muros rezuman odio puro.")
	print("Aquí mora el Rey Oscuro.")
	print("\n[Enemigos]")
	print("  - Caballero del Castillo (HP: 60)")
	print("  - Mago del Caos (HP: 50)")
	print("  - Sacerdote Corrupto (HP: 45)")
	print("\n[Jefe Final]")
	print("  - ASGORE - El Rey Oscuro (HP: 150)")
	print("\n" + "="*60 + "\n")

func load_zone_secret_void() -> void:
	"""Zona Secreta: El Vacío - Solo en Genocidio Real"""
	print("\n" + "="*60)
	print("ZONA SECRETA: EL VACÍO INFINITO")
	print("="*60)
	print("\n[Descripción]")
	print("Un lugar que no debería existir.")
	print("Más allá de la realidad, más allá del ser.")
	print("Aquí acecha... AQUELLO.")
	print("\n[Advertencia]")
	print("Estás en el territorio de lo IMPOSIBLE.")
	print("No hay retorno.")
	print("\n[Jefe Secreto]")
	print("  - ??? - GENOCIDIO REAL (HP: ???)")
	print("\n" + "="*60 + "\n")

func get_zone_enemies(zone_name: String) -> Array:
	"""Retorna enemigos de una zona"""
	match zone_name:
		"zone_3_mines":
			return [
				{"name": "minero_corrompido", "hp": 35},
				{"name": "golem_oscuro", "hp": 50},
				{"name": "especro_mina", "hp": 28}
			]
		"zone_4_tower":
			return [
				{"name": "fantasma_torre", "hp": 32},
				{"name": "guardia_espectral", "hp": 42},
				{"name": "sombra_antigua", "hp": 55}
			]
		"zone_5_castle":
			return [
				{"name": "caballero_castillo", "hp": 60},
				{"name": "mago_caos", "hp": 50},
				{"name": "sacerdote_corrupto", "hp": 45}
			]
		_:
			return []
