# Sistema de Combate - Undertale: Hate Soul

## Descripción General

El sistema de combate está basado en el estilo de Undertale pero reinterpretado con el tema de ODIO.

## Mecánicas principales

### 1. Turnos
- **Turno del jugador**: Elige una acción (Atacar, Defender, Objeto, Huir)
- **Turno del enemigo**: El enemigo contraataca según su patrón de ataque

### 2. Acciones del Jugador

#### ATACAR
- Daño base: 5 + variación aleatoria (±1)
- Se ve afectado por el nivel del jugador
- Más probabilidad de crítico a mayor nivel

#### DEFENDER
- Reduce el daño del próximo ataque en un 50%
- Puedes defenderte múltiples turnos seguidos
- No consume mucha energía

#### OBJETO
- Usa pociones, alimentos, etc.
- Recupera HP
- Cada objeto se consume

#### HUIR
- Intenta escapar del combate
- Probabilidad de éxito: 60%
- Si falla, el enemigo ataca inmediatamente

### 3. Personajes Reinterpretados

Todos los personajes de Undertale tienen versiones CORROMPIDAS:

- **Toriel - La Guardiana Resentida** (HP: 60, Ataque: 8)
- **Sans - El Cómico Oscuro** (HP: 80, Ataque: 10)
- **Papyrus - El Guerrero Furioso** (HP: 55, Ataque: 9)
- **Undyne - La Guerrera Sediente** (HP: 70, Ataque: 12)
- **Alphys - La Científica Corrompida** (HP: 45, Ataque: 7)
- **Mettaton - El Artista Vanidoso** (HP: 50, Ataque: 8)
- **Asgore - El Rey Oscuro** (HP: 150, Ataque: 15)

### 4. Sistema de Experiencia

- Cada enemigo derrotado otorga EXP
- Necesitas 100 EXP para subir de nivel
- Cada nivel aumenta:
  - HP máximo: +5
  - Ataque: +1
  - Defensa: +1

## Sprites Procedurales

Todos los sprites se generan proceduralmente sin necesidad de imágenes PNG:

- **Hate Soul**: Pelo fucsia, camisa a rayas, cuerpo rosado
- **Fantasma Compañero**: Rosado-rojizo con efecto transparente
- **Flowey Carnívoro**: Flor roja oscura con ojos malévolo

## Tilesets Procedurales

### Zona 1: LA CAÍDA
- Suelo de piedra negra
- Neblina rosada
- Vetas de color rosa
- Grietas en las paredes

### Zona 2: JARDÍN OSCURO
- Tierra oscura
- Raíces emergentes
- Plantas carnívoras
- Espinas y púas

## Implementación en GDScript

Ver `combat_system.gd` para:
- Lógica de combate
- Cálculo de daño
- Patrones de ataque enemigo
- Sistema de turnos

---

**Nota**: El sistema está completamente funcional en código. Solo falta integrar con la interfaz visual del juego.
