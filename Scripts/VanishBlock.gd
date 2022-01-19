extends StaticBody2D

export var delay: bool = false
export var time: float = 3.0

onready var timer := $Timer as Timer

func _ready() -> void:
	if delay:
		visible = false
		set_collision_layer_bit(Constants.COLLISION_LAYERS.EMPTY, true)
		set_collision_layer_bit(Constants.COLLISION_LAYERS.GROUND_WALLS_DEFAULT, false)
		timer.start(time)


func _process(_delta: float) -> void:		
	if timer.get_time_left() == 0:
		if delay:
			_set_visible(true)
			delay = false
			return
		timer.start(time)
		yield(timer, "timeout")
		visible = !visible
		_set_visible(visible)
	

func _set_visible(visible: bool) -> void:
	self.visible = visible
	set_collision_layer_bit(Constants.COLLISION_LAYERS.EMPTY, false if visible else true)
	set_collision_layer_bit(Constants.COLLISION_LAYERS.GROUND_WALLS_DEFAULT, true if visible else false)
