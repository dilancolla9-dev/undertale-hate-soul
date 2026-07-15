extends Node2D

class_name AudioManager

# Gestor de música y sonidos procedurales

var master_volume = 1.0
var music_volume = 0.7
var sfx_volume = 0.8

var audio_player: AudioStreamPlayer
var sfx_players: Dictionary = {}

signal music_started(track_name: String)
signal sfx_played(sfx_name: String)

func _ready():
	print("[AUDIO] Gestor de audio inicializado")
	audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	audio_player.bus = "Master"

func generate_music_track(track_name: String, duration: float = 30.0) -> AudioStream:
	"""Genera música proceduralmente basada en el tipo de zona"""
	match track_name:
		"zone_1_ambience":
			return create_zone_1_music(duration)
		"zone_2_ambience":
			return create_zone_2_music(duration)
		"flowey_boss":
			return create_flowey_theme(duration)
		"battle_generic":
			return create_battle_music(duration)
		"victory":
			return create_victory_music(duration)
		"defeat":
			return create_defeat_music(duration)
		_:
			return create_ambient_music(duration)

func create_zone_1_music(duration: float) -> AudioStream:
	"""Música de Zona 1: LA CAÍDA - Melancólica y oscura"""
	print("[AUDIO] Generando música: Zona 1 - LA CAÍDA")
	print("[AUDIO] Notas: Re menor, acordes oscuros, tempo lento")
	print("[AUDIO] Duración: ", duration, " segundos")
	print("[AUDIO] Instrumentos: Sintetizador oscuro, pads etéreos, neblina sonora")
	return AudioStream.new()  # Placeholder

func create_zone_2_music(duration: float) -> AudioStream:
	"""Música de Zona 2: JARDÍN OSCURO - Hostil y amenazante"""
	print("[AUDIO] Generando música: Zona 2 - JARDÍN OSCURO")
	print("[AUDIO] Notas: Do menor, acordes disonantes, tempo moderado")
	print("[AUDIO] Duración: ", duration, " segundos")
	print("[AUDIO] Instrumentos: Cuerdas retorcidas, vientos oscuros, pulsos rítmicos")
	return AudioStream.new()  # Placeholder

func create_flowey_theme(duration: float) -> AudioStream:
	"""Tema de Flowey - Combate épico"""
	print("[AUDIO] Generando música: FLOWEY - TEMA DEL JEFE")
	print("[AUDIO] Notas: Si menor, ritmo frenético, tempo rápido")
	print("[AUDIO] Duración: ", duration, " segundos")
	print("[AUDIO] Instrumentos: Orquesta oscura, bajos profundos, picos de violín agudo")
	return AudioStream.new()  # Placeholder

func create_battle_music(duration: float) -> AudioStream:
	"""Música de Combate Genérica"""
	print("[AUDIO] Generando música: COMBATE GENÉRICO")
	print("[AUDIO] Tempo: Rápido y energético")
	print("[AUDIO] Duración: ", duration, " segundos")
	return AudioStream.new()  # Placeholder

func create_victory_music(duration: float) -> AudioStream:
	"""Música de Victoria"""
	print("[AUDIO] Generando música: VICTORIA")
	print("[AUDIO] Notas: Mayor, acordes triumfales, tempo majestuoso")
	print("[AUDIO] Duración: ", duration, " segundos")
	return AudioStream.new()  # Placeholder

func create_defeat_music(duration: float) -> AudioStream:
	"""Música de Derrota"""
	print("[AUDIO] Generando música: DERROTA")
	print("[AUDIO] Notas: Menor triste, acordes descendentes, tempo lento")
	print("[AUDIO] Duración: ", duration, " segundos")
	return AudioStream.new()  # Placeholder

func create_ambient_music(duration: float) -> AudioStream:
	"""Música Ambiental Genérica"""
	print("[AUDIO] Generando música ambiental...")
	return AudioStream.new()  # Placeholder

func play_music(track_name: String, loop: bool = true, fade_in: float = 1.0) -> void:
	"""Reproduce música con fade-in"""
	print("\n[AUDIO] Reproduciendo: ", track_name)
	audio_player.stream = generate_music_track(track_name)
	audio_player.volume_db = linear2db(music_volume)
	audio_player.bus = "Music"
	audio_player.play()
	
	if fade_in > 0:
		var tween = create_tween()
		tween.tween_property(audio_player, "volume_db", linear2db(music_volume), fade_in)
	
	music_started.emit(track_name)

func stop_music(fade_out: float = 1.0) -> void:
	"""Detiene la música con fade-out"""
	if audio_player.playing:
		var tween = create_tween()
		tween.tween_property(audio_player, "volume_db", -80.0, fade_out)
		await tween.finished
		audio_player.stop()

func play_sfx(sfx_name: String, pitch: float = 1.0) -> void:
	"""Reproduce efectos de sonido"""
	print("[SFX] Reproduciendo efecto: ", sfx_name)
	
	match sfx_name:
		"attack":
			print("[SFX] Sonido de ataque: Whoosh de espada")
		"hit":
			print("[SFX] Sonido de impacto: Golpe sólido")
		"damage":
			print("[SFX] Sonido de daño: Crack de dolor")
		"heal":
			print("[SFX] Sonido de curación: Campanilla mágica")
		"levelup":
			print("[SFX] Sonido de nivel: Fanfarria") 
		"menu_select":
			print("[SFX] Selección de menú: Bip suave")
		"menu_move":
			print("[SFX] Movimiento de menú: Beep electrónico")
		"error":
			print("[SFX] Error: Buzz negativo")
		"flowey_laugh":
			print("[SFX] Risa de Flowey: Carcajada maléfica")
		"flowey_attack":
			print("[SFX] Ataque de Flowey: Sonido de raíces emergiendo")
		"zone_1_ambience":
			print("[SFX] Ambiente Zona 1: Viento oscuro, goteo")
		"zone_2_ambience":
			print("[SFX] Ambiente Zona 2: Respiración de plantas, crujidos")
		_:
			print("[SFX] Efecto genérico desconocido")
	
	sfx_played.emit(sfx_name)

func set_music_volume(volume: float) -> void:
	music_volume = clamp(volume, 0.0, 1.0)
	audio_player.volume_db = linear2db(music_volume)

func set_sfx_volume(volume: float) -> void:
	sfx_volume = clamp(volume, 0.0, 1.0)

func set_master_volume(volume: float) -> void:
	master_volume = clamp(volume, 0.0, 1.0)
