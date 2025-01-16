extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	wrap_around()

func wrap_around():
	var extent = get_viewport().get_visible_rect().size
	if global_position.x > extent.x/2:
		global_position.x -= extent.x
	if global_position.x < -extent.x/2:
		global_position.x += extent.x
	if global_position.y > extent.y/2:
		global_position.y -= extent.y
	if global_position.y < -extent.y/2:
		global_position.y += extent.y
