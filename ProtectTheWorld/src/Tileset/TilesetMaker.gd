extends Node

var tile_size = Vector2(128, 128)
onready var texture = $Sprite.texture

func _ready():
	var text_width = texture.get_width() / tile_size.x
	var text_height= texture.get_height() / tile_size.y
	var Tileset_object = TileSet.new()
	
	for x in range(text_width):
		for y in range(text_height):
			var region = Rect2(x * tile_size.x, y * tile_size.y, tile_size.x, tile_size.y)
			var Tile_id = x + y * 10
			Tileset_object.create_tile(Tile_id)
			Tileset_object.tile_set_texture(Tile_id, texture)
			Tileset_object.tile_set_region(Tile_id, region)
	
# warning-ignore:return_value_discarded
	ResourceSaver.save("res://assets/Terrain/terrain_tiles.tres", Tileset_object)
