class_name ShootBlock
extends KinematicBody2D

const SPEED = 150

var direction := Vector2.RIGHT
var velocity = Vector2(1,0)


func _ready() -> void:
	add_to_group("ShootBlocks")
	
func _physics_process(delta: float) -> void:
	var collision_info: KinematicCollision2D = move_and_collide(velocity.normalized() * delta * SPEED * direction.x)
	if collision_info != null:
		var collision_object := collision_info.collider as Node2D	
		
		if collision_object.get_collision_layer_bit(Constants.COLLISION_LAYERS.UP_DOWN_LEFT_RIGHT_BLOCK):	
			var current_transform = global_transform
			velocity = Vector2.ZERO
			set_physics_process(false)
			_on_wall_hit()
			if get_parent():
				call_deferred("_reparent", collision_object, self, get_global_transform())
			
		if collision_object.get_collision_layer_bit(Constants.COLLISION_LAYERS.GROUND_WALLS_DEFAULT) \
			or collision_object.get_collision_layer_bit(Constants.COLLISION_LAYERS.BOUNCE_BACK_BLOCK) \
			or collision_object.get_collision_layer_bit(Constants.COLLISION_LAYERS.SHOOT_BLOCK):			
				velocity = Vector2.ZERO
				set_physics_process(false)
				_on_wall_hit()
			
func _reparent(new_parent: Node2D, node: Node2D, old_transform: Transform2D) -> void:
	node.get_parent().remove_child(node)
	new_parent.add_child(node)
	node.transform = new_parent.get_global_transform().inverse() * old_transform


func set_direction(dir: Vector2) -> void:
	direction = dir
			
func _on_wall_hit() -> void:
	var timer := Timer.new()
	get_parent().add_child(timer)
	timer.start(3.0)
	yield(timer, "timeout")
	queue_free()
			
		
