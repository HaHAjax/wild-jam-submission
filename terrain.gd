class_name Terrain
extends TileMapLayer

enum TerrainType {
	CHOOSE = 0,
	TOP,
	BOTTOM
}

@export var terrain_type: TerrainType


func destroy_tiles(tiles_coords: Array[Vector2i]) -> void:
	if terrain_type != TerrainType.TOP: return
	
	for coord: Vector2i in tiles_coords:
		erase_cell(coord)
