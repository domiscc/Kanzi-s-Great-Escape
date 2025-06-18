extends Node2D

@export var radius: float = 200.0
@export var color: Color = Color(1, 0, 0, 0.4)

var is_enabled: bool = false  # ✅ You define this manually

func _process(_delta):
	if is_enabled:
		queue_redraw()

func _draw():
	if not is_enabled:
		return

	var segments = 128  # smoother, more control over dash size
	var dash_length = 3
	var gap_length = 9
	var angle_step = TAU / segments

	for i in range(segments):
		var angle1 = i * angle_step
		var angle2 = (i + 1) * angle_step

		# Create dash-gap pattern
		if (i * (dash_length + gap_length)) % (dash_length + gap_length * 2) < dash_length:
			var point1 = Vector2(cos(angle1), sin(angle1)) * radius
			var point2 = Vector2(cos(angle2), sin(angle2)) * radius
			draw_line(point1, point2, Color.WHITE, 1.0)
