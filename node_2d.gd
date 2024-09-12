extends Node2D

@export var Noise_height_text : NoiseTexture2D
var noise : Noise
var width : int = 1920
var height : int = 1920
var noise_val_arr = []
@onready var Tileemap = $TileMapLayer
var sourceid = 0 #I dont know what this is yet
var tree_atlas = Vector2i(2, 2)
var deep_water_atlas = Vector2i(5, 1) # This does not work
var water_atlas = Vector2i(6, 0) #huh
var land_atlas = Vector2i(3, 1) #its 11:30 pm and I have to wake up at 7 am :D
#I begin to understand the 3 lines before this comment
func _ready() -> void:
	noise = Noise_height_text.noise
	gen_world()
func gen_world():
	for x in range(-width/2, width/2):
		for y in range(-height/2, height/2):
			var noise_val = noise.get_noise_2d(x, y)
			if noise_val >= 0.1:
				if noise.get_noise_2d(x-1, y)>=0.0 and noise.get_noise_2d(x+1, y)>=0.0:
					if randi_range(1, 4)<=1:
						Tileemap.set_cell(Vector2(x, y), sourceid, tree_atlas)
				else:
					Tileemap.set_cell(Vector2(x, y), sourceid, land_atlas)
			else:
				if noise_val<= 0.05:
					Tileemap.set_cell(Vector2(x, y), sourceid, deep_water_atlas)
				else:
					Tileemap.set_cell(Vector2(x, y), sourceid, water_atlas)
	for x in range(-width/2, width/2):
		for y in range(-height/2, height/2):
			var noise_val = noise.get_noise_2d(x, y)
			var nextnoise = noise.get_noise_2d(x+1, y)
			var lastnoise = noise.get_noise_2d(x-1, y)
			var highnoise = noise.get_noise_2d(x, y+1)
			var lownoise = noise.get_noise_2d(x, y-1)
			if noise_val>0.01:
				if nextnoise>noise_val and lastnoise>noise_val and highnoise>noise_val and lownoise>noise_val:
					Tileemap.set_cell(Vector2(x, y), sourceid, tree_atlas)
			elif noise_val<=0.1:
				if nextnoise>noise_val and lastnoise>noise_val and highnoise>noise_val and lownoise>noise_val:
					Tileemap.set_cell(Vector2(x, y), sourceid, deep_water_atlas)
func _on_timer_timeout() -> void:
	gen_world()
