class_name Projectile
extends CharacterBody2D

var speed : float = 200.0
var direction : Vector2
var traj_sample_point: float = 0.0
var traj_height_scale: float = 100.0

var simulated_3d_space: Vector3 = Vector3.ZERO

@export var sprite : Sprite2D
@export var trajectory: Curve
@onready var explode_area: Area2D = $ExplosionRadius


var player : Player:
	get():
		if !player:
			player = Singletons.player
		return player


func _ready() -> void:
	if player:
		global_position = player.aim_position
		direction = player.aim_direction
		velocity = direction * speed
		sprite.rotation = randf_range(-180.0, 180.0)


func _physics_process(delta: float) -> void:
	# TODO: make the bomb arc more accurate (using velocity)
	# currently it's not good. we need to make it go in the direction where "up" in 3D would be, then back down.
	# then, make the bomb move away from the player in the direction variable's direction.
	
	traj_sample_point += delta
	#velocity = direction * 50
	
	#simulated_3d_space = Vector3(direction.x, -trajectory.sample(traj_sample_point), direction.y)
	
	if traj_sample_point >= 1.0:
		#await get_tree().create_timer(0.1).timeout
		explode()
	elif traj_sample_point <= 0.95:
		sprite.rotation_degrees += 5
		var vertical: float = trajectory.sample(traj_sample_point)
		sprite.position.y = -vertical * traj_height_scale
		move_and_slide()


func explode() -> void:
	if not explode_area.has_overlapping_bodies(): queue_free(); return
	
	var explode_shape: CollisionShape2D = $ExplosionRadius/CollisionShape2D
	if not explode_shape or not explode_shape.shape: queue_free(); return
	
	var shape: Shape2D = explode_shape.shape
	var area_transform: Transform2D = explode_area.global_transform
	var radius: float = shape.radius
	
	var tilemap: TileMapLayer = Singletons.terrain_top
	
	var radius_vector: Vector2 = Vector2(radius, radius)
	
	var top_left: Vector2i = tilemap.local_to_map(tilemap.to_local(area_transform.origin - radius_vector))
	var bottom_right: Vector2i = tilemap.local_to_map(tilemap.to_local(area_transform.origin + radius_vector))
	
	var overlapping_tiles: Array[Vector2i] = []
	
	for x: int in range(min(top_left.x, bottom_right.x), max(top_left.x, bottom_right.x) + 1):
		for y: int in range(min(top_left.y, bottom_right.y), max(top_left.y, bottom_right.y) + 1):
			var coords: Vector2i = Vector2i(x, y)
			var global_coords: Vector2 = tilemap.to_global(tilemap.map_to_local(coords))
			var distance: float = global_coords.distance_to(self.global_position)
			if distance <= radius and tilemap.get_cell_source_id(coords) != -1:
				overlapping_tiles.append(coords)
	
	tilemap.destroy_tiles(overlapping_tiles)
	SignalBus.bomb_exploded.emit(self.global_position)
	
	queue_free()
