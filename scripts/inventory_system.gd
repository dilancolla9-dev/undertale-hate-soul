extends Node2D

class_name InventorySystem

# Sistema de inventario completo

var inventory: Array[InventoryItem] = []
var equipment: Dictionary = {}
var max_items = 20
var gold = 0
var level = 1
var experience = 0

signal item_added(item: InventoryItem)
signal item_removed(item: InventoryItem)
signal item_used(item: InventoryItem)
signal inventory_full
signal gold_changed(new_amount: int)

func _ready():
	print("[INVENTORY] Sistema de inventario inicializado")
	print("[INVENTORY] Capacidad máxima: ", max_items, " items")

# ========== GESTIÓN DE ITEMS ==========

func add_item(item_name: String, quantity: int = 1) -> bool:
	"""Agrega un item al inventario"""
	if inventory.size() >= max_items:
		print("[INVENTORY] ¡El inventario está lleno!")
		inventory_full.emit()
		return false
	
	var item = create_item(item_name, quantity)
	inventory.append(item)
	print("[INVENTORY] Item añadido: ", item_name, " x", quantity)
	item_added.emit(item)
	return true

func remove_item(item_name: String, quantity: int = 1) -> bool:
	"""Remueve un item del inventario"""
	for item in inventory:
		if item.name == item_name:
			if item.quantity >= quantity:
				item.quantity -= quantity
				if item.quantity <= 0:
					inventory.erase(item)
				print("[INVENTORY] Item removido: ", item_name, " x", quantity)
				item_removed.emit(item)
				return true
			else:
				print("[INVENTORY] No hay suficientes ", item_name)
				return false
	return false

func use_item(item_name: String) -> void:
	"""Usa un item del inventario"""
	for item in inventory:
		if item.name == item_name:
			match item.item_type:
				"consumable":
					print("[INVENTORY] Usaste: ", item_name)
					item_used.emit(item)
					remove_item(item_name, 1)
				"weapon":
					equip_item(item_name)
				"armor":
					equip_item(item_name)
				"accessory":
					equip_item(item_name)

func get_inventory_list() -> Array[String]:
	"""Retorna lista de items en el inventario"""
	var items: Array[String] = []
	for item in inventory:
		items.append(item.name + " x" + str(item.quantity))
	return items

# ========== GESTIÓN DE EQUIPO ==========

func equip_item(item_name: String) -> void:
	"""Equipa un item"""
	for item in inventory:
		if item.name == item_name:
			if item.item_type == "weapon":
				equipment["weapon"] = item
				print("[INVENTORY] Arma equipada: ", item_name)
			elif item.item_type == "armor":
				equipment["armor"] = item
				print("[INVENTORY] Armadura equipada: ", item_name)
			elif item.item_type == "accessory":
				equipment["accessory"] = item
				print("[INVENTORY] Accesorio equipado: ", item_name)

func unequip_item(slot: String) -> void:
	"""Desequipa un item"""
	if slot in equipment:
		var item = equipment[slot]
		equipment.erase(slot)
		print("[INVENTORY] Desequipado: ", item.name)

# ========== GESTIÓN DE DINERO ==========

func add_gold(amount: int) -> void:
	"""Suma oro"""
	gold += amount
	print("[INVENTORY] +", amount, " oro. Total: ", gold)
	gold_changed.emit(gold)

func remove_gold(amount: int) -> bool:
	"""Resta oro"""
	if gold >= amount:
		gold -= amount
		print("[INVENTORY] -", amount, " oro. Total: ", gold)
		gold_changed.emit(gold)
		return true
	else:
		print("[INVENTORY] No tienes suficiente oro")
		return false

# ========== GESTIÓN DE EXPERIENCIA ==========

func add_experience(amount: int) -> void:
	"""Suma experiencia"""
	experience += amount
	var exp_needed = level * 100
	print("[INVENTORY] +", amount, " EXP")
	
	if experience >= exp_needed:
		level_up()

func level_up() -> void:
	"""Sube de nivel"""
	level += 1
	experience = 0
	print("\n[INVENTORY] ¡¡¡ NIVEL SUBIÓ !!!")
	print("[INVENTORY] Ahora eres nivel: ", level)
	print("[INVENTORY] Atributos aumentados...\n")

# ========== CREACIÓN DE ITEMS ==========

func create_item(item_name: String, quantity: int = 1) -> InventoryItem:
	"""Crea un item según su nombre"""
	match item_name:
		"pocion_hp_pequeña":
			return InventoryItem.new("Poción de HP Pequeña", "consumable", 10, quantity, 25)
		"pocion_hp_grande":
			return InventoryItem.new("Poción de HP Grande", "consumable", 30, quantity, 60)
		"pocion_odio":
			return InventoryItem.new("Poción del Odio", "consumable", 50, quantity, 150)
		"elixir_raro":
			return InventoryItem.new("Elixir Raro", "consumable", 100, quantity, 500)
		
		"espada_rosa":
			return InventoryItem.new("Espada Rosa Oscuro", "weapon", 15, quantity, 200)
		"espada_negra":
			return InventoryItem.new("Espada Negra del Odio", "weapon", 25, quantity, 500)
		"triidente_rojo":
			return InventoryItem.new("Tridente Rojo", "weapon", 30, quantity, 800)
		
		"armadura_rosa":
			return InventoryItem.new("Armadura Rosa", "armor", 10, quantity, 150)
		"armadura_negra":
			return InventoryItem.new("Armadura Negra", "armor", 20, quantity, 400)
		
		"anillo_odio":
			return InventoryItem.new("Anillo del Odio", "accessory", 5, quantity, 100)
		"collar_soul":
			return InventoryItem.new("Collar del Alma", "accessory", 8, quantity, 200)
		
		_:
			return InventoryItem.new(item_name, "miscelaneous", 5, quantity, 10)

func display_inventory() -> void:
	"""Muestra el inventario actual"""
	print("\n" + "="*50)
	print("INVENTARIO - Nivel ", level)
	print("Oro: ", gold, " | EXP: ", experience, "/", level * 100)
	print("="*50)
	
	if inventory.size() == 0:
		print("[Inventario vacío]")
	else:
		for item in inventory:
			print("  - ", item.name, " x", item.quantity, " (Valor: ", item.value, ")")
	
	print("\nEQUIPO:")
	if equipment.is_empty():
		print("[Sin equipar]")
	else:
		for slot in equipment:
			var item = equipment[slot]
			print("  - ", slot.to_upper(), ": ", item.name)
	print("="*50 + "\n")

class InventoryItem:
	var name: String
	var item_type: String  # consumable, weapon, armor, accessory, miscelaneous
	var effect: int  # Efecto del item (daño, curación, etc)
	var quantity: int
	var value: int  # Precio de venta
	
	func _init(p_name: String, p_type: String, p_effect: int, p_quantity: int = 1, p_value: int = 10):
		name = p_name
		item_type = p_type
		effect = p_effect
		quantity = p_quantity
		value = p_value
	
	func get_info() -> String:
		return "%s (x%d) - Tipo: %s - Efecto: %d - Valor: %d" % [name, quantity, item_type, effect, value]
