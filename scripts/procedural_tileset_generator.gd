extends Node2D

class_name ProceduralTilesetGenerator

# Generador de tilesets procedurales

static func create_zone1_tileset(tile_size: int = 32) -> Image:
	"""Crea tileset para Zona 1: LA CAÍDA"""
	var image = Image.create(tile_size * 4, tile_size * 4, false, Image.FORMAT_RGBA8)
	
	# Paleta Zona 1
	var black_dark = Color(0.1, 0.1, 0.15, 1.0)
	var gray = Color(0.3, 0.3, 0.35, 1.0)
	var pink_mist = Color(0.8, 0.2, 0.8, 0.5)
	var white = Color(1.0, 1.0, 1.0, 1.0)
	
	# Limpiar
	for x in range(image.get_width()):
		for y in range(image.get_height()):
			image.set_pixel(x, y, Color.TRANSPARENT)
	
	# Tile 0: Suelo de piedra base (oscuro)
	var tile_0_x = 0
	var tile_0_y = 0
	for x in range(tile_size):
		for y in range(tile_size):
			var px = tile_0_x + x
			var py = tile_0_y + y
			# Patrón de piedra
			if (x + y) % 4 == 0:
				image.set_pixel(px, py, gray)
			else:
				image.set_pixel(px, py, black_dark)
	
	# Tile 1: Piedra con grietas
	var tile_1_x = tile_size
	var tile_1_y = 0
	for x in range(tile_size):
		for y in range(tile_size):
			var px = tile_1_x + x
			var py = tile_1_y + y
			if (x + y) % 5 == 0:
				image.set_pixel(px, py, white)  # Grietas
			elif (x + y) % 3 == 0:
				image.set_pixel(px, py, gray)
			else:
				image.set_pixel(px, py, black_dark)
	
	# Tile 2: Neblina rosada
	var tile_2_x = tile_size * 2
	var tile_2_y = 0
	for x in range(tile_size):
		for y in range(tile_size):
			var px = tile_2_x + x
			var py = tile_2_y + y
			# Efecto de neblina
			var noise_val = sin(x * 0.5) * cos(y * 0.5)
			var alpha = (noise_val + 1.0) / 2.0 * 0.6
			var color = pink_mist
			color.a = alpha
			image.set_pixel(px, py, color)
	
	# Tile 3: Vetas de rosa
	var tile_3_x = tile_size * 3
	var tile_3_y = 0
	for x in range(tile_size):
		for y in range(tile_size):
			var px = tile_3_x + x
			var py = tile_3_y + y
			if x % 5 < 2 or y % 5 < 2:
				image.set_pixel(px, py, pink_mist)
			else:
				image.set_pixel(px, py, black_dark)
	
	return image

static func create_zone2_tileset(tile_size: int = 32) -> Image:
	"""Crea tileset para Zona 2: JARDÍN OSCURO"""
	var image = Image.create(tile_size * 4, tile_size * 4, false, Image.FORMAT_RGBA8)
	
	# Paleta Zona 2
	var dirt_dark = Color(0.2, 0.15, 0.1, 1.0)
	var green_dark = Color(0.0, 0.3, 0.0, 1.0)
	var pink_dark = Color(0.5, 0.0, 0.3, 1.0)
	var red = Color(1.0, 0.0, 0.0, 1.0)
	var white = Color(1.0, 1.0, 1.0, 1.0)
	
	# Limpiar
	for x in range(image.get_width()):
		for y in range(image.get_height()):
			image.set_pixel(x, y, Color.TRANSPARENT)
	
	# Tile 0: Tierra oscura
	var tile_0_x = 0
	var tile_0_y = 0
	for x in range(tile_size):
		for y in range(tile_size):
			var px = tile_0_x + x
			var py = tile_0_y + y
			if (x * y) % 7 == 0:
				image.set_pixel(px, py, green_dark)
			else:
				image.set_pixel(px, py, dirt_dark)
	
	# Tile 1: Raíces emergentes
	var tile_1_x = tile_size
	var tile_1_y = 0
	for x in range(tile_size):
		for y in range(tile_size):
			var px = tile_1_x + x
			var py = tile_1_y + y
			# Patrón de raíces
			if y > tile_size / 2:
				if x % 4 < 2:
					image.set_pixel(px, py, green_dark)
				else:
					image.set_pixel(px, py, dirt_dark)
			else:
				image.set_pixel(px, py, dirt_dark)
	
	# Tile 2: Plantas carnívoras
	var tile_2_x = tile_size * 2
	var tile_2_y = 0
	for x in range(tile_size):
		for y in range(tile_size):
			var px = tile_2_x + x
			var py = tile_2_y + y
			# Patrón aleatorio de plantas
			var dist_center = Vector2(x, y).distance_to(Vector2(tile_size/2, tile_size/2))
			if dist_center < 6:
				image.set_pixel(px, py, pink_dark)
			elif (x + y) % 3 == 0:
				image.set_pixel(px, py, red)
			else:
				image.set_pixel(px, py, dirt_dark)
	
	# Tile 3: Espinas y púas
	var tile_3_x = tile_size * 3
	var tile_3_y = 0
	for x in range(tile_size):
		for y in range(tile_size):
			var px = tile_3_x + x
			var py = tile_3_y + y
			if x == tile_size / 2 or y == tile_size / 2:
				image.set_pixel(px, py, red)
			elif (x + y) % 2 == 0:
				image.set_pixel(px, py, pink_dark)
			else:
				image.set_pixel(px, py, dirt_dark)
	
	return image
