extends CharacterBody2D

const SPEED = 3.0
const JUMP_VELOCITY = -400.0
const TURN_SPEED = 10.0
const BULLET_SPEED = 300.0

var projectile = preload("res://bullet.tscn")

func _physics_process(delta: float) -> void:
	
	var accelerate = Input.get_action_raw_strength("ui_up")
	if accelerate:
		velocity += Vector2.from_angle(rotation - PI/2.0) * SPEED
		
	var turn = Input.get_axis("ui_left", "ui_right")
	rotation_degrees = rotation_degrees + turn * TURN_SPEED
	
	var ui_accept = Input.is_action_just_pressed("ui_accept") 
	if ui_accept:
		shoot()
	
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		crash()
		# This return prevents any further processing in this script
		# which is necessary in the case where crash() changes
		# the scene.
		# Another option is to change [crash] to call
		# get_tree().change_scene_to_file.call_deferred(path)
		return
	wrap_around()

func wrap_around():
	var extent = get_viewport().get_visible_rect().size
	if position.x > extent.x/2:
		position.x -= extent.x
	if position.x < -extent.x/2:
		position.x += extent.x
	if position.y > extent.y/2:
		position.y -= extent.y
	if position.y < -extent.y/2:
		position.y += extent.y

func shoot():
	var bullet = projectile.instantiate()
	bullet.position = position
	bullet.rotation = rotation
	bullet.linear_velocity = velocity + Vector2.from_angle(rotation - PI/2) * 300.0
	add_sibling(bullet)
	
func crash():
	get_tree().change_scene_to_file.call_deferred("res://gameover.tscn")
