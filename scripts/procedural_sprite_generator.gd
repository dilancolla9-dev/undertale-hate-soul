extends Node2D

class_name ProceduralSpriteGenerator

# Generador de sprites procedurales

static func create_hate_soul_sprite(size: int = 32) -> Image:
	var image = Image.create(size, size, false, Image.FORMAT_RGBA8)
	
	# Paleta de colores
	var soul_pink = Color(1.0, 0.0, 1.0, 1.0)  # Magenta/Rosa
	var dark_pink = Color(0.8, 0.0, 0.8, 1.0)
	var black = Color(0.0, 0.0, 0.0, 1.0)
	var white = Color(1.0, 1.0, 1.0, 1.0)
	var skin = Color(0.9, 0.7, 0.7, 1.0)
	
	# Limpiar
	for x in range(size):
		for y in range(size):
			image.set_pixel(x, y, Color.TRANSPARENT)
	
	# Cabeza (círculo de skin)
	var head_center = Vector2(size / 2, size / 3)
	var head_radius = 6
	for x in range(size):
		for y in range(size):
			var dist = Vector2(x, y).distance_to(head_center)
			if dist <= head_radius:
				image.set_pixel(x, y, skin)
	
	# Pelo fucsia (parte superior de la cabeza)
	var hair_color = soul_pink
	for x in range(size / 2 - 5, size / 2 + 5):
		for y in range(2, 8):
			var dist = Vector2(x, y).distance_to(head_center)
			if dist <= 6 and y < head_center.y - 2:
				image.set_pixel(x, y, hair_color)
	
	# Ojos negros
	image.set_pixel(size / 2 - 2, size / 3 - 1, black)
	image.set_pixel(size / 2 + 2, size / 3 - 1, black)
	
	# Cuerpo - Camisa a rayas negro/rosa
	var body_start_y = size / 3 + 6
	var body_height = 12
	for x in range(size):
		for y in range(body_start_y, body_start_y + body_height):
			if x >= size / 2 - 8 and x <= size / 2 + 8:
				# Rayas
				if (x + y) % 3 == 0:
					image.set_pixel(x, y, black)
				else:
					image.set_pixel(x, y, soul_pink)
	
	# Piernas
	var legs_y = body_start_y + body_height
	for y in range(legs_y, size):
		if y >= size / 2 + 18:
			image.set_pixel(size / 2 - 2, y, black)
			image.set_pixel(size / 2 + 2, y, black)
	
	return image

static func create_flowey_sprite(size: int = 32) -> Image:
	var image = Image.create(size, size, false, Image.FORMAT_RGBA8)
	
	# Paleta
	var petal_dark = Color(0.8, 0.0, 0.4, 1.0)  # Rosa oscuro
	var petal_red = Color(1.0, 0.0, 0.0, 1.0)  # Rojo
	var stem_green = Color(0.0, 0.5, 0.0, 1.0)  # Verde
	var black = Color(0.0, 0.0, 0.0, 1.0)
	
	# Limpiar
	for x in range(size):
		for y in range(size):
			image.set_pixel(x, y, Color.TRANSPARENT)
	
	# Tallo verde
	for x in range(size / 2 - 1, size / 2 + 1):
		for y in range(size / 2, size):
			image.set_pixel(x, y, stem_green)
	
	# Pétalos (forma de flor carnívora)
	var center = Vector2(size / 2, size / 3)
	var petal_radius = 8
	var num_petals = 5
	
	for petal in range(num_petals):
		var angle = (PI * 2 / num_petals) * petal
		var petal_pos = center + Vector2(cos(angle), sin(angle)) * 6
		
		for x in range(size):
			for y in range(size):
				var dist = Vector2(x, y).distance_to(petal_pos)
				if dist <= petal_radius / 2:
					if randf() > 0.5:
						image.set_pixel(x, y, petal_dark)
					else:
						image.set_pixel(x, y, petal_red)
	
	# Ojos malévolo negros
	var left_eye = center + Vector2(-3, -2)
	var right_eye = center + Vector2(3, -2)
	
	for x in range(size):
		for y in range(size):
			var dist_left = Vector2(x, y).distance_to(left_eye)
			var dist_right = Vector2(x, y).distance_to(right_eye)
			if dist_left <= 1.5 or dist_right <= 1.5:
				image.set_pixel(x, y, black)
	
	# Sonrisa malévola
	for x in range(size / 2 - 4, size / 2 + 4):
		image.set_pixel(x, size / 3 + 2, black)
	
	return image

static func create_ghost_companion_sprite(size: int = 32) -> Image:
	var image = Image.create(size, size, false, Image.FORMAT_RGBA8)
	
	# Paleta
	var ghost_pink = Color(1.0, 0.5, 0.75, 0.9)  # Rosado
	var ghost_red = Color(1.0, 0.3, 0.5, 0.9)   # Rojizo
	var white = Color(1.0, 1.0, 1.0, 1.0)
	var black = Color(0.0, 0.0, 0.0, 1.0)
	
	# Limpiar
	for x in range(size):
		for y in range(size):
			image.set_pixel(x, y, Color.TRANSPARENT)
	
	# Cuerpo de fantasma (forma redondeada)
	var center = Vector2(size / 2, size / 2 - 2)
	var body_radius = 10
	
	for x in range(size):
		for y in range(size):
			var dist = Vector2(x, y).distance_to(center)
			if dist <= body_radius:
				# Degradado rosado a rojo
				var gradient = dist / body_radius
				var color = ghost_pink.lerp(ghost_red, gradient)
				image.set_pixel(x, y, color)
	
	# Colas tipo fantasma (onduladas en la base)
	for tail in range(3):
		var tail_x = size / 2 - 6 + tail * 6
		for y in range(size / 2 + 8, size):
			if abs(tail_x - size / 2) < 8:
				image.set_pixel(tail_x, y, ghost_pink)
	
	# Ojos blancos
	var left_eye = center + Vector2(-4, -2)
	var right_eye = center + Vector2(4, -2)
	
	for x in range(size):
		for y in range(size):
			var dist_left = Vector2(x, y).distance_to(left_eye)
			var dist_right = Vector2(x, y).distance_to(right_eye)
			if dist_left <= 1.5:
				image.set_pixel(x, y, white)
			if dist_right <= 1.5:
				image.set_pixel(x, y, white)
	
	# Pupilas negras
	image.set_pixel(int(left_eye.x), int(left_eye.y), black)
	image.set_pixel(int(right_eye.x), int(right_eye.y), black)
	
	return image
