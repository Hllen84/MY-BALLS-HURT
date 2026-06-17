extends RigidBody2D
var blocking = false
var dead = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed("D"):
		self.apply_torque(mass * 6000)
	else: if Input.is_action_pressed("A"):
		self.apply_torque(mass * -6000)
	
	if Input.is_action_just_pressed("W") and %RayCast2D.is_colliding():
		self.apply_impulse(Vector2(0, -200))
	
	if Input.is_action_just_pressed("Drop"):
		set_deferred("linear_velocity", Vector2(self.linear_velocity.x * 4, self.linear_velocity.y))
		blocking = true
		await get_tree().create_timer(0.1).timeout
		blocking = false
		set_deferred("linear_velocity", Vector2(self.linear_velocity.x / 2, self.linear_velocity.y))
	
	if Input.is_action_just_pressed("Reset") && dead == false:
		set_deferred("position", Vector2(0, -16))
		linear_velocity = Vector2.ZERO
		angular_velocity = 0.0
	





func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == self && blocking == false:
		dead = true
		call_deferred("set_freeze_enabled", true)
		call_deferred("set_visible", false)
		await get_tree().create_timer(1.0).timeout
		dead = false
		call_deferred("set_freeze_enabled", false)
		call_deferred("set_visible", true)
		set_deferred("position", Vector2(0, -16))
		linear_velocity = Vector2.ZERO
		angular_velocity = 0.0
