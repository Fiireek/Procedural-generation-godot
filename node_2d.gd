extends Node2D

@export var Noise_height_text : NoiseTexture2D
var noise : Noise
var width : int = 1000
var height : int = 1000
var noise_val_arr = []
@onready var Tileemap = $TileMapLayer
var sourceid = 0 #I dont know what this is yet
var water_atlas = Vector2i(7, 0) #huh
var land_atlas = Vector2i(1, 1) #its 11:30 pm and I have to wake up at 7 am :D
#I begin to understand the 3 lines before this comment
func _ready() -> void:
	noise = Noise_height_text.noise
	gen_world()
func gen_world():
	for x in range(-width/2, width/2):
		for y in range(-height/2, height/2):
			var noise_val = noise.get_noise_2d(x, y)
			if noise_val >= 0.0:
				Tileemap.set_cell(Vector2(x, y), sourceid, land_atlas)
			else:
				Tileemap.set_cell(Vector2(x, y), sourceid, water_atlas)
func _on_timer_timeout() -> void:
	gen_world()
