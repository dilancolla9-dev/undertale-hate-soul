# Sistema de Inventario - Documentación

## Descripción General

Sistema completo de inventario con:
- Gestión de items (consumibles, armas, armaduras, accesorios)
- Sistema de equipo (weapon, armor, accessory)
- Gestor de dinero y experiencia
- Capacidad máxima de 20 items

## Tipos de Items

### Consumibles
- **Poción de HP Pequeña** (10 HP, 25 oro)
- **Poción de HP Grande** (30 HP, 60 oro)
- **Poción del Odio** (50 HP especial, 150 oro)
- **Elixir Raro** (100 HP máximo, 500 oro)

### Armas
- **Espada Rosa Oscuro** (15 ATK, 200 oro)
- **Espada Negra del Odio** (25 ATK, 500 oro)
- **Tridente Rojo** (30 ATK, 800 oro)

### Armaduras
- **Armadura Rosa** (10 DEF, 150 oro)
- **Armadura Negra** (20 DEF, 400 oro)

### Accesorios
- **Anillo del Odio** (+5 stats, 100 oro)
- **Collar del Alma** (+8 stats, 200 oro)

## Funciones Principales

### Gestión de Items

```gdscript
add_item("pocion_hp_pequeña", 1)  # Agrega item
remove_item("pocion_hp_pequeña", 1)  # Remueve item
use_item("pocion_hp_pequeña")  # Usa item
get_inventory_list()  # Lista de items
```

### Equipo

```gdscript
equip_item("espada_rosa")  # Equipa arma
unequip_item("weapon")  # Desequipa
```

### Dinero

```gdscript
add_gold(100)  # Suma oro
remove_gold(50)  # Resta oro
```

### Experiencia

```gdscript
add_experience(25)  # Suma EXP
# Sube de nivel automáticamente si alcanza el límite
```

## Señales (Signals)

- `item_added(item)` - Cuando se agrega un item
- `item_removed(item)` - Cuando se remueve un item
- `item_used(item)` - Cuando se usa un item
- `inventory_full` - Cuando el inventario está lleno
- `gold_changed(amount)` - Cuando cambia el oro

## Progresión de Nivel

- **Nivel 1**: 0/100 EXP
- **Nivel 2**: 100 EXP requeridos
- **Nivel 3**: 200 EXP requeridos
- **Nivel N**: N × 100 EXP requeridos

## Ejemplo de Uso

```gdscript
var inventory = InventorySystem.new()

# Agregar items
inventory.add_item("pocion_hp_pequeña", 5)
inventory.add_item("espada_rosa", 1)
inventory.add_item("anillo_odio", 1)

# Equipar item
inventory.equip_item("espada_rosa")

# Agregar dinero y experiencia
inventory.add_gold(100)
inventory.add_experience(50)

# Mostrar inventario
inventory.display_inventory()
```

---

*Nota: El sistema está completamente funcional y listo para integrarse con la UI del juego.*
