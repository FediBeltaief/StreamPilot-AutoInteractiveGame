extends Sprite2D

@onready var damage_component: DamageComponent = $DamageComponent
@onready var hurt_component: HurtComponent = $HurtComponent

var log_scene = preload("res://scenes/objects/trees/log.tscn")

func _ready() -> void:
	hurt_component.hurt.connect(on_hurt)
	damage_component.max_damaged_reached.connect(on_max_damaged_reached)
	
	
func on_hurt(hit_damage: int) -> void:
	damage_component.apply_damage(hit_damage)
	await get_tree().create_timer(0.33).timeout
	material.set_shader_parameter("shake_intensity", 0.6)
	await get_tree().create_timer(1.0).timeout
	material.set_shader_parameter("shake_intensity", 0.0)
	

func on_max_damaged_reached()-> void:
	call_deferred("add_log_scene")
	print("max damaged reached")
	await get_tree().create_timer(0.33).timeout
	queue_free()
	
func add_log_scene()->void:
	var log_instance = log_scene.instantiate() as Node2D
	log_instance.global_position= global_position
	get_parent().add_child(log_instance)

	
