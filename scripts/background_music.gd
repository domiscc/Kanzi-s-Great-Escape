extends AudioStreamPlayer

var start_volume = 0.25
var bus_index

func _ready() -> void:
	bus_index = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(start_volume))
