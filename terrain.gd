class_name Terrain
extends TileMapLayer
## A class for terrain layers, to more easily manipulate tiles.


## The types of terrain.
enum TerrainTypes {
	CHOOSE = 0,
	TOP,
	BOTTOM
}

## CHANGE THE TYPE FROM CHOOSE PLEASE [br]
## The type of terrain that this [Terrain] represents.
## Currently there is only top and bottom, and more layers currently have not been discussed.
@export var terrain_type: TerrainTypes


## Destroys the tiles at the (tile)map coordinates [code]tiles_coords[/code]
func destroy_tiles(tiles_coords: Array[Vector2i]) -> void:
	# don't destroy tiles that are not at the top layer
	if terrain_type != TerrainTypes.TOP: return
	
	# erases all tile cells at the inputted coordinate array
	for coord: Vector2i in tiles_coords:
		erase_cell(coord)
	
	# updates the surrounding cells visually (this function should be renamed, it's really not that clear what it does)
	set_cells_terrain_connect(tiles_coords, 0, -1)
