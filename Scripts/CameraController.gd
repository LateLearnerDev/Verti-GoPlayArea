extends Camera2D

export (float) var lerp_weight = 0.04
onready var player := get_node_or_null("../Player") as Player


func _ready() -> void:
	if not player:
		print('Player not found')

func _physics_process(delta: float) -> void:
	position.y = clamp(lerp(position - Vector2(0,3), player.position, lerp_weight).y, -500, 217)
	#position.y = clamp(player.position.y, -500, 500)
