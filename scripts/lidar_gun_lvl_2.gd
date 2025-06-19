extends Sprite2D

var width = 1
var rotation_degree = 0
var mouse_position
var mouse_position_local
var leftside = false
var rightside = false
var in_progress = false
var shader_mat
var normal
@export var isPickedUp = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	shader_mat = ShaderMaterial.new()
	shader_mat.shader = load("res://shaders/rainbow.gdshader")
	$Line2D.visible = false
	$RayCast2D.enabled = false
	normal = $Line2D.position.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isPickedUp:
		visible = true
		mouse_position = get_global_mouse_position()
		mouse_position_local = get_local_mouse_position()
		#print(mouse_position.x)
		look_at(mouse_position)
		
		if get_viewport().get_mouse_position().x > get_viewport().size.x/2:
			flip_v = false
			$Line2D.position.y = normal
			$RayCast2D.position.y = normal
			
		if get_viewport().get_mouse_position().x < get_viewport().size.x/2:
			flip_v = true
			$Line2D.position.y = normal + 15.5
			$RayCast2D.position.y = normal + 15.5
			
		
		if Input.is_action_just_pressed("interact"):
			texture = load("res://assets/LidarComponents/LidarGun.png")
			rightside = true
			in_progress = true
			$Line2D.visible = true
			$RayCast2D.enabled = true
		
		if Input.is_action_just_released("interact"):
			texture = load("res://assets/LidarComponents/LidarGunOff.png")
			rightside = false
			in_progress = false
			$Line2D.visible = false
			$RayCast2D.enabled = false
		if $RayCast2D.is_colliding():
			$Line2D.set_point_position(1, $Line2D.to_local($RayCast2D.get_collision_point()))
			if $RayCast2D.get_collider() is Area2D:
				if $RayCast2D.get_collider().is_in_group("coin"):
					#print("coin hit")
					$RayCast2D.get_collider().z_index = 6
					$RayCast2D.get_collider().collision_layer=0
				if $RayCast2D.get_collider().is_in_group("emerald"):
					#print("coin hit")
					$RayCast2D.get_collider().z_index = 6
					$RayCast2D.get_collider().collision_layer=0
					
			else:
				#var imageTexture = ImageTexture.new()
				#var dynImage = Image.new()
				#dynImage.create(32,32,false,Image.FORMAT_RGB8)
				#dynImage.fill(Color(1,1,1,1))
				var sprite = Sprite2D.new()
				#var texture = ImageTexture.create_from_image(dynImage)
				sprite.texture = load("res://icon.svg")
				sprite.global_position = $RayCast2D.get_collision_point()
				sprite.scale.x = 0.01
				sprite.scale.y = 0.01
				sprite.material = shader_mat
				sprite.z_index = 3
				$Node.add_child(sprite)
			
			
		else:
			$Line2D.points[1] = $RayCast2D.target_position
