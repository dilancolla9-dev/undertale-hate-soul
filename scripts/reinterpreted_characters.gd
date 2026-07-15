extends Node2D

class_name ReinterpretedCharacters

# Personajes de Undertale reinterpretados con aspecto de ODIO

static func get_character_data(character_name: String) -> Dictionary:
	match character_name:
		"toriel_hate":
			return {
				"name": "Toriel - La Guardiana Resentida",
				"description": "Cabra roja oscura con cuerpo retorcido. Usa fuego malévolo.",
				"hp": 60,
				"attack": 8,
				"defense": 3,
				"dialogue": [
					"Te había advertido...",
					"El fuego consumirá tu alma rosa...",
					"No dejaré que escapes de aquí."
				],
				"attack_pattern": [5, 5, 8, 4, 6]
			}
		
		"sans_hate":
			return {
				"name": "Sans - El Cómico Oscuro",
				"description": "Esqueleto blanco con ojos vacíos negros. Sonrisa grotesca. Magia azul destructiva.",
				"hp": 80,
				"attack": 10,
				"defense": 5,
				"dialogue": [
					"Jajaja... qué alma tan bonita tienes.",
					"¿Sabes qué? Me la voy a quedar.",
					"Esto va a ser... *sin gracia*."
				],
				"attack_pattern": [6, 4, 8, 9, 7, 5]
			}
		
		"papyrus_hate":
			return {
				"name": "Papyrus - El Guerrero Furioso",
				"description": "Esqueleto alto con manto rojo sangre. Espadas de hueso negro.",
				"hp": 55,
				"attack": 9,
				"defense": 2,
				"dialogue": [
					"¡SOY TAN IMPORTANTE!",
					"¡DESTRUIRÉ TU ALMA CON MIS ESPADAS!",
					"¡NYEH HEH HEH HEH!"
				],
				"attack_pattern": [7, 6, 8, 7]
			}
		
		"undyne_hate":
			return {
				"name": "Undyne - La Guerrera Sediente",
				"description": "Pez rojo con aspecto fiero. Armadura de hueso negro. Lanza de energía roja.",
				"hp": 70,
				"attack": 12,
				"defense": 4,
				"dialogue": [
					"¡QUIERO TU ALMA!",
					"¡LA NECESITO PARA PODER AVANZAR!",
					"¡PREPÁRATE PARA MORIR!"
				],
				"attack_pattern": [8, 9, 7, 10, 8]
			}
		
		"alphys_hate":
			return {
				"name": "Alphys - La Científica Corrompida",
				"description": "Dragona amarilla con circuitos oscuros. Usa rayos negros.",
				"hp": 45,
				"attack": 7,
				"defense": 2,
				"dialogue": [
					"M-mis experimentos necesitaban... tu alma.",
					"P-perdón... pero los números lo necesitan.",
					"¡RAYOS OSCUROS!"
				],
				"attack_pattern": [4, 5, 6, 5]
			}
		
		"mettaton_hate":
			return {
				"name": "Mettaton - El Artista Vanidoso",
				"description": "Robot brillante con forma de cuadrado retorcido. Fuego rosa y negro.",
				"hp": 50,
				"attack": 8,
				"defense": 3,
				"dialogue": [
					"¡Debes ser parte de mi espectáculo!",
					"Tu alma... será mi obra maestra.",
					"¡MUESTRA, AGONÍA Y DOLOR!"
				],
				"attack_pattern": [6, 7, 5, 8]
			}
		
		"asgore_hate":
			return {
				"name": "Asgore - El Rey Oscuro",
				"description": "Enorme rey cabra con corona negra. Tríde de fuego cósmico.",
				"hp": 150,
				"attack": 15,
				"defense": 8,
				"dialogue": [
					"Tu alma es la que necesitaba...",
					"Con ella, los humanos y monstruos serán UNO.",
					"BAJO MI PODER ABSOLUTO."
				],
				"attack_pattern": [10, 12, 11, 13, 10, 14]
			}
		
		_:
			return {
				"name": "Enemigo Desconocido",
				"hp": 30,
				"attack": 5,
				"defense": 1,
				"dialogue": ["..."]
			}

static func get_all_characters() -> Array:
	return [
		"toriel_hate",
		"sans_hate",
		"papyrus_hate",
		"undyne_hate",
		"alphys_hate",
		"mettaton_hate",
		"asgore_hate"
	]
