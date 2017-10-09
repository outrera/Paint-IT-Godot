GDPC                                                                                  @   res://.import/arrow.wav-21566a48b0eeffd590c8c29224c4a97f.sample `%     �6      �[Ikىn�`��Б��@   res://.import/button.png-234620e182281afdeb4aab4d2ed4f8a7.stex  @]     �       �r0'_�@��� @   res://.import/design.png-17e10c0f51ed03ca190409b2c58f0fa9.stex  �i     �*      S���;�[����f<   res://.import/icon.png-487276ed1e3a0c39cad0279d744ee560.stex`�     x      �}"n8;ϩ�����'�@   res://.import/jump.wav-14683e0efd5a66adca0a851c79ecec1c.sample  ��     %2      �oJ��1PS�m����H   res://.import/paint_it_bgm.ogg-2455281902dd547e251bb619a1bfa679.oggstr  ��     �!     ��z��Ӎ�ݦ��
3   res://AI.tscn   �      �      �G@� y���B��	   res://ArrowPU.gd�      P      �z=��F�>��   res://ArrowPU.tscn  �      �      �Z��A����+I��d   res://BoardManager.gd   �      e      ͖��j�O��P)+��   res://CharacterAI.gdP0      �      �}09�CF�$T[�ogk�   res://CharacterController.gd?      l      �I�62P�=e��j�V   res://CharacterManager.gd   �[      =      ��UO,�fU����   res://GameManager.gd�f      0      @��л�_�U��C���   res://Global.gd �r      �       T\�*���΂�sW��   res://MainMenu.gd   �s      4      S�J���f�"9��a   res://Player.gd 0�      q      ��_�ݤ���$����1   res://Player.tscn   ��      �      Qg�����y�ɢL�g�   res://PowerUP.gd��            ��rב$��������   res://TileHelper.gd ��      0      '��W����L�b4l_}�   res://VCR_OSD_MONO_1.001.ttf�      X(     _�le��g�c,p_	D�   res://World.tscn@�     Y      o��k1~��~y�?�   res://arrow.wav.import   \           )9&G�G�Y��
u   res://button.png.import  ^     �      �u���_���̱H�Y   res://default_env.tres  �_     �	      ����ɬEOL��6P�   res://design.png.import P�     �      ��L/��BO����4�   res://font_vcr_osd_mono.tres �     1      ��6�L�޻�t�)*    res://font_vcr_osd_mono_big.tres@�            G��V�2�a81�-%���   res://icon.png.import   ��     �      .�ma���P�n�a�K   res://jump.wav.import   ��           J�=��}!5���$�/_    res://paint_it_bgm.ogg.import   ��     �       ylWFp�2c{;0�62   res://project.binary@�           ��U���(� ǘ�v[gd_scene load_steps=4 format=2]

[ext_resource path="res://design.png" type="Texture" id=1]
[ext_resource path="res://CharacterAI.gd" type="Script" id=2]
[ext_resource path="res://jump.wav" type="AudioStream" id=3]

[node name="Red" type="Node2D"]

[node name="Red" type="Sprite" parent="."]

texture = ExtResource( 1 )
centered = false
vframes = 10
hframes = 10
frame = 12
script = ExtResource( 2 )
_sections_unfolded = [ "Animation", "Offset", "Transform" ]
auto_setup_by_name = true
char_id = 1
move_time = 0.5
jump_height = 15
frame_left = 23
frame_up = 12
frame_right = 13
frame_down = 22
jump_sfx = ExtResource( 3 )
start_position = 1
offset_position = Vector2( 17, 12 )

[node name="Tween" type="Tween" parent="Red"]

playback_process_mode = 1
playback/active = false
playback/repeat = false
playback/speed = 1.0
_sections_unfolded = [ "playback" ]

[node name="TweenJump" type="Tween" parent="Red"]

playback_process_mode = 1
playback/active = false
playback/repeat = false
playback/speed = 1.0
_sections_unfolded = [ "playback" ]

[node name="TweenFall" type="Tween" parent="Red"]

playback_process_mode = 1
playback/active = false
playback/repeat = false
playback/speed = 1.0
_sections_unfolded = [ "playback" ]

[node name="Area2D" type="Area2D" parent="Red"]

position = Vector2( 16, 22 )
input_pickable = true
gravity_vec = Vector2( 0, 1 )
gravity = 98.0
linear_damp = 0.1
angular_damp = 1.0
audio_bus_override = false
audio_bus_name = "Master"

[node name="CollisionPolygon2D" type="CollisionPolygon2D" parent="Red/Area2D"]

build_mode = 0
polygon = PoolVector2Array( -16, 7, 5, 16, 17, 10, -4, 0 )

[node name="audio" type="AudioStreamPlayer" parent="Red"]

stream = ExtResource( 3 )
volume_db = -10.0
autoplay = false
mix_target = 0
bus = "Master"


         extends "res://PowerUP.gd"

enum DIRECTION {
	DOWN, LEFT, UP, RIGHT, DOWN_UP, LEFT_RIGHT
}

#export var offset_position = Vector2(0,0)

export var dir = DIRECTION.DOWN


func _ready():
	sfx = preload("res://arrow.wav")

func do_power_up(id):
	.do_power_up(id)
	if dir == DIRECTION.DOWN:
		var start = current_pos_tile.y
		for i in board_manager.height - start:
			if i + start != current_pos_tile.y:
				#set tile color
				var c_pos = Vector2(current_pos_tile.x, i + start)
				board_manager.change_tile_id_at(c_pos, id)
				board_manager.tile_dict[c_pos].push_down_tween()
				board_manager.start_counting_claim_tile(c_pos, id)
	elif dir == DIRECTION.LEFT:
		var start = current_pos_tile.x
		for i in start:
			if i != current_pos_tile.x:
				#set tile color
				var c_pos = Vector2(i, current_pos_tile.y)
				board_manager.change_tile_id_at(c_pos, id)
				board_manager.tile_dict[c_pos].push_down_tween()
				board_manager.start_counting_claim_tile(c_pos, id)
	elif dir == DIRECTION.UP:
		var start = current_pos_tile.y
		for i in start:
			if i != current_pos_tile.y:
			#set tile color
				var c_pos = Vector2(current_pos_tile.x, i)
				board_manager.change_tile_id_at(c_pos, id)
				board_manager.tile_dict[c_pos].push_down_tween()
				board_manager.start_counting_claim_tile(c_pos, id)
	elif dir == DIRECTION.RIGHT:
		var start = current_pos_tile.x
		for i in board_manager.width - start:
			if i + start != current_pos_tile.x:
				#set tile color
				var c_pos = Vector2(i + start, current_pos_tile.y)
				board_manager.change_tile_id_at(c_pos, id)
				board_manager.tile_dict[c_pos].push_down_tween()
				board_manager.start_counting_claim_tile(c_pos, id)
	elif dir == DIRECTION.DOWN_UP:
		for i in board_manager.height:
			if i != current_pos_tile.y:
				var c_pos = Vector2(current_pos_tile.x, i)
				board_manager.change_tile_id_at(c_pos, id)
				board_manager.tile_dict[c_pos].push_down_tween()
				board_manager.start_counting_claim_tile(c_pos, id)
	elif dir == DIRECTION.LEFT_RIGHT:
		for i in board_manager.width:
			if i != current_pos_tile.x:
				var c_pos = Vector2(i, current_pos_tile.y)
				board_manager.change_tile_id_at(c_pos, id)
				board_manager.tile_dict[c_pos].push_down_tween()
				board_manager.start_counting_claim_tile(c_pos, id)
			
		
	
	queue_free()

func randomize_position():
	.randomize_position()
	random_direction()

func random_direction():
	var candidate = []
	
	#RIGHT
	if current_pos_tile.x < 5:
		candidate.push_back(3)
	#LEFT
	if current_pos_tile.x >= 5:
		candidate.push_back(1)
	#RIGHT LEFT
	if current_pos_tile.x > 3 and current_pos_tile.x < 6:
		candidate.push_back(5)
	#DOWN
	if current_pos_tile.y < 5:
		candidate.push_back(0)
	#UP
	if current_pos_tile.y >= 5:
		candidate.push_back(2)
	#DOWN UP
	if current_pos_tile.y > 3 and current_pos_tile.y < 6:
		candidate.push_back(4)
	
	dir = candidate[randi() % candidate.size()]
	
	frame += dir



	[gd_scene load_steps=4 format=2]

[ext_resource path="res://design.png" type="Texture" id=1]
[ext_resource path="res://ArrowPU.gd" type="Script" id=2]
[ext_resource path="res://arrow.wav" type="AudioStream" id=3]

[node name="ArrowPU" type="Sprite"]

position = Vector2( 310, 270 )
texture = ExtResource( 1 )
centered = false
vframes = 10
hframes = 10
frame = 40
script = ExtResource( 2 )
_sections_unfolded = [ "Animation", "Offset" ]
dir = 0

[node name="Area2D" type="Area2D" parent="."]

position = Vector2( 32, 15 )
input_pickable = true
gravity_vec = Vector2( 0, 1 )
gravity = 98.0
linear_damp = 0.1
angular_damp = 1.0
audio_bus_override = false
audio_bus_name = "Master"

[node name="CollisionPolygon2D" type="CollisionPolygon2D" parent="Area2D"]

position = Vector2( 3, 1 )
build_mode = 0
polygon = PoolVector2Array( -19, -6, 2, 5, 11, 0, -11, -11 )

[node name="audio" type="AudioStreamPlayer" parent="."]

stream = ExtResource( 3 )
volume_db = -12.0
autoplay = false
mix_target = 0
bus = "Master"


               extends Node2D

export(Texture) var sprite
export(Vector2) var tileSize = Vector2(66,35)
export var tileOffset = Vector2(1, 2)
export var width = 10
export var height = 10

export var min_pu_time = 8
export var max_pu_time = 20
export var max_pu_at_board = 8

export(PackedScene) var arrow_pu_scene

onready var aStar = AStar.new()
#register all Power UP here
onready var power_ups = [arrow_pu_scene]
var pu_active_array = []

#Key : x,y
#Value : node
var tile_dict = {
	"Key" : "Color"
}

func _ready():
	setup_board()
	$Timer.connect("timeout", self, "restart_pu_timer")
	$Timer.one_shot = true
	$Timer.wait_time = min_pu_time + (randf() * (max_pu_time - min_pu_time))
	$Timer.start()

func restart_pu_timer():
	var r = randi() % power_ups.size()
	var pu = power_ups[r].instance()
	add_child(pu)
	pu.randomize_position()
	pu_active_array.push_back(pu)
	if pu_active_array.size() < max_pu_at_board:
		$Timer.wait_time = min_pu_time + (randf() * (max_pu_time - min_pu_time))
		$Timer.start()

func restart_timer_spawn_pu():
	$Timer.wait_time = min_pu_time + (randf() * (max_pu_time - min_pu_time))
	$Timer.start()

func is_pu_at(vec):
	for i in pu_active_array:
		if i.current_pos_tile == vec:
			return true
	
	return false

func translate_tile_to_position(tile_vec):
	return tile_dict[tile_vec].position

func setup_board():
	tile_dict.clear()
	var aStarPoints = []
	var start_pos = Vector2(round((get_node("/root").size.x / 2) - ((width + height) * .5) * tileSize.x * .5) ,round(get_node("/root").size.y / 2))
	for x in range(width):
		for y in range(height):
			var idx = 0
			if (x+y) % 2 == 1:
				idx = 1
			var next_pos = start_pos + (Vector2(round((tileSize.x - tileOffset.x) / 2), round((tileSize.y - tileOffset.y) /2)) * y)
			tile_dict[Vector2(x,y)] = create_tile(next_pos, idx)
			#set z
			tile_dict[Vector2(x,y)].z = y - x - height
			tile_dict[Vector2(x,y)].tile_pos = Vector2(x,y)
#			var pos = tile_dict[Vector2(x,y)].position
#			var vec3 = Vector3(pos.x, pos.y, 0)
			aStar.add_point((x* height) +y, Vector3(x, y, 0))
			aStarPoints.push_back((x* height) +y)
		
		start_pos.x += round((tileSize.x - tileOffset.x) / 2)
		start_pos.y -= round((tileSize.y - tileOffset.y) / 2)
	
	for p in aStarPoints.size():
		if p % (height - 1) != 0 or p == 0:
			aStar.connect_points(p, p+1)
		if p + height < width * height:
			aStar.connect_points(p, p + height)

func reset_board():
	reset_board_id()
	for i in pu_active_array:
		i.queue_free()
	
	pu_active_array.clear()

func reset_board_id():
	for i in tile_dict.values():
		i.set_tile_id(0)
		i.push_down_tween()

func disconnect_point(id):
	if id - 1 >= 0:
		aStar.disconnect_points(id, id-1)
	if int(id + 1) % height != 0:
		aStar.disconnect_points(id, id+1)
	if id + height < width * height:
		aStar.disconnect_points(id, id+height)
	if id - height >= 0:
		aStar.disconnect_points(id, id-height)

func reconnect_point(id):
	if id - 1 >= 0:
		aStar.connect_points(id, id-1)
	if int(id + 1) % height != 0:
		aStar.connect_points(id, id+1)
	if id + height < width * height:
		aStar.connect_points(id, id+height)
	if id - height >= 0:
		aStar.connect_points(id, id-height)

func reset_weight_point_and_reconnect(id, pos, weight = 1):
	aStar.remove_point(id)
	aStar.add_point(id, Vector3(pos.x, pos.y, 0), weight)
	if id - 1 >= 0:
		aStar.connect_points(id, id-1)
	if int(id + 1) % height != 0:
		aStar.connect_points(id, id+1)
	if id + height < width * height:
		aStar.connect_points(id, id+height)
	if id - height >= 0:
		aStar.connect_points(id, id-height)

func create_tile(pos, idx):
	var spr = Sprite.new()
	spr.texture = sprite
	spr.centered = false
	spr.region_enabled = true
	spr.region_rect = Rect2(tileSize.x * idx, 0, tileSize.x, tileSize.y)
#	spr.hframes = 10
#	spr.vframes = 10
#	spr.frame = idx
	spr.position = pos
	spr.set_script(preload("res://TileHelper.gd"))
	spr.region_origin = spr.region_rect
	
	self.add_child(spr)
	return spr

func change_tile_id_at(vec, id):
	tile_dict[vec].set_tile_id(id)

func start_counting_claim_tile(vec, id):
	tile_dict[vec].start_counting_claim_tile(id )

func get_current_tile():
	var result = { 
	"NA" : 0,
	"Blue" : 0,
	"Red" : 0,
	"Green" : 0,
	"Purple" : 0
	}
	
	for i in tile_dict.values():
		if i.tile_id == 0:
			result["NA"] += 1
		elif i.tile_id == 2:
			result["Blue"] += 1
		elif i.tile_id == 3:
			result["Red"] += 1
		elif i.tile_id == 4:
			result["Green"] += 1
		elif i.tile_id == 5:
			result["Purple"] += 1
	
	
	return result
           extends "res://CharacterController.gd"

# can be set as a difficulty level
var max_turn_wait_time =  .8
var is_waiting = false
var wait_time_counter = 0.0
var wait_time_needed = 0.0

var priority_movement = {
	"left" : true, "right" : true, "up" : true, "down" : true
	}

func _ready():
	
	set_fixed_process(true)

func setup_position():
	.setup_position()
	if start_position == 0:
		priority_movement["down"] = false
		priority_movement["left"] = false
	elif start_position == 1:
		priority_movement["up"] = false
		priority_movement["right"] = false
	elif start_position == 2:
		priority_movement["up"] = false
		priority_movement["left"] = false
	elif start_position == 3:
		priority_movement["right"] = false
		priority_movement["down"] = false

func _fixed_process(delta):
#	print(is_controllable)
#	print("MOVE" + str(can_move))
	if !is_controllable:
		return
	else:
		print(is_waiting)
	
	# make a priority move, next move priority is unoccupied tile
	# 0 = vertical or 1 = horizontal
	if can_move and is_waiting == false:
		var rand_array = []
		if priority_movement["right"]:
			rand_array.push_back(0)
		if priority_movement["left"]:
			rand_array.push_back(1)
		if priority_movement["up"]:
			rand_array.push_back(2)
		if priority_movement["down"]:
			rand_array.push_back(3)

		var move_id = 4
		if rand_array.size() != 0:
			var r = randi() % rand_array.size()
			move_id = rand_array[r]

		if move_id == 0:
			input.x = 1
		elif move_id == 1:
			input.x = -1
		elif move_id == 2:
			input.y = -1
		elif move_id == 3:
			input.y = 1
		else:
			get_nearest_direction()
	
		if(try_to_move()):
			get_neighbors()
		
		
		var timer = get_tree().create_timer(randf() * max_turn_wait_time)
		timer.connect("timeout", self, "wait_to_move")
		
		is_waiting = true
		

func wait_to_move():
	is_waiting = false

func get_nearest_direction():
	var nearest_tile = find_nearest_unoqupied_tile()
	var points = board_manager.aStar.get_point_path((current_pos_tile.x * board_manager.height) + current_pos_tile.y, (nearest_tile.x * board_manager.height)  + nearest_tile.y)
	var next_pos = points[1]
	var next_pos_v2 = Vector2(next_pos.x, next_pos.y)
	input = next_pos_v2 - current_pos_tile

func find_nearest_unoqupied_tile():
	var nearest_distance = INF
	var nearest_tile = Vector2(0,0)
	for t in board_manager.tile_dict.keys():
		if t != current_pos_tile and board_manager.tile_dict[t].tile_id != char_id + 2 and $"../..".is_tile_occupied(t) == false:
			var distance = t.distance_to(current_pos_tile)
			if nearest_distance > distance:
				nearest_distance = distance
				nearest_tile = t
	return nearest_tile

func get_neighbors():
	#reset
	priority_movement["right"] = false
	priority_movement["left"] = false
	priority_movement["up"] = false
	priority_movement["down"] = false
	# right
	if current_pos_tile.x + 1 < board_manager.width:
		if board_manager.tile_dict[current_pos_tile + Vector2(1, 0)].tile_id != char_id + 2 and $"../..".is_tile_occupied(current_pos_tile + Vector2(1, 0)) == false:
			priority_movement["right"] = true
	# left
	if current_pos_tile.x - 1 >= 0:
		if board_manager.tile_dict[current_pos_tile + Vector2(-1, 0)].tile_id != char_id + 2 and $"../..".is_tile_occupied(current_pos_tile + Vector2(-1, 0)) == false:
			priority_movement["left"] = true
	# up
	if current_pos_tile.y - 1 >= 0:
		if board_manager.tile_dict[current_pos_tile + Vector2(0, -1)].tile_id != char_id + 2 and $"../..".is_tile_occupied(current_pos_tile + Vector2(0, -1)) == false:
			priority_movement["up"] = true
	# down
	if current_pos_tile.y + 1 < board_manager.height:
		if board_manager.tile_dict[current_pos_tile + Vector2(0, 1)].tile_id != char_id + 2 and $"../..".is_tile_occupied(current_pos_tile + Vector2(0, 1)) == false:
			priority_movement["down"] = true             extends Sprite

export var auto_setup_by_name = true
# 0 = blue, 1 = red, 2 = green, 3 = purple
export var char_id = 0
export var move_time = .5
export var jump_height = 15

export var frame_left = 21
export var frame_up = 10
export var frame_right = 11
export var frame_down = 20

export(AudioStream) var jump_sfx

#0 bottom, 1 top, 2 left, 3 right
export(int, 0, 3) var start_position = 0
export var offset_position = Vector2(17, 12)

onready var target_jump_pos = get_parent().position + Vector2(0, -1) * jump_height
onready var target_fall_pos = get_parent().position
onready var audio_player = get_node("audio")


onready var board_manager = get_node("/root/Global").board_manager

var input = Vector2(0,0)
var can_move = true
var current_pos_tile = Vector2(0,0)
var is_controllable = false

func _ready():
	auto_setup_character()
	$TweenJump.connect("tween_completed", self, "fall_tween")
	setup_position()
	set_fixed_process(true)

func auto_setup_character():
	if auto_setup_by_name:
		if get_parent().get_name() == "Blue" || get_parent().get_name() == "Blue_bot":
			char_id = 0
			frame_left = 21
			frame_up = 10
			frame_right = 11
			frame_down = 20
			start_position = 0
		elif get_parent().get_name() == "Red" || get_parent().get_name() == "Red_bot":
			char_id = 1
			frame_left = 23
			frame_up = 12
			frame_right = 13
			frame_down = 22
			start_position = 1
		elif get_parent().get_name() == "Green" || get_parent().get_name() == "Green_bot":
			char_id = 2
			frame_left = 25
			frame_up = 14
			frame_right = 15
			frame_down = 24
			start_position = 2
		elif get_parent().get_name() == "Purple" || get_parent().get_name() == "Purple_bot":
			char_id = 3
			frame_left = 27
			frame_up = 16
			frame_right = 17
			frame_down = 26
			start_position = 3

func _fixed_process(delta):
	if !is_controllable:
		return
	area_2d_collision()

func area_2d_collision():
	var areas = $Area2D.get_overlapping_areas()
	if areas.size() != 0 && areas.size() < 2:
		if areas[0].get_parent().get_script() == get_node("/root/Global").arrow_pu_class:
			areas[0].get_parent().do_power_up(char_id + 2)
			if areas[0].get_parent().sfx != null:
				play_sfx(areas[0].get_parent().sfx)
			
	elif areas.size() > 1:
		print("SOMETHING WHEN WRONG : WHY DETECTED AREAS MORE THAN 1???!")

func try_to_move():
	if !is_controllable:
		return false
	var result = false
	var motion = Vector2(0,0)
	if input.x == 1:
		input.x = 1
		motion = (board_manager.tileSize - board_manager.tileOffset) / 2
		motion.y *= -1
	elif input.x == -1:
		motion = (board_manager.tileSize - board_manager.tileOffset) / 2
		motion.x *= -1
	elif input.y == -1:
		motion = (board_manager.tileSize - board_manager.tileOffset) / 2
		motion.x *= -1
		motion.y *= -1
	elif input.y == 1:
		motion = (board_manager.tileSize - board_manager.tileOffset) / 2
	else: input = Vector2(0,0)
	
	if input != Vector2(0,0):
		if can_move:
			if current_pos_tile.x + input.x > board_manager.width - 1 or current_pos_tile.x + input.x < 0 or current_pos_tile.y + input.y > board_manager.height - 1 or current_pos_tile.y + input.y < 0:
				#Do Nothing
				pass
			else:
				result = move(motion)
#				play_sfx(jump_sfx)
				
				#create timer for disabling moving time
				can_move = false
				var timer = get_tree().create_timer(move_time)
				timer.connect("timeout", self, "enable_move")
		#reset input
		input = Vector2(0,0)
	
	return result

func move(motion):
	if !is_controllable:
		return false
	
	#swap sprite
	if input.x == 1 and input.y == 0 and frame != frame_right:
		frame = frame_right
	elif input.x == -1 and input.y == 0 and frame != frame_left:
		frame = frame_left
	elif input.x == 0 and input.y == -1 and frame != frame_up:
		frame = frame_up
	elif input.x == 0 and input.y == 1 and frame != frame_down:
		frame = frame_down
	
	#TO-DO : Handle colliding between other character using checking current_pos_tile
	if $"../..".is_tile_occupied(current_pos_tile + input):
		#Do Nothing
		return false
	else:
		$Tween.interpolate_property(self, "position", position, position + motion, move_time, Tween.TRANS_CUBIC, Tween.EASE_IN)
		$Tween.start()
		
		$TweenJump.interpolate_property(get_parent(), "position", get_parent().position, target_jump_pos, move_time * 0.7, Tween.TRANS_CIRC, Tween.EASE_IN)
		$TweenJump.start()
		
		#remove and add point with lower weight to the current position
		board_manager.reset_weight_point_and_reconnect((current_pos_tile.x * board_manager.height) + current_pos_tile.y, current_pos_tile)
		#reconnect current position
#		board_manager.reconnect_point((current_pos_tile.x * board_manager.height) + current_pos_tile.y)
		#start claiming when character leaving the tile
		board_manager.start_counting_claim_tile(current_pos_tile, char_id + 2)
		
		current_pos_tile += input
		
		#remove and add point with different weight to the new position
		board_manager.reset_weight_point_and_reconnect((current_pos_tile.x * board_manager.height) + current_pos_tile.y, current_pos_tile, board_manager.width * board_manager.height)
		#disconnect current point because of tile is currently occupied by character
#		board_manager.disconnect_point((current_pos_tile.x * board_manager.height) + current_pos_tile.y)
		
		$"../..".fix_z_order()
		
	return true
	

func fall_tween(object, key):
	$TweenFall.interpolate_property(get_parent(), "position", get_parent().position, target_fall_pos, move_time * 0.3, Tween.TRANS_CIRC, Tween.EASE_OUT)
	$TweenFall.start()
	board_manager.tile_dict[current_pos_tile].push_down_tween()

func enable_move():
	can_move = true
	#set tile color
	#when restart the game, all object still active and script still running, and that means, 
	#this tween still running and when restarting the game with tween running, the tile will automatically 
	#change the color, this is the prevention
	if is_controllable:
		board_manager.change_tile_id_at(current_pos_tile, char_id + 2)
		board_manager.tile_dict[current_pos_tile].force_stop_timer()

func setup_position():
	#Reset tween if needed
	if $Tween.is_active():
		$Tween.remove_all()
	if $TweenFall.is_active():
		$TweenFall.remove_all()
	
	if start_position == 0:
		current_pos_tile = Vector2(0, board_manager.height-1)
		frame = frame_up
	elif start_position == 1:
		current_pos_tile = Vector2(board_manager.width - 1, 0)
		frame = frame_down
	elif start_position == 2:
		current_pos_tile = Vector2(0, 0)
		frame = frame_right
	elif start_position == 3:
		current_pos_tile = Vector2(board_manager.width - 1, board_manager.height-1)
		frame = frame_left
	
	set_position_reference_tile_dict(current_pos_tile)
	position = position
	
	#set the tile color
	board_manager.change_tile_id_at(current_pos_tile, char_id + 2)
	#remove and add point with different weight to the new position
	board_manager.reset_weight_point_and_reconnect((current_pos_tile.x * board_manager.height) + current_pos_tile.y, current_pos_tile, board_manager.width * board_manager.height)

func set_position_reference_tile_dict(vec):
	var target_spr = board_manager.tile_dict[Vector2(vec.x, vec.y)]
	position = target_spr.position + Vector2(abs(offset_position.x), abs(offset_position.y) * -1)

func play_sfx(aud):
	if !board_manager.get_parent().is_game_over:
		if audio_player.get_stream() != aud:
			audio_player.set_stream(aud)
		audio_player.play()    extends Node2D

export(PackedScene) var player_scene
export(PackedScene) var ai_scene
var character_active_array = []
var player_array = []
var ai_array = []

onready var board_manager = get_node("/root/Global").board_manager

func _ready():
	create_all_characters()
	reset_and_setup_all_characters(0, 1)

func create_all_characters():
	for i in 4:
		var pl = player_scene.instance()
		if i == 0:
			pl.set_name("Blue")
		elif i == 1:
			pl.set_name("Red")
		elif i == 2:
			pl.set_name("Green")
		else:
			pl.set_name("Purple")
		add_child(pl)
		pl.hide()
		player_array.push_back(pl)
		
	for i in 4:
		var a = ai_scene.instance()
		if i == 0:
			a.set_name("Blue_bot")
		elif i == 1:
			a.set_name("Red_bot")
		elif i == 2:
			a.set_name("Green_bot")
		else:
			a.set_name("Purple_bot")
		add_child(a)
		a.hide()
		ai_array.push_back(a)

func reset_and_setup_all_characters(player, ai):
#	remove_all_characters()
	character_active_array.clear()
	for i in player_array.size():
		if i < player:
			player_array[i].show()
			player_array[i].get_child(0).is_controllable = true
			player_array[i].get_child(0).can_move = true
			character_active_array.push_back(player_array[i])
			player_array[i].get_child(0).setup_position()
		else:
			player_array[i].hide()
			player_array[i].get_child(0).is_controllable = false
			player_array[i].get_child(0).position = Vector2(0,i * -1 * 30)
	
	for i in ai_array.size():
		if i < player or i >= ai + player:
			ai_array[i].hide()
			ai_array[i].get_child(0).is_controllable = false
			ai_array[i].get_child(0).position = Vector2(-60,i * -1 * 30)
		elif i < ai + player:
			ai_array[i].show()
			ai_array[i].get_child(0).is_controllable = true
			ai_array[i].get_child(0).can_move = true
			character_active_array.push_back(ai_array[i])
			ai_array[i].get_child(0).setup_position()
	

#func gather_child():
#	character_active_array.clear()
#	for i in get_child_count():
#		character_active_array.push_back(get_child(i).get_child(0))
#		print(get_child(i).get_child(0))
#	print(get_child_count())

#func remove_all_characters():
#	for i in character_active_array.size():
#		character_active_array[i].get_parent().queue_free()
#	character_active_array.clear()

func is_tile_occupied(vec):
	for i in character_active_array.size():
		if character_active_array[i].get_child(0).current_pos_tile == vec:
			return true
		
	return false

func fix_z_order():
	for i in character_active_array.size():
		character_active_array[i].get_child(0).z = board_manager.tile_dict[character_active_array[i].get_child(0).current_pos_tile].z + 1

func re_assign_player_input(player):
	if player == 1:
		player_array[0].get_child(0).re_assign_control()
	elif player == 2:
		player_array[1].get_child(0).re_assign_control()
	elif player == 3:
		player_array[2].get_child(0).re_assign_control()
	elif player == 4:
		player_array[3].get_child(0).re_assign_control()   extends Node2D

export var max_game_time = 240
export var time_to_claim_score = 8
export(NodePath) var timer_label_path

export(NodePath) var blue_score_path
export(NodePath) var red_score_path
export(NodePath) var green_score_path
export(NodePath) var purple_score_path

onready var timer = Timer.new()
#2 Blue, 3 Red, 4 Green, 5 Purple
var scores = {
	2 : 0,
	3 : 0,
	4 : 0,
	5 : 0
	}

var player_counts = 0
var bot_counts = 1
var is_game_over = true

var player_1_controls = {
	"left" : 16777231,
	"down" : 16777234,
	"right" : 16777233,
	"up" : 16777232
	}
var player_2_controls = {
	"left" : 83,
	"down" : 65,
	"right" : 87,
	"up" : 81
	}
var player_3_controls = {
	"left" : 75,
	"down" : 76,
	"right" : 79,
	"up" : 73
	}
var player_4_controls = {
	"left" : 16777351,
	"down" : 16777352,
	"right" : 16777355,
	"up" : 16777354
	}

onready var timer_label = get_node(timer_label_path)
onready var blue_score_label = get_node(blue_score_path)
onready var red_score_label = get_node(red_score_path)
onready var green_score_label = get_node(green_score_path)
onready var purple_score_label = get_node(purple_score_path)

onready var board_manager = get_node("/root/Global").board_manager
onready var character_manager = get_node("CharacterManager")

func _ready():
	add_child(timer)
	timer.one_shot = true
	timer.connect("timeout", self, "game_over")
	set_process(true)
	set_fixed_process(true)

func _process(delta):
	if is_game_over:
		return
	timer_label.text = translate_float_to_time(timer.get_time_left())

func _fixed_process(delta):
	if is_game_over:
		return
	update_score()

func start_timer():
	timer.wait_time = max_game_time
	timer.start()

func game_over():
	update_score()
	var winner_id = 0
	for i in scores.keys():
		if winner_id == 0:
			winner_id = i
		else:
			if scores[winner_id] < scores[i]:
				winner_id = i
	
	var txt = "Blue WINS"
	if winner_id == 3:
		txt = "Red WINS"
	elif winner_id == 4:
		txt = "Green WINS"
	elif winner_id == 5:
		txt= "Purple WINS"
	$GameOverUI.show()
	get_node("GameOverUI/Panel/Label").text = txt
	
	# ALL CHARACTER STOP!
	for i in character_manager.character_active_array:
		i.get_child(0).is_controllable = false
		board_manager.reset_weight_point_and_reconnect((i.get_child(0).current_pos_tile.x * board_manager.height) + i.get_child(0).current_pos_tile.y, i.get_child(0).current_pos_tile)
	

func translate_float_to_time(f):
	var minute = int(ceil(f)) / 60
	var seconds = int(ceil(f)) % 60
	
	var seconds_str = str(seconds)
	if seconds < 10:
		seconds_str = "0" + seconds_str
	
	return str(minute) + ":" + seconds_str

func update_score():
	blue_score_label.text = str(scores[2])
	red_score_label.text = str(scores[3])
	green_score_label.text = str(scores[4])
	purple_score_label.text = str(scores[5])

func get_tile_status():
	return board_manager.get_current_tile()

func restart_game():
	restart_without_timer()
	start_timer()
	is_game_over = false

func restart_without_timer():
	board_manager.reset_board()
	character_manager.reset_and_setup_all_characters(player_counts, bot_counts)
	# reset score
	for i in scores.keys():
		scores[i] = 0
	update_score()


extends Node

onready var board_manager = get_parent().get_node("World").get_node("BoardManager")
onready var character_manager = get_parent().get_node("World").get_node("CharacterManager")
const arrow_pu_class = preload("res://ArrowPU.gd")
               extends Control

onready var game_manager = get_node("..")

#0 nothing happen, 1 player 1, 2 player 2, 3 player 3, 4 player 4
var control_status = 0
var setup_counter = 0
var current_control_setup = []

func _ready():
	set_process_input(true)

func _input(event):
	if control_status == 0:
		return
	if event.is_class("InputEventKey"):
		if !current_control_setup.has(event.scancode):
			current_control_setup.push_back(event.scancode)
			if current_control_setup.size() == 0:
				get_node("Controls/Panel/Label").text = "Player " + str(control_status) + " - Press LEFT Key"
			elif current_control_setup.size() == 1:
				get_node("Controls/Panel/Label").text = "Player " + str(control_status) + " - Press RIGHT Key"
			elif current_control_setup.size() == 2:
				get_node("Controls/Panel/Label").text = "Player " + str(control_status) + " - Press UP Key"
			elif current_control_setup.size() == 3:
				get_node("Controls/Panel/Label").text = "Player " + str(control_status) + " - Press DOWN Key"
		
		if current_control_setup.size() == 4:
			#done
			if control_status == 1:
				game_manager.player_1_controls["left"] = current_control_setup[0]
				game_manager.player_1_controls["right"] = current_control_setup[1]
				game_manager.player_1_controls["up"] = current_control_setup[2]
				game_manager.player_1_controls["down"] = current_control_setup[3]
			elif control_status == 2:
				game_manager.player_2_controls["left"] = current_control_setup[0]
				game_manager.player_2_controls["right"] = current_control_setup[1]
				game_manager.player_2_controls["up"] = current_control_setup[2]
				game_manager.player_2_controls["down"] = current_control_setup[3]
			elif control_status == 3:
				game_manager.player_3_controls["left"] = current_control_setup[0]
				game_manager.player_3_controls["right"] = current_control_setup[1]
				game_manager.player_3_controls["up"] = current_control_setup[2]
				game_manager.player_3_controls["down"] = current_control_setup[3]
			elif control_status == 4:
				game_manager.player_4_controls["left"] = current_control_setup[0]
				game_manager.player_4_controls["right"] = current_control_setup[1]
				game_manager.player_4_controls["up"] = current_control_setup[2]
				game_manager.player_4_controls["down"] = current_control_setup[3]
			$"../CharacterManager".re_assign_player_input(control_status)
			current_control_setup.clear()
			control_status = 0
			
			get_node("Controls/Panel").hide()
			get_node("Controls/Controls").show()

func start_game():
	game_manager.restart_game()
	get_node("../GameUI").show()
	#show and hide character ui
	for i in 4:
		if i < game_manager.player_counts + game_manager.bot_counts:
			$"../GameUI".get_child(i).show()
		else:
			$"../GameUI".get_child(i).hide()
		

func _on_SinglePlayer_button_up():
	game_manager.player_counts = 1
	$"PlayMode".hide()
	$"Select Bot".show()
	$"Select Bot/No Bot".hide()

func _on_2_Player_button_up():
	game_manager.player_counts = 2
	$"PlayMode".hide()
	$"Select Bot/3 Bots".hide()
	$"Select Bot".show()
	$"Select Bot/No Bot".show()


func _on_3_Player_button_up():
	game_manager.player_counts = 3
	$"PlayMode".hide()
	$"Select Bot/2 Bots".hide()
	$"Select Bot/3 Bots".hide()
	$"Select Bot".show()
	$"Select Bot/No Bot".show()


func _on_4_Player_button_up():
	game_manager.player_counts = 4
	game_manager.bot_counts = 0
	$"PlayMode".hide()
	$Time.show()


func _on_Controls_button_up():
	$Controls.show()
	$PlayMode.hide()


func _on_1_Bot_button_up():
	game_manager.bot_counts = 1
	$"Select Bot".hide()
	$Time.show()


func _on_2_Bots_button_up():
	game_manager.bot_counts = 2
	$"Select Bot".hide()
	$Time.show()


func _on_3_Bots_button_up():
	game_manager.bot_counts = 3
	$"Select Bot".hide()
	$Time.show()


func _on_No_Bot_button_up():
	game_manager.bot_counts = 0
	$Time.show()


func _on_1_button_up():
	game_manager.max_game_time = 60
	$Time.hide()
	start_game()


func _on_2_button_up():
	game_manager.max_game_time = 120
	$Time.hide()
	start_game()


func _on_4_button_up():
	game_manager.max_game_time = 240
	$Time.hide()
	start_game()


func _on_Player_1_button_up():
	control_status = 1
	get_node("Controls/Panel").show()
	get_node("Controls/Panel/Label").text = "Player " + str(control_status) + " - Press LEFT Key"
	get_node("Controls/Controls").hide()
	

func _on_Player_2_button_up():
	control_status = 2
	get_node("Controls/Panel").show()
	get_node("Controls/Panel/Label").text = "Player " + str(control_status) + " - Press LEFT Key"
	get_node("Controls/Controls").hide()


func _on_Player_3_button_up():
	control_status = 3
	get_node("Controls/Panel").show()
	get_node("Controls/Panel/Label").text = "Player " + str(control_status) + " - Press LEFT Key"
	get_node("Controls/Controls").hide()


func _on_Player_4_button_up():
	control_status = 4
	get_node("Controls/Panel").show()
	get_node("Controls/Panel/Label").text = "Player " + str(control_status) + " - Press LEFT Key"
	get_node("Controls/Controls").hide()


func _on_Back_button_up():
	$PlayMode.show()
	$Controls.hide()



func _on_GoToMainMenu_button_up():
	game_manager.player_counts = 0
	game_manager.bot_counts = 1
	game_manager.restart_without_timer()
	$"../GameUI".hide()
	$"../GameOverUI".hide()
	$PlayMode.show()


func _on_BackFromTime_button_up():
	$Time.hide()
	if game_manager.player_counts == 4:
		$PlayMode.show()
	else:
		$"Select Bot".show()


func _on_BackFromBot_button_up():
	$"Select Bot".hide()
	$PlayMode.show()
            extends "res://CharacterController.gd"

onready var game_manager = get_node("/root/World")

var control

func _ready():
	re_assign_control()
	set_fixed_process(true)

func re_assign_control():
	if get_parent().get_name() == "Blue":
		control = game_manager.player_1_controls
	elif get_parent().get_name() == "Red":
		control = game_manager.player_2_controls
	elif get_parent().get_name() == "Green":
		control = game_manager.player_3_controls
	elif get_parent().get_name() == "Purple":
		control = game_manager.player_4_controls

func _fixed_process(delta):
	if !is_controllable:
		return
	
	if Input.is_key_pressed(control["right"]) && not Input.is_key_pressed(control["left"]) && not Input.is_key_pressed(control["up"])  && not Input.is_key_pressed(control["down"]) :
		input.x = 1
	elif not Input.is_key_pressed(control["right"])  && Input.is_key_pressed(control["left"])  && not Input.is_key_pressed(control["up"])  && not Input.is_key_pressed(control["down"]) :
		input.x = -1
	elif not Input.is_key_pressed(control["right"])  && not Input.is_key_pressed(control["left"])  && Input.is_key_pressed(control["up"])  && not Input.is_key_pressed(control["down"]) :
		input.y = -1
	elif not Input.is_key_pressed(control["right"])  && not Input.is_key_pressed(control["left"])  && not Input.is_key_pressed(control["up"])  && Input.is_key_pressed(control["down"]) :
		input.y = 1
	
	try_to_move()               [gd_scene load_steps=4 format=2]

[ext_resource path="res://design.png" type="Texture" id=1]
[ext_resource path="res://Player.gd" type="Script" id=2]
[ext_resource path="res://jump.wav" type="AudioStream" id=3]

[node name="Blue" type="Node2D"]

[node name="Blue" type="Sprite" parent="."]

texture = ExtResource( 1 )
centered = false
vframes = 10
hframes = 10
frame = 10
script = ExtResource( 2 )
_sections_unfolded = [ "Animation", "Offset", "Transform" ]
auto_setup_by_name = true
char_id = 0
move_time = 0.5
jump_height = 15
frame_left = 21
frame_up = 10
frame_right = 11
frame_down = 20
jump_sfx = null
start_position = 0
offset_position = Vector2( 17, 12 )

[node name="Tween" type="Tween" parent="Blue"]

playback_process_mode = 1
playback/active = false
playback/repeat = false
playback/speed = 1.0
_sections_unfolded = [ "playback" ]

[node name="TweenJump" type="Tween" parent="Blue"]

playback_process_mode = 1
playback/active = false
playback/repeat = false
playback/speed = 1.0
_sections_unfolded = [ "playback" ]

[node name="TweenFall" type="Tween" parent="Blue"]

playback_process_mode = 1
playback/active = false
playback/repeat = false
playback/speed = 1.0
_sections_unfolded = [ "playback" ]

[node name="Area2D" type="Area2D" parent="Blue"]

position = Vector2( 16, 22 )
input_pickable = true
gravity_vec = Vector2( 0, 1 )
gravity = 98.0
linear_damp = 0.1
angular_damp = 1.0
audio_bus_override = false
audio_bus_name = "Master"

[node name="CollisionPolygon2D" type="CollisionPolygon2D" parent="Blue/Area2D"]

build_mode = 0
polygon = PoolVector2Array( -16, 7, 5, 16, 17, 10, -4, 0 )

[node name="audio" type="AudioStreamPlayer" parent="Blue"]

stream = ExtResource( 3 )
volume_db = -10.0
autoplay = false
mix_target = 0
bus = "Master"


  extends Sprite

var current_pos_tile = Vector2(0,0)

onready var board_manager = get_node("/root/Global").board_manager
onready var character_manager = get_node("/root/Global").character_manager

var sfx = null

func randomize_position():
	current_pos_tile = Vector2(randi() % board_manager.width, randi() % board_manager.height)
	if(character_manager.is_tile_occupied(current_pos_tile) and !board_manager.is_pu_at(current_pos_tile)):
		randomize_position()
	else:
		position = board_manager.translate_tile_to_position(current_pos_tile)

func do_power_up(id):
	if board_manager.pu_active_array.size() == board_manager.max_pu_at_board:
		board_manager.restart_timer_spawn_pu()
	var i = board_manager.pu_active_array.find_last(self)
	if i != -1:
		board_manager.pu_active_array.remove(i)               extends Sprite

var tile_id = 0 setget set_tile_id, get_tile_id
var tile_pos = Vector2(0,0)
onready var timer = Timer.new()
onready var timer_spr = Sprite.new()
var timer_spr_offset = Vector2(28,11)
var timer_spr_start_frame = 68
var timer_spr_frame_count = 8

onready var game_manager = get_node("/root/World")
onready var board_manager = get_node("/root/Global").board_manager
onready var tween = Tween.new()
var push_down_length = 8
var region_origin
var position_origin
var timer_reconnect_push_down = true

func _ready():
	add_child(timer)
	timer.connect("timeout", self, "claim_score")
	timer.one_shot = true
	timer.wait_time = game_manager.time_to_claim_score
	add_child(timer_spr)
	timer_spr.texture = texture
	timer_spr.hframes = 20
	timer_spr.vframes = 10
	timer_spr.frame = timer_spr_start_frame
	timer_spr.position = timer_spr_offset
	timer_spr.centered = false
	timer_spr.visible = false
	add_child(tween)
	position_origin = position
	set_process(true)
	

func _process(delta):
	# Timer Sprite Calculation
	if timer.get_time_left() != 0 and timer_spr.visible:
		var percentage = (timer.wait_time - timer.get_time_left()) / timer.wait_time
		var frame_delta = floor(percentage * timer_spr_frame_count)
		if timer_spr.frame != timer_spr_start_frame + frame_delta:
			timer_spr.frame = timer_spr_start_frame + frame_delta

func claim_score():
	game_manager.scores[tile_id] += 1
	set_tile_id(0)
	timer_spr.visible = false

func start_counting_claim_tile(id):
	stop_timer_if_needed(id)
	timer_spr.visible = true
	timer.start()

func stop_timer_if_needed(id):
	if timer.get_time_left() != 0.0 && id != tile_id:
		timer.stop()
		timer_spr.visible = false

func force_stop_timer():
	timer.stop()
	timer_spr.visible = false

func push_down_tween():
	tween.remove_all()
	if position != position_origin:
		position = position_origin
	
	tween.interpolate_property(self, "position", position, position + Vector2(0, push_down_length), 0.2, Tween.TRANS_BACK, Tween.EASE_IN)
	if timer_reconnect_push_down:
		tween.connect("tween_completed", self, "auto_push_up_tween")
		timer_reconnect_push_down = false
	tween.start()

func auto_push_up_tween(obj, key):
	tween.interpolate_property(self, "position", position, position + Vector2(0, -push_down_length), 0.3, Tween.TRANS_BACK, Tween.EASE_OUT)
	tween.disconnect("tween_completed", self, "auto_push_up_tween")
	tween.connect("tween_completed", self, "fix_origin_position")
	timer_reconnect_push_down = true
	tween.start()

func fix_origin_position(obj, key):
	position = position_origin
	tween.disconnect("tween_completed", self, "fix_origin_position")

func set_tile_id(id):
	stop_timer_if_needed(id)
	var rect_pos = region_rect.position
	rect_pos.x = board_manager.tileSize.x * id
	if id == 0:
		rect_pos.x = region_origin.position.x
	region_rect.position = rect_pos
	tile_id = id

func get_tile_id():
	return tile_id       @GDEF    '�   GPOS   '�   GSUB��ڲ '�   �LTSHU�6J  X   �OS/2d��C  �   `VDMXs�{�  (  �cmap����  �  <cvt  ��  $�   fpgmY�7  "�  sgasp��  '�   glyf���  $�  �hdmx��>�    �head���  L   6hhea�}  �   $hmtx��w�  (  0locaFn !�  �maxp�   �    name�X� #�  �posts�Gz %l  9prep�2o   $p   N     Bb�_<�      �lq    �@�    �   	             ��    �                �    � R           
   �     ��  �3  3�3  � f 	      �  �   j             @  %�   � �       ��      �      �  �  ��� �� d� d� d� d���,��� �� d�,� ���� d� d�,� d� d� d� d� d� d� d� d��� �� �� d� �� d� d� d� d� d� d� d� d� d� d�,� d� d� d� d� d� d� d� d� d� d� d� d� d� d� d� d� d��� d� �� d�  �,� d� d� d� d� d� �� d� d�,�,� d��� d� d� d� d� d� d� d�,� d� d� d� d� d� d�,���,� d� d� d� ����,� d� �� d� d� d�,�,����� �� d� d� d� d� d� d� d� d� d� d� d� d� d� d� d� d� d�,�,�,�,� d� d� d� d� d� d� d� d� d� d� d� d� d� d� d� d� d� d� d� d� d� d� d� d� d� d� d� ��,� �� �� d� d� d� d� d� d� d� d� d� d� d� d� d� d� d�X�,� �� ��,� d� ��,� d� d� d� d� d� d� �� �� d� d� d� d� d� d�X� d   �LD+DL/++D++/+++//++++/L/++/++//LLL/D++++/DL/+++;//LL+DD+/D/DD///+L++++L/////+L/++++LL+++L////D+LDL/""L      ��  �� 	 �� 
 	��  
��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��   �� ! �� " �� # �� $  �� % !�� & "�� ' #�� ( $�� ) %�� * %�� + &�� , '�� - (�� . )�� / *�� 0 +�� 1 ,�� 2 ,�� 3 -�� 4 .�� 5 /�� 6 0�� 7 1�� 8 2�� 9 3�� : 3�� ; 4�� < 5�� = 6�� > 7�� ? 8�� @ 9�� A :�� B ;�� C ;�� D <�� E =�� F >�� G ?�� H @�� I A�� J B�� K B�� L C�� M D�� N E�� O F�� P G�� Q H�� R I�� S I�� T J�� U K�� V L�� W M�� X N�� Y O�� Z P�� [ P�� \ Q�� ] R�� ^ S�� _ T�� ` U�� a V�� b W�� c X�� d X�� e Y�� f Z�� g [�� h \�� i ]�� j ^�� k _�� l _�� m `�� n a�� o b�� p c�� q d�� r e�� s f�� t f�� u g�� v h�� w i�� x j�� y k�� z l�� { m�� | m�� } n�� ~ o��  p�� � q�� � r�� � s�� � t�� � u�� � u�� � v�� � w�� � x�� � y�� � z�� � {�� � |�� � |�� � }�� � ~�� � �� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ��� � ���      �	   
         		   

 																																																																																																																																																																																									   						
				
				
							
								

					

				

		
			


	
		
											
				

		
			


												
	

	

								

			
									
							



	
								
									
						



							
	
		
		
	
	
								   



















	



































	








	







	



	






	

	
	














































































		
























   









                  !   %   *   .   2   6!!                                            !         !!                   !         !                                               !            !      !         !       !    !                   :$# """""""""""""""""""""""""""""""""""""""""""""""""""""""""!"""""""""!""""""""#"""""""#""""!""$"$""""""""#""##"""""""""""""""""""""""$""""""#""""""""""""#""""""#""""""""""#"""""#"#""""""""""""""""""""""""  C)( '''(''(''''(''''''''(''''''''''''''''''''''''''''''''''''('''''''''(''''''''(''''''''''''(''('('''''''')''((''''''''''''''''''''''')''''''(''''''''''''(''''''(''''('''''('''''('('''('''''''''''(''''''''  K-- ,,,,,,,,,,,+,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,-,,,,,,,,,-+-,,,,,,,,,,,,,,,,,,,-,,,,,,,,,-+,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,+,,,,,,-,,,,,,,,,,,,-,,,,,,-,,,,+,,,,,-,,,,,,,-,,,,,-,,,,,,,,,+,,,,,,,,          &           �     �                                                                     	 
                        ! " # $ % & ' ( ) * + , - . / 0 1 2 3 4 5 6 7 8 9 : ; < = > ? @ A B C D E F G H I J K L M N O P Q R S T U V W X Y Z [ \ ] ^ _ ` a   z { }  � � � � � � � � � � � � � � � � � � � � � � � � � � � �   k b c   �   � j g � n f   | �         d             h p   � � u �           i q �  v y �         � � � �     �   � � � �               x � w � ~ � � � � � �   � � � �    <        ~ � � � � � � � � �~   " & : D � � �!"!�"%�%�%�%���        � � � � � � � � �~   " & 9 D � � �!"!�"%�%�%�%��� ����  ����  �����������������������x���ߟ  ާ�����        6     8                                               � b c  j � � � � �    <        ~ � � � � � � � � �~   " & : D � � �!"!�"%�%�%�%���        � � � � � � � � �~   " & 9 D � � �!"!�"%�%�%�%��� ����  ����  �����������������������x���ߟ  ާ�����        6     8                                               � b c  j � � � � ˸  ,K� 	PX��Y���� D� 	 _^-� ,  EiD�`-� ,� *!-� , F�%FRX#Y � �Id� F had�%F hadRX#e�Y/ � SXi � TX!�@Yi � TX!�@eYY:-� , F�%FRX#�Y F jad�%F jadRX#�Y/�-� ,K �&PXQX��D�@DY!! E��PX��D!YY-� ,  EiD�`  E}iD�`-� ,� *-� ,K �&SX�@� Y�� �&SX#!�����#Y �&SX#!� ����#Y �&SX#!� ���#Y �&SX#!�@���#Y � &SX�%E��PX#!��#!�%E#!#!Y!YD-� 	,KSXED!!Y- �  + �   +�   +�  9 / $     + �  9 / $     + �   +�   E}iD   * � �      �         �      �� /� /� � 	и 	/� �  ��   	 9�  	 9�  	 9� 	�  ��  	 9�  	 9�  	 9� � � �  EX� /�  >Y� 
   +� �   �017!			!!!�{�C��D�������P�y�d���w�D���������8   � dX�   8�    +� � и � � �  EX� /�  >Y�     +01#57#3X����,����     �L��   �� /� /�  �� � и /� 	 �� � � �  EX� /�  >Y�  EX� /�  >Y� �   �� �  ��  � и и 	и 
и � и и 
� и �01#5#!##5#�dd,�ddd�dd,��,��dd,  d �L�   �    +� 
   +� �   �� и � и �  �� 
� и � и 
� и � и � и  � и � и � � � /�  EX� /�  >Y�  EX� 
/� 
 >Y�    +�    +�    +�     +� 
�  �� и и � й  �01#533333#3##5##5#533,������������������,�,���������������,     d dL� 3 ; C �    +�    +�   
 +� �  и �  �� и � и � и � и � и � !и � $ �� � %и � 'и � +и � /и � 1и � 4и 
� 5и � 7и 
� 9и � <и $� =и � ?и $� Aи � E� � /�  EX� 2/� 2 >Y�  EX� /�  >Y�  EX� ./� . >Y� 7   +� 8   +�    +�    +� �  ��  �� �  �� � 
и � и �  �� � и � и � и 8�  и 7� "и � $и � &и � *и � ,и � -и � 0и � 4и � :и � <и � =и � >и � @и Aи � B�01333#5#5#333####5#5#5#5333#5#5#35353533535#5###33��dd�dd�dddd���dd�dd�dddd��dddd�ddddxdd�dd��dd��dddddd�dd,dd,ddd��ddd�ddd  d dL�    ? C� ,  - +�    +�    +� ,�  и � и � 
и � к   9� /�  �� �  �� � и � и � и � и � и � и � !и � #и � %и � &к / - ,9� //� ( �� � )и ,� 1и � 3и (� 5и /� 7и -� 9и /� ;и (� =и (� @и � Aи � Bи � E� �  EX� /�  >Y�  EX� /�  >Y�  EX� </� < >Y�   +�    +�   ! +� �  и �  �� и � 	и � ܸ � и � и и � $и � &и � (и � ,и � .и � 0и � 2и !� 6и � 8и 9и � ? �� :и !� @и 9� Bи C�0135#!5#35!3%35#353533#########35353535!5#35!335#,dd���dd,d��dd�ddd�dddddddd�dddd��dd,ddddL���dd�dd�pd��dd,�pddddddd���ddddd�dd�d   d dL�   9�   % +� 5    +� $ % 9� $/�  �� и � ܹ  ��  � и � 	и $� ܸ  � и � 7и и 5� и 5�  ��  �  �� � и 5� и � и � и 7�  и � !и � "и $� 'и � )и � *и $� +и � -и � .и � /и  � 1и � 2и � 3и 7� 4и � 9� �  EX�  /�   >Y�  EX� ,/� , >Y�  EX� 4/� 4 >Y�    +�    +� ,�  �� и и и � и � и � и � и � и �  и � $и � *и +и  � -и  � 1 ��  � 5и +� 6и 7�01!3353#5#5#3!3353#3#5#!5#5#3535#3535!33##���ddddd�d,dd�dd�d�ddddddd,dddd��pdd��dd��d�dd���dddd�d��dddd�p� �L��  0�    + � /�  EX�  /�   >Y�  �� и �01##5#�ddd���dd,  , d �  ��   	 +� �   ��  	 9� /�  ��  �� � и � и � и � и � и � и � и � и  � и � и � и � � � /� /�  EX� /�  >Y�  EX� /�  >Y01%3#5#5#5#3535353###33�d�dddddd�ddddd�dddd�dddddd�d    � d��  ��    +�   9� /� � и �  �� и � 
и � и � и � и � и � и � и � и �  �� и �  �� � � � /� /�  EX� /�  >Y�  EX� /�  >Y01%#535353#5#5#53333##X�dddddd�ddddd�dddd�dddddd�dd     ���@ +��    +�    +�    +� � и � + �� и � и � 
и � и +� и �  �� и � и � и �  и � !и � "и � $и � &и � (и � -� � '/� /�  EX� 	/� 	 >Y�  EX� /�  >Y�  EX� /�  >Y�  EX� /�  >Y�  EX� /�  >Y�  EX� /�  >Y�    +�     +�    +� 	�  �� � 
 �� и и � и � и � и � и � и  и � !и  � #и  � %и &и )и *�01#53535#5#5333335353##33#5#5###,dddddddd�dddddddddd�d�d�ddd�dd,��dd�ddd�dd��,d    d,L  L�     +� � и  � � � /�  EX� /�  >Y�    +� �  и � 	�013!!#!5����p��p���p��p�� , d��  �     +�  � � � /� /0153###535��dd�d,��dddd    ����   �     +01!5������  � dX,  �    + �     +01#5X�,��  d dL� # L� $/�  /�  ��  � и $� и /�  �� и � %� � /�  EX�  /�   >Y013#########353535353535353��dddddddd�dddddddd��pddddddd���ddddddd  d dL�   3 ��   0 +� &   +� 0�  ��  и &� 	 �� � и � и � и 	� и � и �  и 	� "и 	� *и � ,и &� 5� �  EX� !/� ! >Y�   + +� !� 	 �� !�  �� 	� и и � и +�  �� � %и &и � 'и � /и &� 1и 2�01535353535#5!#3!53####5!33##!5#5#35�ddd�d�pdd�ddddd�Xdddd��ddd�ddddddd��ddd�dddd�ddd�dddd�d  , d��  [�     +�  �  �� � и � � �  EX� /�  >Y�  EX� /�  >Y�    +� � �013!53#535353������dd�,�� �dd    d dL� %�     +�   	 +� � и  � и �  �� 	� и � $ �� и  � и � и � и  � и � и � !и � '� �  EX� /�  >Y�  EX� /�  >Y�    +�    +� �  �� �  �� � и и �  �� � и и �  �� и � и и � и � "�01!!3535!535#5!##53535!33##!#, �dd�dd�pd�ddXdddd�d,�Xddd�ddd�dddd�pddd    d dL� /��    +� &  +� �  ��   &9� /� ( �� 	 �� � и � и 	� и � и � и � и � и � и 	� и &� !и (� #и &� )и 	� +и � -и (� 1� �  EX� /�  >Y�  EX� /�  >Y�   , +�   . +�    +� �  и �  �� ,� 	 �� и �  �� �  �� � и и �  �� � и и �  ��  и � "и #и � $и � &и � (и � )и .� *�01#533!535#5!5!535#5!##53535!33#3##!5#�d�d�dd��,dd�pd�ddXdddddd��d,�ddd�d�d�ddd�dddd�p��pddd     d dL�   e�    +� � и � и � � � /�  EX� /�  >Y�  EX� /�  >Y�    +� � 	и � �01533##!3535353535####�������ddddddddddxd����p��ddddd�D�dddd  d dL�  л     +� 
   +� 
� и 
�  �� и � и  � и � и � и � и 
� !� �  EX�  /�   >Y�    +�    +�    +�  �  �� �  �� и 
и � и � и � и � и � �01!!!33##!5#5#533!53#5!d���Xdddd��dd�d�dd�D���dd��dddd�ddd�d  d dL� ! +/�    +�    +� �   �� � 
и  � и  � и � " �� и � и  � и � и � #и  � %и � 'и � )и � -� �  EX� /�  >Y�  EX� /�  >Y� %   +�    +� �   �� и �  �� �  ��  �� 	и � и и �  �� � и и � и и  � "и � (и %� *�01%!5#5#3535!33#5#5!#!33#%!535#5!3���ddddXdd�d�pdXddd���dd�d�ddd�dddd�ddd��dd�pddd�d��     d dL�  R� /�  /�  ��  � и � и /�  �� и � � � /�  EX� /�  >Y�   �01!5!#####3535353����dddd�dddd��ddd���ddd  d dL�  ' 3�� 
   +� %   +� �   �� %�  �� � и  � и � и 
� и � и 
� и � и %�  и � (и  � )и 
� +и  � -и � /и � 1и %� 5� �  EX� /�  >Y�  EX� /�  >Y�    +�     +� 1   +� �  �� �  �� !и "и .и /й  �� � и � 
и � и  � и � и � и /� и �  �� и  и � #и � $и � %и  � &и  � (и )и � * �� 1� ,и *� 2и 3�01!535#5!#3!5#5#35#3535!33#3#!#3!535#��dd�pdd���ddddddXddddd��pdd�dd,d�dd��ddd���dddd�p��pdLd�dd�  d dL� ! +6�    +�    +� �  �� � 	 �� � и � и � и 	� и 	� и � и 	� "и � $и � &и � (и � *и � -� �  EX� /�  >Y� 	   +�     +� "  
 +� �  ��  и �  �� 	� и � и "� и �  �� и и � и � и  � и � # �� � %и &и #� 'и (�01#533!53!5#5#3535!33##!5##5!#3�d�d�d��ddddXdddd��d�d�pdd,�ddd,dd�dddd�ddd�,dd�c �,X   B�    +� � и � � �  EX� /�  >Y�     +� �  �01#5#5X������ ��   � dX   @�    +� � и � и � 
� � /�  EX�  /�   >Y�  �01#553###535X��dd�d�����dddd  � d�@ 3B� '  
 +�  
 '9� /� + ��  к  
 '9� /� ) �� и '� и � и � и '� и � и )� и � и +� и � и '� - �� и +� 0 �� и )� / �� и -� и +� и � и )�  и � !и '� "и � #и � $и � (и � *и -� 2� � /� 1/�  EX� /�  >Y�  EX� /�  >Y�  EX� /�  >Y01%5#5#5#5#5#3535353535353######333333#5�ddddddddddd�dddddddddddd��ddddd,dddddd�ddddddddddd�d   d�LL    �    +�     +01!5!5L���L���p��   � d�@ 3Z�    +� -   +�   9� /� � и � 1 �� 
и � / �� и -� и /� и � и 1� и 
� и � и � 3 �� и � и � и � и � и � и � и � и 3� и 1�  и 
� !и /� "и � #и -� $и 1� + �� &и /� ) �� � .и 
� 0и � 2� � /� /�  EX� /�  >Y�  EX� /�  >Y�  EX� !/� ! >Y01%#5353535353535#5#5#5#5#5#53333333#####��dddddddddddd�ddddddddddd�d�ddddddddddd�dddddd��ddddd   d dL�  ' ݻ    +�    +� � и �  �� � 
и � и � и �  и � "и � $и � )� �  EX� /�  >Y�  EX� /�  >Y�     +� � 	 �� �  �� 	� и и �  �� � и и �  �� и � и �01#553535#5!##53535!33#####535���ddd�pd�ddXdddddd�d,���dd�ddd�dddd�pdddd�d     d �Lx  / =h� !  " +�   6 +� -   +� !� 8 ��  �� 9 ��  и � и =и и � / �� и � 
и =� и 8� и 6� и "�  �� и !� и 6� и 8� и � и � и =� и /� и � и 6� и � и !� $и � %и 6� &и � 'и � (и /� *и � 0и 8� 3и � 4и � 7и -� ?� �  EX� /�  >Y�  EX� %/� % >Y�  EX� )/� ) >Y�    +�    +� � й  �� � 4и и )� 	 �� и и 8и 
и )� ( ��  �� )� и � и � и � й  �� и � и �  и � !и � #и )� &и � +и � -и 4� .и � 0и 4� 1и � 2и � 5и � 6и 8� 9и � :и 9� <и =�01#35353#5#5!##33!53#!5#5#3535!33#'#!5#353353Xdd�dddd�pdddd��d��ddddXddd�d��dd�dd��pddd�dddd��ddddddd dddd��dddd�ddd    d dL�  # � $/� /� $� и /�  ��  и � и � и �  �� � !и � %� � /�  /�  EX� /�  >Y�  EX� /�  >Y�  EX� /�  >Y�    +�   " +� �  �� �  �� � и � 
и и � и � и и � и � и и � �01!#5#5####3535353533333#!,Xdd�dd�dddd�dddd����,dddd�|�dddddddd��  d dL�    ��    +�    +� �  и �  �� � и � 
и � и � и � и � и � и � !� �  EX� 	/� 	 >Y�    +�    +� �  и 	�  �� и и � и � �01!535#5!!33#3##%!535#5!,�dd�� dddddd���dd��d�d�Pxdd�p��pdd�d�d     d dL� #�    +�    +� �   �� �  �� 	и � и � и � и � и � и � и  � и � !и � %� �  EX� /�  >Y�  EX� /�  >Y�   
 +�   	 +� 
�  �� и 	� и � и �  �� �  ��  �� и � и и �  �� � и и �  и !и � "�01!5353##!5#5#3535!33#5#5!#3��d�dd��ddddXdd�d�pdd,dd�dddd�dddd�ddd��    d dL�   v�    +�    +� �  �� � и � 
и � и � � �  EX� 	/� 	 >Y�    +� 	�   �� и и � �01!53#5!33##,�dd�D dddd�d d�Pxdd�dd    d dL�  D�   
 +� � � �  EX�  /�   >Y�   	 +�    +�  �  �01!!!!!L��X�� ����p��p�x     d dL� 	 >�    +� � � � /�  EX�  /�   >Y�    +�  �  �01!!!#L��X������p���x     d dL� %� 
   +�   +� � и �  �� �  �� �  �� и � и � и � и 
� и 
� !и � #и � '� �  EX� "/� " >Y�  EX� /�  >Y�    +�    +� "�   �� �  �� "�  ��  � и и � и 	и � 
и �  �� и � и � и и � % ��  �013#5#5!#3!53!5!##!5#5#3535!3�d�d�pdd�d���dd��ddddXd�ddd��dd,���dddd�ddd    d dL�  o� /� /� � и /�  �� и �  �� � 
и � � � /� 	/�  EX� /�  >Y�  EX� /�  >Y�     +01#3!3#,��X�����x��X��X  , d��  B� 	   + �  EX� /�  >Y�     +� �  �� и и � 	�01%53#5!#3,��X��d������     d dL�  ��   	 +� 	� � �  EX� /�  >Y� 	   +�    +� �  ��  и �  �� 	� и � и � 
 �� и и � и � и � �01#533353#5!###!5#�d�d�d�X�dd�pd,�ddd����ddd  d dL� 3q�    +�    +� � к   9� /� 
  9� 
/� � и �  �� и 
�  �� и �  �� �  �� �  �� � и � и 
� и � и � и �  и � !и � "и � #и � $и � &и � 'и � (и � )и � *и � +и � ,и � -и 
� .и � 0и � 2� � /� '/�  EX� /�  >Y�  EX� /�  >Y�  EX� /�  >Y�  EX� /�  >Y01#33535353535353#####33333#5#5#5#5#5#5,��dddddd�dddddddddd�ddddd���x��dddddd�dddd�dddd�dddddd     d dL�  (�     + �  EX� /�  >Y�     +0173!d� dx�P�    d dL�  �� /� и /�   �� и � �A @  P  ]A �  ]� 
 �� � �A �  ]A @  P  ]�  �� � и � и � � �  /� /�  EX� /�  >Y�  EX� /�  >Y�  EX� /�  >Y�  EX� /�  >Y�    +� 	   +� � и �  �� � и � и �01%#3333535353####5#5#,��dd�dd��dd�dddx�dddd����d��d    d dL�  a�  /� /�  � и /�  �� и � и �  �� !� � /� /�  EX� /�  >Y�  EX� /�  >Y01#33333333##5#5#5#5#5,��dddddd��ddddd���x��ddddd ��,ddddd  d dL�   Ի    +�     +� �  �� и  � и � 	 �� � и 	� и 	� и � и � !� �  EX� /�  >Y� 	   +� �   �� �  �� 	� и �  �� � 
и и  � и и � и � и � и �01!#3!53#%5!33##!5#5#35 �pdd�dd�Xdddd��dddd��dd �ddd�dddd�d     d dL�   �� 	  
 +�    +� 	�  и �  �� � и � и � и � � � 	/�  EX� /�  >Y�    +� �   �� и и � �01!535#5#!33##,�dd�� dddd�pd�d����xdd�pdd    d dL�  +
�    +�     +� �  �� � 
 �� и 
�  �� � и � и � и � и  � #и � %и 
� 'и � (и � )и  � -� �  EX� /�  >Y� #  $ +� 	   +� �   �� #� и � и  � и и �  �� #� и � и и и и �  и $� (�013!5#5#5333#5!#3535!33#3#5#!5#,d,dd�ddd�p�dddXdddd���pd���ddd�dd�dd�|�dddd�|d�ddd   d dL�  + �� 
   +�    +� 
�  и �  �� � и � и � и � и � и � и � !и � #и � -� � 
/�  /�  EX� /�  >Y�   	 +� �   �� и и � и 	� �01!535#5##!33###3333#5#5#5#5#5#,�dd�pd� dddd�dddd�ddddd�pd�d����xdd�pdddddd�ddddd    d dL� 3u�    +�    +� �  �� �   �� и � 	и  � и � и � и � и � и � и � !и � #и � %и � 'и � +и � /и � 1и � 5� �  EX� 0/� 0 >Y�  EX� /�  >Y�    +�    +�    +� 0�   �� �  �� 0�  ��  � и и � и 	и � и � и � # �� и �  и � !и � &и � *и � ,и -и � 3 �� .�013#5#5!#3!33##!5#5#533!535#5!5#5#3535!3�d�d�pdd�dddd��dd�d�dd�ddddXd�ddd�ddd�pdddd�ddd�ddd�ddd    d dL�  0�     + � /�  EX� /�  >Y�   �� и �01!5!!#��p��p����P     d dL�  �� /� 	/� � и /�  �� 	�  �� 	� и � и � � �  EX� /�  >Y�  EX� 
/� 
 >Y� 	   +� �  ��  и 	� и � �01#33!533##!5#�d�d�d�dd��d,���ddL�Pddd   d dL�  ��  /� /�  � и /�  �� �  �� � и � и � !� �  EX� /�  >Y�  EX� /�  >Y� 	   +�    +�    +� �  и � и � и � и 	� и � и � и 	� �01#333353533#####5#5#5#�d�dd�dd�dddd�ddd���|dddd��ddddddd   d dL�  �� /�  и  /�  ��  � �A @  P  ]A �  ]�  �� � �A �  ]A @  P  ]� 
 �� � и � и � и � и 
� � �  EX�  /�   >Y�  EX� /�  >Y�    +� � и � �0133333###5##5#5#d�����dd���dd�����L�Pdddddd    d dL� 3��    +� #   +�   9� /� � и � 
и � и � и � и � и � и � 3 �� и � 1 �� к   #9� /� #� и #�  ��  �� �  �� �  и � $и � &и � (и � *и #� ,и � -и � .и � 2и � 5� �  EX� /�  >Y�  EX� /�  >Y�   +�     +�   	 +� �  �� � ܸ �  �� �  �� и и � и и � и и � и � и и � и  и 	� !и � #и � %и � &и � 'и � )и  � +и � -и � /и � 0и � 1�01#353535#5#5#333353533###333##5#5##,�dddddd�dd�dd�dddddd�dd�d����dd�dd���dddd,�pdd�dd�p,dddd    d dL�  �  /� 	и 	/� �A �  ]A @  P  ]�   �� 	�  �� и � и  � и � �A �  ]A @  P  ]�  �� � и � !� �  /�  EX� 
/� 
 >Y�  EX� /�  >Y�    +�    +� � и � и � и � и � и � �01%##5#5#5#333353533####��dddd�dd�dd�ddddd�dddX�dddd���ddd  d dL� ' ( �  EX� /�  >Y�    +� �  �015!5!########!!35353535353535����dddddddd �ddddddd�d��pdddddddd��ddddddd  � d��  !�    + �    +�     +01!!!��p������P�@   d dL� # T� $/� /� $� !и !/�   �� �  �� � и  � и � %� � /�  EX� "/� " >Y0133333333##5#5#5#5#5#5#5#3,dddddddd�dddddddd��ddddddd�p,ddddddd�  � d �  !�     + �    +�     +01!5!!5!X�pX��������   d�L�  � �  EX� /�  >Y�  EX� /�  >Y�  EX�  /�   >Y� � 	 ��  �� й  ��  �  �� 	�  �� � и � и и � и � и 	� и и � и � и � и и � �013333!5#5##!535353535�dddd��d�d��dddd�dddddddddddddd      � �   �  EX�  /�   >Y�  �0115!��� ,� �  & � /�  EX�  /�   >Y�  �� и �0133#5#5#5Xdd��d�dddddd   d dL  ':� 
   +� �   �� 
� ܸ и '� и � # �� $ �� и '� и  � и 
� и 	� и 
� и 	� и � и '� и $� и � и '� и 
� и 	� и $� и � &� �  EX� /�  >Y�     +� 
   +�    +�    +� 
� и � и  � и � и � и �  �� !и "и � #и � %�01!535#5!#35#5#3535!35#5!5!33#5#��dd�pddddddd�dd�Xdd�d,d�dd���dd�ddd�d�dd�dd    d dL�  /X�    +�   +� �  ܺ   9� /�   9� /�  �� и и � 	и  � и � и � и � и � и � и � и �  и � ' �� "и � % �� � (и � *и � +и � ,и � .и '� 1� �  EX� /�  >Y�   , +�   ) +�    +�     +� � и � и � и � и ,� и  � и � #и � %и )� -�0135353#5#5###33#33535!333###!5#5Xdddddddddd����dd,dddddd��d,dd,dddd��dd�x�ddddd�ddddd  d dL� #� 	   +�    +� �  �� � и � и 	� и � и � и � ! �� и 	� и � "и � %� �     +�    +�    +�    +� �  �� �  �� � 	и � и � и � и � и �  �� �  �� � и � и � и  � и � !и � "�0153##!5#5#3535!33#5#5!#3!5��dd��ddddXdd�d�pdd��d�dddd�dddd�ddd�dd    d dL�  /P�    +� 	  
 +�  
 	9� /� ܹ  �� и � ܺ   9� /� и � и � и 
� и 	� и � и 
� и �  �� 	� !и � #и 	� %и � 'и � )и 
� +и � -и � .и � 1� �  EX� /�  >Y� !  	 +� #   +�   + +�   $ +� 	� и � и !� и +� и � и !� и +� &и $� ,и #� .�013#5##!5#5#5#353535!3335353#5#5###3���dd��dddddd,d�pdddddddddd�����ddddd�ddddd��ddd,dddd��     d dL�  % ߻    +�    +� �  и � # �� и � и � и �  и � $и � '� � 
   +�    +�    +�     +�   +� �  ��  � и � и 
� и 	� и � и � и � и � !и 
� #и 	� $�01!5#5!##!5#5#3535!33#!3!5,Xd�p�dd��ddddXddd�Dd��dddd�ddddd�dddd��d�dd     � d��  j�     +� � и � и � ܸ 	и  � � �  /�  EX� /�  >Y�    +� � 
 �� � и � �01%#!5!535!!!!����,d���,��d���d�d�     d dL  +<� 	   +� %   +� %�  �� 	� и � и � 
и 	�  �� 	� и � и � и � и � и � и � !и � )и %� -� �  EX�  /�   >Y�   * +�    +� 
   +� "  +� �   ��  �  ��  �  �� � и и  � и � и � и 
� и � и и "� и � $и %и � &и � (�015#5!#3!5#53!53#!5#5#3535!33##!�d�pdd��d��dd�ddddXdddd���dddddd�D�dd,ddd,dddd��dd   d dL�  �� /� /� � и /�  �� и �  �� � и � � � /� /�  EX� /�  >Y� 
   +�    +� � и � и � и � �01#33535!333##5#5###,��dd,ddd�ddddd���x�ddddd���ddddd  , d�x   O�    +� �  и �  �� � и � и � � � /�     +�    +01#53#5#5##5!3��,d�dd��dx�����dd���� , d�@   K�    +� � и � и � � �    +�     +�    +� � 
�01#5##!5!53#5!���dd�p,d��@����dd�dX�  d dL� /�    +�   
 +� � к  
 9� /�  
 9� /� � и �  �� �  �� �  �� � и � и � и � и � и �  и � "и � #и � $и � %и � &и � (и 
� *и � 1� � /� #/�  EX� /�  >Y�     +� � и  � !и  � '�01#33535353535353####3333#5#5#5#5##,��dddddd�dddddddd�ddddd,�x�|dddddd�ddddddd�dddddd  � d��  "�    + � /�  EX�  /�   >Y01#�����x     d dL�  �� /� и /�  �� и � �A �  ]A @  P  ]� 	�A @ 	 P 	 ]A � 	 ]�  �� 	� и �  �� � � � /� /� /�    +�     +� � и � 	и  � и � и � �01#335!33##5###,��d�dd�dd�d���Ldddd�| d�|�d     d dL�  w� /� 	/� � и /�  �� и 	�  �� 	� и � � � /� /�    +�     +� � и � 	и  � и � �01#335!33##5!,��d�dd�d�p���Ldddd�| dd    d dL�   �� 
   +�    +� �   �� �  �� � и  � и 
� и 
� и � и � и � !� � 
   +�    +� �   �� 
� и �  �� и  � и � и � и  � �01!53#5!#35#5#3535!33##��dd�pdddddddXdddd,d�dd���dd�dddd�Ddd   d dL   �    +�    +�    9� /� �  �� и � 	и � и � и  � и �  ��  � и � и � !� � /�  EX� /�  >Y�  EX� /�  >Y�    +� �   �� �  ��  � и и � и � 	 �� � и и 	� �01#5!#3!53#335!33##!5�d��dd,d����d�dddd��dd��dd��p�dddd�ddd    d dL  ! ��    +�    +� �  �� � и �   �� и � и � 
и �  �� и  � и � и � и � #� � /�  EX� /�  >Y�  EX� /�  >Y�    +�    +� �   �� � и  � и и � 	 �� 
и � и � и � и 
� и �013!53#5!%53##5#!5#5#3535!,d,dd�����dd�pdddd����dd,dd�d�P,dddd�ddd     d dL�  y�    +� � � � /�    +� 
   +�    +� � и � 	и � и �  �� � и � и � и � �01#33535!33#5#5###,��dd�dd�d�dd���L�dddd�ddddd     d dL� /#� 0/� /� 0� и /�  �� и � и � ( �� и � и � и (� 1� �   , +� &  * +�    +�    +� !  
 +� �  и &� й  �� &� и � 	и �  �� �  �� � и � и � и � и !� и � и �  и � "и � #и 
� $и � (и � )и *� .�01#533!5#5#5#5#53535!33#5#5!!333##!5#�d�d����dddXdd�d�p,�dddd��d,�dd�ddd�dddd�dd�ddd�ddd , d��  T�    +� � и � и � � � /�  EX� /�  >Y�    +� � и � �013#5#5##5333#3 d�dd�����d,�dd��,�����     d dL�  o� /� /� �  и  /�  �� � 
 �� � и � и 
� � �  /� /�    +� � и �  �� 
и � �0133!533##!5#5#d�d�d�dd��dd���dd �|dddd  d dL�  ��  /� /�  �  и  /�  �� �  �� � и � и � !� �  /� /�    +� 	   +�    +� � и 	� и 	� и � и � и � и � и 	� �01333353533#####5#5#5#5#d�dd�dd�dddd�dddd���ddddX�Ddddddddd  d dL�  Ÿ /�  и  /�  ��  � �A @  P  ]A �  ]�  �� � �A �  ]A @  P  ]�  �� � и � и � и � и � � �  /� /�    +� � и � 	 �� и 	� и � и 	� �0133333533###5##5#5#d�dd�dd�dd���dd���d��d �|dddddd    d dL� ;Y�    +� +   +�   9� /� � и � 9 �� 
и � и � ; �� и � и � и � и � и � и ;� и 9� к   +9� /� +� и +� ! ��  �� � # �� � $и +� &и � 'и � (и � ,и #� .и !� 0и  � 1и � 2и +� 4и � 5и � 6и � :и #� =� �    +�     +�    +� 	  : +�   +�    +�    +� �  �� �  �� � и � и � и � и � и � и � и �  и � !и � "и � #и � $и � %и � 'и 	� )и � +и � -и � .и � /и :� 0и � 1и  � 3и � 5и :� 6и � 7и � 8и � 9�01%#535353535#5#5#5#53333535353####3333#5#5#5##,�dddddddd�dd�dd�dddddddd�dd�d�d�ddddddd�dddddd�ddddddd�ddddd     d dL ! ��    +�    +� �  и �  �� � и � и � и � и �  и � #� �  EX� /�  >Y�  EX� /�  >Y�     +�   	 +� 	�  �� и � и � и � �01%5!53##!5#5#33353535353##,�ddd�pdd�d�ddd�ddd�d,ddddX�ddd���dd   d dL� !  �    +�    +� � �01!!535353535353535!5!######�X�ddddddd�D�dddddd,��ddddddd���ddddd    , d��  �� /� и /� ܸ  ܹ  �� �  �� � 	 �� � и � и � � �  EX�  /�   >Y� 
   +�    +�    +� � и � �015!##33!5##53X,�dd���d�������p��p������    � d��  �    + � /�  /01#�����@ , d��  �� /� и /� 
ܹ  ��  и 
� ܹ  �� �  �� 
� и � и � и � � �  EX�  /�   >Y� 
   +�    +�    +� � и � �013##!335##!���d���dd�,�����,���,�     dXL�  � �    +�    +� �  и �  �� � и � 	и � и � и � и � и � и � и � и � и � �015!335353##!5#5###535,,d�dddd��d�ddd�ddddd�dddddd�d  d dL� ' /��    +� %    +�    +� � 	и  � и %� и �  �� и %� и � и � и � и � #и  � (и � . �� )и � +и � 1� � &/�  EX� /�  >Y�  EX� 
/� 
 >Y�  EX� /�  >Y� -    +�   # +�    +� #� и  � / �� и �  �� и 
�  �� и и и � и �  �� � и и /� и -� и /�  и � !и  � $и � (и )и � *и +и � .�01#5#5#3535353333#5#5#35353######33��dddd���dd�dddd�dd��dddd,ddXdd��dd�dd��dd�dd��d�pd     d dL� # Ļ "   +� � и "� и "� � �  EX� /�  >Y�  EX� /�  >Y�  EX� /�  >Y�    +�    +�    +� � и �  ��  �� и � и �  �� � и � и � и �  �01!!5353#533535!33#5#5##!!#���dd��dd�dd�d�d��pd,��d���dddd�ddd����    � d�� '��   	 +�  	 9� /�  ��  �� и  и � и 	� и � и � и � 
и � и 	� и � и � и �  �� и �  �� �  �� � и �  и � !и � "и � $и � %и � &� � /�  EX� /�  >Y�  EX� /�  >Y� %    +� 
   +�  � и %� и �  �� и й  �� � ܸ � и � и и � и и и и � и и � и 
� !и � #�01#5!5!5!5!5#5#5#333533###!!!����,��,ddd�d�d�ddd,��,,��d�dd��,����,����dd�d  � d��   %�    +� � и � � �  /� /01##������D��|�D�   ,��   [� /� /� � и /�  �� �  � �  EX�  /�   >Y�  EX� /�  >Y�  �  �� и �01#5!#5��X������   d,Lx  ' 7p�    +� %   +� � 5 ��  и 5� 2 �� ) �� и )� ' �� и � и )� 	и � 
и 5� и � и �  �� и � и � и � и � и � и � и �  и '� "и � (и 5� / �� *и 2� ,и 2� 6и -и )� 0и � 1и 6� 3и � 4и %� 9� �  EX� 
/� 
 >Y�  EX� /�  >Y�  EX� !/� ! >Y�    +� �  ��  й 4 �� и � 0 �� и !�  �� !�   ��  �� #и 	и !� и � и #� и � и и 4� и 0� и � и � и � и  � и � и � и � и #� и !� и � %и � &и  � 'и � (и � )и *и 4� /и � 1и � 2и 0� 3и *� 5и 6и #� 7�01!5353#5#5!##33!5#5#3535!33###33!5#35��dddd�pdddd���ddddXddd��dd���dd�dd�dddd�ddddd�dddd�Dd dd��ddd�d  ����   ! θ "/� /�  ��  и "� и /� и � и �  �� и � и � и �  � �  EX� /�  >Y�     +�    +�    +� � и �  �� и и � и � и � и � и й  �� � !�01!5%!#35!3#5#!5#35!5!#5��D���ddd�ddd�pdd����X���,dddXdd�Dddd,d�dd  d,L�  ?ͻ     +� 3    +�  � к    9� /� � и �  �� 	и �  �� �  �� 
� и � и � и � и � и 
� и � и � и � и 
� и � и � и � и � !и � "и  � #к %   39� %/� 3� 'и %� . �� )и .� + �� 3� , �� *� -и 3� /и '� 0и %� 1и .� 5и *� 6и ,� 7и +� 8и .� 9и *� :и 3� ;и '� <и %� =и .� A� �    +�    +� 
   +�    +� � й  ��  и � й  �� и  �  �� � и � и  � и � и � и �  и  � !и � "и � #и � $и � &и � 'и � (и 
� *и � ,и � -и � .и � 0и � 1и � 2и  � 3и � 4и � 5и � 6и � 7и � 8и � :и � <и � =и � >и � ?�01#5353535353###333#5#5#5#%#5353535353###333#5#5#5#�dddddddddddddddd�dddddddddddddddd�ddddd�ddddd�ddddddddd�ddddd�ddd     d�L� 	   % 9;� +  , +�     +� 7   +� +� 	 ��  �� и  � и 	�  �� и  � 
и � и � и  � и � и � и 	� и � и � и �  �� � и 	� и � и ,� $ �� и +� !и +� .и "и � %и � &и $� (и $� 0и � 2и � 4и � 8и 7� ;� �  EX� 1/� 1 >Y�  EX� 	/� 	 >Y�   ' +�    +� 1�   �� 	�  �� 
и и и � и � и � и � и '� & �� и &� )и и )� # �� и � и и  � и и 1�  �� � и и �  и !и � $и � +и � -и .и � /и 0и 3и 4и .� 5и 6и � 7и )� 9�01#3##3#3#!5353#5#5!##33!5#5#3535!33#����d,dddd���dddd�pdddd���ddddXdddd�d�Xd�d�ddd�dddd�pdddddXdddd��d   d���  �    +�    +� �  и �  ��  �� � 
и �  �� и � и  � и � и � � �  EX� /�  >Y�  EX� /�  >Y�  EX� /�  >Y�  EX� /�  >Y�    +� �  �� �  �� �  �� � и и � и �  �� � и � и и � и и � �015!33##!5#5#35#33535#5,�dddd�pddd�dd�ddxddd�pdddd�ddd�dd�d  ,� �  �� /�  и  /� ܹ  �� � ܹ  ��  � и � и  �  �� � � �    +�     +�   	 +�  �  �� � и 	� и � и � �01535!3##!!3535#,d,dd�,�d�d�ddd�d�d,d�d   ,� �  ϸ /� и /� 	ܹ  ��  и 	� ܹ  �� и � и �  �� и � и � и � и 	� и � � �  EX� /�  >Y�  EX� /�  >Y�   	 +�    +� �  ��  и �  �� и � 
и � �013#3#!5#5335#535##535!�dddd��d�dddd�d,@�d�dddd�d�ddd   ����  & � /�  EX�  /�   >Y�  �� и �01###53535�d��dd�dddddd  �� �  J�    +� �  ��  и � 	� � /�  EX�  /�   >Y�    +� � 
�01#53533!53�dd�d�pd�dd��dd     ����    ��    +� �  ��  ��  и � и � и � 	и � 
и � к   9� /� ܸ и � и � и � и � � �  EX� 	/� 	 >Y�  EX� /�  >Y�     +�    +� 	�  �� �  �� � и и � и и и и � и �01!5!%5!33##!5#5#35��D�,��,dddd��dddX����p�dddd�pdddd�d    d,L�  ?�� &  ' +�    + +�    +�     +� �  �� � и �  �� � 	и � и � и � и � и 	� и � и � и 	� и � и � и � и  � и &� " �� +� #и '� $ �� &� )и "� -и +� /и $� 0и &� 1и )� 2и '� 3и &� 5и )� 6и +� 7и $� 8и "� 9и  � ;и � =� � 	   +�    +�    +�    +�    +� �  и 	� и �  �� �  �� � и � и  �  �� � и � и � и � и �  и  � !и 	� "и � #и � $и � &и 	� (и � )и � *и  � +и � ,и � -и � .и � /и � 0и � 1и � 2и � 3и � 4и � 6и � 8и � 9и � :и � ;и � <и � =и � >и � ?�01####5353535#5#5#533333#####5353535#5#5#533333#�dddddddddddddddd�ddddddddddddddddXddd�ddddd�ddddddddd�ddddd�ddddd  d dL�    A� 7  	 +�    +� 7� 5 ��  и 	� и 5� и 7� - �� и -�  �� �  ��  ��  �� и � и � и � и � и � и �  и � "и � #и � $и � &и � (и � *и � ,и 7� .и 5� 0и 	� 2и -� 8и � 9и � :и � <и � >и � @� � /� 1/�  EX� #/� # >Y�    +�     +�    +�    +�  �  �� � 
и � й  �� � и �  �� � и � и � и  � !и � %и � )и � +и � -и � 3и � 4и � 5и � 7и � ;�01#53533!533##5!5353535#53#########535353535353535�dd�d�pd ddd��dd�dddddddddddddddddddd�dd��dd�Dd����d�p���d����d���d����d���    d dL�  ! E� ;  	 +�    +� ;� 9 ��  и 	� и 9� и ;� 1 �� и 1�  �� �   ��  ��  �� и �  ��  � и � и � и � и � !и � "и � $и � &и  � (и � )и � *и � ,и � .и � 0и ;� 2и 9� 4и 	� 6и 1� <и � =и � >и � @и � Bи  � Dи � E� �  EX� '/� ' >Y�    +�     +�    +� -   +�    +�  �  �� � 
и �  �� -� и � и � и � и � и � "и � #и  � %и � )и � /и � 1и � 3и � 5и � 9и � ;и � ?�01#53533!53535!3##!!3535#53#########535353535353535�dd�d�pd�d,dd�,�d�ddddddddddddddddddd�dd��dd�ddd�d�d,d�d�d����d���d����d���   d dL�  ) - Qɻ    +� �  ��  ��  и �  �� � и  � и � и � и  � и � 
 �� � и � и � и � и 
� и � O �� + ��   �� и +�  �� +� !и � #и � $и O� % �� O� 'и O� ,и (и !� *и  � .и � 0и  � 2и +� 4и !� 5и O� 6и ,� 7и %� 8и � :и � ;и � <и  � =и � >и � @и 
� Bи � Dи � Fи � Hи  � Iи � Jи � Kи %� Lи ,� Nи +� Pи !� Q� �  /� A/� %  # +�    +�    +� (  , +� M   +�   	 +� �  ��  и � 
и M� и � и � и � и � и #� й  �� "� и #� ' �� � *и � .и � /и � 1и � 3и � 5и (� 9и ,� ;и � =и #� Cи "� Dи %� Eи '� Gи 	� Kи � O�013#3#!5#5335#535##535!3##5!5353535#53#########535353535353535�dddd��d�dddd�d,�ddd��dd�dd�ddddddddddddddddd@�d�dddd�d�ddd��d����d�p���d����d���d����d���    d dL�  ' �� 	   +�     +�  � и �  �� и 	� и 	� и �  и  � "и � $� �  EX� /�  >Y�    +�    +� �   �� � 	и �  �� и � и � �0153##3!5353##!5#5#353535353#���ddd�d�dd��dddddd�d���dd�ddd�dddd�dddd�d    d dL�  # /6�     +�    +�    +�  � и �  �� � и � и � и � и �  и � !и  � "и � &и � (и � ,и � -и  � .и � 1� �  /� /�  EX� 
/� 
 >Y� $  + +�    +�    +�     +�  � и 
�  �� � и � и � и и  � и  � и � и и � !и +� '�01%#3535353533333#!%5#5#5###33#5#5#5,�dddd�dddd���Xdd�dd,dd��dd dddddddd��,��dddd�Ldddddd   d dL�  # /6�     +�    +�    +�  � и � 	 �� � и � и � и � и 	� и �  и  � "и � &и � (и � )и � ,и 	� .и � 1� �  /� /�  EX� 
/� 
 >Y� &  ) +�    +�    +�     +�  � и 
�  �� � и � и � и и  � и  � и � и и � !и )� -�01%#3535353533333#!%5#5#5###5!###535,�dddd�dddd���Xdd�dd,,d��dd dddddddd��,��dddd��dddddd  d dL�  ' 3��    +�    +� � 	 ��  ��  и �  ��  � и � 
и 	� и � и � и 
� и � и 	� и � и � и � и � и � # �� � %и  � &и � (и  � )и � *и � ,и 	� .и � /и � 0и � 2и 
� 3� � /� $/�  EX� /�  >Y�  EX� /�  >Y�  EX� /�  >Y�  EX� /�  >Y� (  & +�   ) +�   0 +� �   �� �  ��  �� � и � и 	и 
и � и � и 0� и �  �� � и � и �  и !и 0� "и 0� +и !� -и .и )� 1�0133#5##53535#3535353533333#!%5#5#5###�dd���dd��dddd�dddd���Xdd�dd�dddddddd�� dddddddd��,��dddd�    d dL�   3��    +� �  ��   �� � и � и � 	и  � и � и  �  �� и  � и � и � и � и � и � !и � "и � #и � $и  � )и � +и � ,и � / �� � 1и � 2� � /� 0/�  EX� &/� & >Y�     +�    +�   2 +� +   +� )   +�  � и � и � и � 	и &�  �� � и � и � и �  и !и +� "и )� $и !� ,и -и � .�01#5##53533535#5#5####3535353533333#! ��dd��ddd�dd�dddd�dddd����ddd�ddd��|�dddd�� dddddddd��,     d dL�  # ' +B�     +�    +�  � и  �  �� 	и �  �� � и � и � и � и � и  � "и � #и  � $и � %и � &и � (и � )и � *� �  /� /�  EX� 
/� 
 >Y� %  $ +�    +�    +�     +�  � и 
�  �� � и � и � и и  � и  � и � и и � !и %� (и $� *�01%#3535353533333#!%5#5#5###5373#,�dddd�dddd���Xdd�dd����d dddddddd��,��dddd������  d dL�  # ' + / 3��     +� 	   +�    +�  � и 	�  ��  �� � и � и � и � и 	� и �  и  � "и � $и 	� %и 	� (и � *и � ,и 	� .и � 0и � 1и � 5� �  /� /�  EX� 
/� 
 >Y�  EX� (/� ( >Y� /  % +�    +�    +�     +�  � и 
�  �� � и � и � и и  � и  � и � и и � !и %� & �� )и 
� +и %� -и &� 0и %� 2�01%#3535353533333#!%5#5#5###3#53#5#53,�dddd�dddd���Xdd�dddddd��,ddd dddddddd��,��dddd���ddd�dd���    d dL@  ! ��    +�     +� � и � и  � 
ܸ и  � и � и  � и 
� � �  EX� /�  >Y�  EX� /�  >Y�    +�    +�     +� 	  
 +� 	� и � и 	� и �  �01###!!!!!#3535353535!!Xddd�,��,����ddddd�����dd��,�����p��dddd�  d dL� /c� 
  ' +�    +� �  �� '�  �� и � и � и � и � и � и � и 
� и � и 
� #и 
� +и � -и � 1� �  EX� ,/� , >Y�  EX� /�  >Y�   +�    +�    +� ,�   �� �  �� ,�  ��  � и и � и 	и � 
и � и � и �  �� "и � #и � $и � &и � 'и � (и )и � / �� *�013#5#5!#3!5353#####!53535#5#5#3535!3�d�d�pdd�d�ddddd��dd�ddddXd�ddd�ddd�dddddddddd�ddd    d dL�   ^�   
 +� � и � � �  EX�  /�   >Y�   	 +�    +�    +�  �  �� � �01!!!!!33#5#5#5L��X�� ��dd��d���������dddddd  d dL�   V�    +� � � �  EX� /�  >Y�    +�    +�    +� � 	и �  �015!###535!!!!!X,d��dX��X�� �@dddddd����������     d dL�   ��   
 +� � и � � �  EX� /�  >Y�  EX� /�  >Y�  EX� /�  >Y�  EX�  /�   >Y�   	 +�    +�  �  �� �  �� �  ��  �� � и � и и и � и � �01!!!!!33#5##53535L��X�� �Xdd���dd���������dddddddd   d dL�    ��    +�    +� �  и �  �� � 
и  � и � � �  EX� /�  >Y�    +�     +�    +� � и  � и � 	 �0153%#5!!!!!,������X�� ��������p�������� , d��   \� 	   +� 	� � �  EX� /�  >Y�     +�    +� �  �� и и � 	и � �01%53#5!#333#5#5#5,��X����dd��dd� �����@dddddd , d��   \� 	   +� � � �  EX� /�  >Y�     +�    +� �  �� и и � 	и � �01%53#5!#3###53535,��X��d��ddd� �����@dddddd   , d��   ӻ 	   +� � и 	� и 	� и � � �  EX� /�  >Y�  EX� /�  >Y�  EX� /�  >Y�  EX� /�  >Y�     +� �  �� и и � 	и �  ��  �� и �  �� � и � и и и � �01%53#5!#35333#5##535,��X���p�dd���dd� ������dddddddd  , d��    � /� и /� ܸ �  �A �  ]A o  ]A �  ]� � и � �A �  ]A o  ]A �  ]�  �� � 	 �� � 
и � и � и � и 	� и � � �  EX� /�  >Y�     +�    +� �  �� и и � 	и � и � �01%53#5!#3#5!#5,��X���p�X�d� �����@����     d dL�   ��   +�    +�    9�  /� �  �� 
и  � и  �  �� и � и � и � � �  EX� /�  >Y�    +�     +� �  ��  � и � и � и � и �01!33##!#5!3#!53#5!��dddd�Dd,���dd�p�Xdd�ddX���pd d    d dL�  /A�    +� �  ��  и �  ��  ��  �� !� и � и � 
и � и  � и � и � и � и � и  � и � и � и � и �  и � " �� � $и !� %и � &и � *и � +и � .и  � /� � /� #/�  EX� /�  >Y�  EX� !/� ! >Y�    +�   	 +� �  и � и � и 	� �0153353##5##5#33333333#5#5#5#5#5#5���dd��d��dddddd��ddddd@ddd�ddd����D��ddddd��P�ddddd     d dL�   + ��    +� &   +� � и �  �� и � 
и � и &�  �� � и � и �  и � "и � *и &� -� �  EX� !/� ! >Y�    +�     +� � и �  �� � и !�  �� !�  �� � и и � и � и и %и &и � '�0133#5#5#5!53#5!#35#5#3535!33##Xdd��dd�dd�pdddddddXdddd�dddddd��dXdd����dd dddd��dd    d dL�   + ��    +� &   +� &�  �� и � и �  �� и � и � и � и �  и � "и � *и &� -� �  EX� !/� ! >Y�    +�    +� � 	и �  �� � и !�  �� !�  �� � и и � и � и и %и &и � '�015!###535!53#5!#35#5#3535!33##X,d��dd�dd�pdddddddXdddd@dddddd��dXdd����dd dddd��dd   d dL�   /i� 
   +�    +� �   �� �  �� � и  � и 
� и 
� и � и � и � "и � $и 
� *и  � ,и � 1� �  EX� #/� # >Y�  EX� '/� ' >Y�  EX� +/� + >Y�  EX� /�  >Y� 
   +� �   �� 
� и �  �� �  �� � и 	и  � и � и и и и  � и '�   �� #� % �� " �� '� $и %� &и )и *и '� ,и "� -�01!53#5!#35#5#3535!33##33#5##53535��dd�pdddddddXdddd�dd���dd,dXdd����dd dddd��dd@dddddddd     d dL�   /D� 
   +�    +� 
�  ��  и � и 
� и 	� и 
� и 	� и � и �  �� � и �  и � $и 
� &и 	� 'и � (и � ,и � .� �  EX� /�  >Y� 
   +� -    +� ,  ! +� �   �� 
� и �  �� �  �� � и 	и  � и � и и и и  � и  � #и !� %и ,� 'и -� )�01!53#5!#35#5#3535!33###5##5353353��dd�pdddddddXddddd��dd��d,dXdd����dd dddd��ddxddd�ddd�  d dL�   # '"� 
   +� %  & +� �   ��  & %9� /� %� и � и  � и 
� и 
� "и и 
� и "� и %� и �  �� %� и 
� ! �� � )� �  EX� /�  >Y� 
   +�    ! +� �   �� 
� и �  �� �  �� � и 	и  � и � и и и и  � и  � $и !� %�01!53#5!#35#5#3535!33###5!#5��dd�pdddddddXdddd�p�X�,dXdd����dd dddd��dd@����    d dL�   3=�    +�    +� /   +�   9� /�   �� �  �� и  �  �� и и � 	и � 
и  � и и � и � и � и �  и � "и � $и � &и � (и /� *и � - �� 0и � 2и /� 5� �  EX� %/� % >Y�  EX� )/� ) >Y�     +� )�  �� и � и  � и � !и "и +и ,и  � /�01!53####!#35353535##535#3535!353#3##�,ddddd���ddddd��d�dddd�d�dddd,d���� d�D����dd�d�dddd�d�|dd    d dL�   ��  /� /�  � и /�  �� 
и �  �� � и � и � !� �  EX� /�  >Y�  EX� /�  >Y�    +�     +� � и �  �� и � и � �0133#5#5#5#33!533##!5#Xdd��ddd�d�d�dd��d�dddddd����|dd��ddd    d dL�   ��  /� /�  и  � и /�  �� �  �� � и � и � !� �  EX� /�  >Y�  EX� /�  >Y�    +�     +� � и �  �� и � и � �01###53535#33!533##!5#�d��dd�pd�d�d�dd��d�dddddd����|dd��ddd   d dL�  #� $/� 	/� $� и /�  �� 	�  �� 	� и � и 	� и � и � %� �  EX� /�  >Y�  EX� 
/� 
 >Y�  EX� /�  >Y�  EX� /�  >Y�  EX� /�  >Y� 	   +� �  ��  и 	� и � и �  �� �  ��  �� � и � и и и �  и � !�01#33!533##!5#33#5##53535�d�d�d�dd��d�dd���dd,��|dd��ddd�dddddddd     d dL�    ��    +�    +� � 	и �  �� � и 	� и � и � и и �  � �  EX� /�  >Y�  EX� 
/� 
 >Y� 	   +�    +� �  ��  и 	� и � и � и � �01#33!533##!5#5373#�d�d�d�dd��dd����,��|dd��ddd����  d dL�  +?�    +�   	 +�    +� � к  	 9� /� 
и 	� и �  �� � и � и � и � !и � #и 	� %и � 'и � -� � "/�  EX� /�  >Y�  EX� /�  >Y�    +�    +� � 	и � и �  �� и и и � ܸ и � и и � и и �   �� $и � &и � (и )и � *и +�015!###535333353533######5#5#5#X,d��d�p�dd�dd�dddd�dddd@dddddd����dddd,�pddd��ddd   d dL@   ��    +�    +� � и �  �� и � и � и � и � � � /� /�  EX� /�  >Y�     +� � 	 �� � и 	� и �01#3!33##!53#5,��Xdddd���dd������dd�dd��d,d  d d�� '
�    +�   +� � к 	  9� 	/� 
 ��   9� /�  �� и 
� и � и �  �� � и 
� и �  �� 	�  и � "и � #и 	� $и � &� �  EX� /�  >Y�  EX� /�  >Y�  EX� %/� % >Y�    +�     +� � и  �  �� 	и  � #�01#3535333#333#!5!5#5#5#3#5#,�dd��dddddd��ddddddx��xdddd�p��dd�pd��dd�,dd  d dL�  % 1D�     +� 	   9� 	/� ܸ и %� и � ! �� " �� и %� и  � и 	� и 	� и � и %� и "� и 	� и "� и � $и � *и %� +и  � .и 	� 0� �  EX� &/� & >Y�     +� 
   +�    +�    +�    +� 
� и � и  � и � и � и � и � !и � #и &� ) �� -и .�01!535#5!#35#5#3535!35!5!33#5#33#5#5#5��dd�pddddddd�d��Xdd�d�dd��d,ddddd��dd,ddd��dd��ddxdddddd  d dL�  % 1D�     +� 	   9� 	/� ܸ и %� и � ! �� " �� и %� и  � и 	� и 	� и � и %� и "� и 	� и "� и � $и "� (и � *и %� +и  � .� �  EX� '/� ' >Y�     +� 
   +�    +�    +�    +� 
� и � и  � и � и � и � и � !и � #и '� + �� /и 0�01!535#5!#35#5#3535!35!5!33#5#5!###535��dd�pddddddd�d��Xdd�d�,d��d,ddddd��dd,ddd��dd��dddddddd     d dL�  % 5��     +� 	   9� 	/� ܸ и %� и � ! �� " �� и %� и  � и 	� и 	� и � и %� и "� и 	� и "� и � $и � (и %� )и "� *и 	� 0и  � 2� �  EX� &/� & >Y�  EX� */� * >Y�     +� 
   +�    +�    +�    +� 
� и � и  � и � и � и � и � !и � #и *� + �� ( �� &� ) �� -и .и +� /и 0и .� 1и 2и (� 3�01!535#5!#35#5#3535!35!5!33#5#33#5##53535��dd�pddddddd�d��Xdd�dddd���dd,ddddd��dd,ddd��dd��ddxdddddddd     d dL�  % 5��     +�    +� � и  � и  � 	 �� и 	� и � и � и � "и и 	� и � и "� и � ! �� � $и � &и  � *и � +и 	� ,и  � .и � /и � 2и � 4и "� 5� �  EX� //� / >Y�  EX� 3/� 3 >Y�     +� 
   +� 2  ' +�    +�    +�    +� 
� и � и  � и � и � и � и � !и � #и 3� & �� )и *и '� +и 2� -�01!535#5!#35#5#3535!35!5!33#5##5##5353353��dd�pddddddd�d��Xdd�d��dd��d,ddddd��dd,ddd��dd��dd�ddd�ddd�    d dL�    -o�    +�    +�    9�  /�  �� -  9� -/� 	и � и !� и -� и � и  � и  � и  � и -� и �  и  � "и � $и !� %и � ( �� -� ) �� � *и !� +и )� /� �  EX� /�  >Y�  EX� /�  >Y�    +�    +�     +�    +� $  ! +� �   �� и и � 
и � и � и � и  � и !� 'и � )и � +�015373#!535#5!#35#5#3535!35!5!33#5#,�������dd�pddddddd�d��Xdd�d�����ddddd��dd,ddd��dd��dd   d dL�  % ) - 1 5̻     +� 	   9� 	/� ܸ и %� и � ! �� " �� и %� и  � и )� и 	� и 	� и � и %� и "� и 	� и "� и � $и  � &и  � * �� 'и +и *� / �� ,и *� 0и '� 1и � 2и /� 3и %� 5� �  EX� ./� . >Y�     +� 
   +� '  ( +� )   +�    +�    +� 
� и � и  � и � и � и �  �� и � !и � #и .� & �� � *и (� +и )� ,и � -и &� /и 0и (� 2и )� 3и 0� 4и 5�01!535#5!#35#5#3535!35!5!33#5#3#53#5#53��dd�pddddddd�d��Xdd�d�pddd��,dd,ddddd��dd,ddd��dd��dd�ddd�dd���  d dL�   ! ͻ   
 +�    +�    +� �  и � и и � и 
� и � и �  �� и � и � и � #� �    +�    +�   +� �  ��  и � и � и � и � и � и � �0135##35#35!5!5!35!3!!!5#��������dd,�p��,d�p,��d ��p���d�d��ddd����dd     d dLx /C�    +�    +� � 	и �  �� и �  �� и � и � и � и � и � #и � %и � +и � -и � 1� �  EX� /�  >Y�  EX� /�  >Y�  + +� 
   +�   # +� �   �� #� и � и � и � и �  ��  �� 
�  �� � и � и � и  �  �� и �  и � !и  � $�01#5#5#3535!33#5#5!#3!5353#####!5353��ddddXdd�d�pdd�d�ddddd��dd�ddXdddd�ddd�pddd�ddddddd    d dL�  ) 1�    +�    . +� .� и � ' �� и � 
и  � и � и � $и .� (и � *и '� /и  � 3� �  EX�  /�   >Y�    +�    +�  # +�    +�   , +�  �  �� и и � и � и � и � и � и � %и � 'и � (и #� + �� � .и ,� 0�0133#5#5#5##!5#5#3535!33#!3!5!5#5!#Xdd��d dd��ddddXddd�Dd��Xd�pd�dddddd��dddddXdddd��dddd,ddd     d dL�  % 1�   
 +�    +� � и � и � и 
�  �� � и � !и � #и � *и � .и � 3� �  EX� '/� ' >Y�    +�     +�   +�    +�     +� � и � 	и � 
и � и � и  � и � и � и �  �� � "и  � $и '� + �� /и 0�01##!5#5#3535!33#!3!5!5#5!#5!###535Ldd��ddddXddd�Dd��Xd�pd,,d��d�dddddXdddd��dddd,dddXdddddd    d dL�  % 5_�   
 +�    +� � и � и � и 
�  �� � и � !и � #и � (и � 0и � 2и � 7� �  EX� &/� & >Y�  EX� */� * >Y�    +�     +�   +�    +�     +� � и � 	и � 
и � и � и  � и � и � и �  �� � "и  � $и *� + �� ( �� &� ) �� -и .и +� /и 0и .� 1и 2и (� 3�01##!5#5#3535!33#!3!5!5#5!#33#5##53535Ldd��ddddXddd�Dd��Xd�pd�dd���dd�dddddXdddd��dddd,ddd�dddddddd    d dL�  % ) -i�   
 +� +  * +�  * +9� /�  �� +� и � и � &и и +� и � и � и &� и 
�  �� � и +� и � !и � #и &� %и � ) �� � /� �  EX� '/� ' >Y�  EX� */� * >Y�    +�     +�   +�    +�     +� � и � 	и � 
и � и � и  � и � и � и �  �� � "и  � $и '� & �� ,и -�01##!5#5#3535!33#!3!5!5#5!#5373#Ldd��ddddXddd�Dd��Xd�pd�����dddddXdddd��dddd,ddd�����     � d��   '8�   
 +� �  ��   ��  
 9� /�  �� �  �� � и  � и � и � и � и � и � и � и 
� и � и � и � и � и �  и � !и � "и 
� $� �  EX� /�  >Y�    +� 
  	 +� �  �� и � и � и � и 	� и 
� и � и �  �� #и $�013#5#5##5!33#5#5##5!333#5#5#5 d�dd��dd�dd��d��dd��d,�dd����d�dd����Ldddddd   , d��   '8�   
 +� �  ��   ��  
 9� /�  �� �  �� � и  � и � и � и � и � и � и � и 
� и � и � и � и � и  � и �  и � $и � &� �  EX� /�  >Y�    +� 
  	 +� �  �� и � и � и � и 	� и 
� и � и �  �� #и $�013#5#5##5!33#5#5##5!3###53535 d�dd��dd�dd��ddd��dd,�dd����d�dd����Ldddddd     � d��   +k�   
 +�  
 9� /�   �� �  �� � и �  ��  � и � и � и � и � и � и 
� и � и � и � и � и � и  �  и � "и 
� (� �  EX� /�  >Y�  EX�  /�   >Y�    +� 
  	 +� �  �� и � и � и � и 	� и 
� и � и  � ! ��  �� �  �� #и $и !� %и &и $� 'и (и � )�013#5#5##5!33#5#5##5!333#5##53535 d�dd��dd�dd��d�dd���dd,�dd����d�dd����Ldddddddd  � d��    #)�    +�     +� 
  9� 
/�  ��  �� � и �  �� � и  � и � и � и � и � и � и 
� и � и � и �  и  � !� �  EX� /�  >Y�  EX�  /�   >Y�    +� 
  	 +� �  �� и � и � и � и 	� и 
� и � и �  �� "и #�013#5#5##5!33#5#5##5!35373# d�dd��dd�dd��d������,�dd����d�dd���������    d dL@ 	 # ��     +�    +� �  �� и  � и � и � и � и � и � и  � !и � %� � /�     +�    +�    +� �  и  �  �� 
и � и � и � и � �013!53!##3535!5!5!533###!5#,d,d�pddddd��p��dddd�d�dd�d�Xddd�����|ddd   d dL�  #5�    +� � и  � и �  �� и � и � 	ܹ  �� 	� и 	�  �� � и � и � и � и � и  � и � и � и �  и 	� "и � #� � /� /�  EX� /�  >Y�  EX� !/� ! >Y�     +�    +�     +� � и � 	и  � и � и !�  �� и и � и  � �01#335!33##5!#5##5353353,��d�dd�d�p���dd��d �D�dddd���dd�ddd�ddd�     d dL�   + �    +� &   +� � и �  �� и � 
и � и &�  �� � и � и �  и � "и � *и &� -� �  EX�  /�   >Y�    +� "   +�  �  �� и и �  �� � и "�  �� и � и � и � %и � '�0133#5#5#5!53#5!#35#5#3535!33##Xdd��dd�dd�pdddddddXdddd�dddddd�Pd�dd�p��ddXdddd��dd    d dL�   + �    +� &   +� &�  ��  и � и �  �� и � и � и � и �  и � "и � *и &� -� �  EX�  /�   >Y�    +� "   +�  �  �� и и �  �� � и "�  �� и � и � и � %и � '�01###53535!53#5!#35#5#3535!33##�d��dd��dd�pdddddddXdddd�dddddd�Pd�dd�p��ddXdddd��dd    d dL�   /;� 
   +�    +� �   �� �  �� � и  � и 
� и 
� и � и � и � "и � $и 
� *и  � ,и � 1� �  EX�  /�   >Y�  EX� $/� $ >Y� 
   +�    +� �   �� 
� и �  �� и  � и � и � и  � и $� % �� " ��  � # �� 'и (и %� )и *и (� +и ,и "� -�01!53#5!#35#5#3535!33##33#5##53535��dd�pdddddddXdddd�dd���dd,d�dd�p��ddXdddd��ddxdddddddd   d dL�   /A� 
   +�    +� 
�  ��  и � и 
� и 	� и 
� и 	� и � и �  �� � и �  и � $и 
� &и 	� 'и � (и � ,и � .� �  EX� )/� ) >Y�  EX� -/� - >Y� 
   +� ,  ! +�    +� �   �� 
� и �  �� и  � и � и � и  � и -�   �� #и $и !� %и ,� '�01!53#5!#35#5#3535!33###5##5353353��dd�pdddddddXddddd��dd��d,d�dd�p��ddXdddd��dd�ddd�ddd�     d dL�   # '� 
   +� %  $ +� �   ��  $ %9� /� %� и � и  � и 
� и 
�  и и 
� и  � и %� и �  �� %� и 
� # �� � )� �  EX� !/� ! >Y�  EX� $/� $ >Y� 
   +�    +� �   �� 
� и �  �� и  � и � и � и  � и !�   �� &и '�01!53#5!#35#5#3535!33##5373#��dd�pdddddddXdddd������,d�dd�p��ddXdddd��dd�����   d dL�  ) 7 �    +� "    +�   9� /� 7 �� и � и 7� и 7� и � и � и � и  � к    "9� /�   �� $и "� &и � (и  � *и � ,и  � .и  � 9� � 7   +�     +� � и 7� и  � и � и  � !и 7� %�01!#3535353535##535#3535!353#3##'53##### �pdddddd�pd�dddd�d�ddddddddddd�d�pdddd��dd�dXdddd�d��dd�d�ddddd    d dL�   ��  /� /�  �  и  /�  �� � 
 �� � и � и � и 
� !� �  EX� /�  >Y�    +� � и �  �� 
и � и �  �� и �0133!533##!5#5#33#5#5#5d�d�d�dd��dd�dd��dL�Ddd���dddd�dddddd  d dL�   ��  /� /�  �  и  /�  �� � 
 �� � и � и � и 
� !� �  EX� /�  >Y�    +� � и �  �� 
и � и �  �� и �0133!533##!5#5####53535d�d�d�dd��dd d��ddL�Ddd���dddd�dddddd  d dL�  # Ӹ $/� /� и $� и /�  �� 
и �  �� � и � и � %� �  EX�  /�   >Y�  EX� /�  >Y�    +� �  ��  ��  �  �� и и � 	и 
и � и и � и � и �  �� и � "�0133#5##5353533!533##!5#5#�dd���dd�p�d�d�dd��dd�dddddddd�p�Ddd���dddd    d dL�    ��     +�    +� � и � 
 �� � и � и � и � и и �  � �  EX� /�  >Y�  EX� /�  >Y�    +� � и �  �� 
и � и �  �� и �0133!533##!5#5#5373#d�d�d�dd��dd�����L�Ddd���dddd�����   d dL� ! -�    +�    +� �  к   9� /� и � и � и � и �  �� �  и � "и � $и � &и � (и � /� �  EX� #/� # >Y�     +�   	 +�   +� �  �� 	�  �� � и � и � и � и � и � и � и � и #� ' �� +и ,�01%5!53##!5#5#33353535353##5!###535,�ddd�pdd�d�ddd�dd��,d��dd�d,dddd���ddddd��dddddddd    d dLx   ݻ    +� 	   +� � и 	�  ��   	9� /�  �� 	� и � и � и � и 	� и � и � и � !� � /� /�    +�     +�    +�    +� � 	и  � и � и � и � и � �01#335!33##!53!53#5!,����dddd�p��,dd�������ddd�ddd���dd,dd  d dL�   )_�    +�    +� �  и �  �� � и  � 	к 
  9� 
/� � и #� и 
� и � и � и  � и � и 
�  и � "и � $ �� 
� % �� � (и #� )и %� +� �  EX� /�  >Y�  EX� /�  >Y� 	   +�    +� #  +� �   �� и и #�  �� �  �� � и � и � и #� и � и � и � и 	� %�015373#5!53##!5#5#33353535353##,�����p�ddd�pdd�d�ddd�dd�����P�d,dddd���ddddd��dd   X���   I�    +� �  ��  и � � � /�  EX�  /�   >Y�  EX� /�  >Y01#53!353�dd��dd�dd�����d ,�X�   8�    +� �  �� и � � �  /�  EX� /�  >Y0153#!##,dd,dd�dd,,�pd   ����     ѻ    +�    +� �  ��  и � и �  �� и � � �  EX� /�  >Y�  EX� /�  >Y�  EX�  /�   >Y�  EX� /�  >Y�  �  �� 
и и и и и и �  ��  �� и � и и � �01#53!3533!353%#5�d�d��dd�d��ddXd�dd�����d����dddd     ����     ۻ    +�    +� �  �� �  �� � и � и � и � и � � �  EX� /�  >Y�  EX� /�  >Y� ܹ   �� �  �� �  �� 	и � 
и и � и и 	� и и � и и  � и � и �0153#!##%#!##53�d�d,dd�d,dd��d�dd,,�pd�,�pdddd  ,X�L  ?�     +� � и  � � �   +�    +� �  и � 	�015!3#!5#��dd�pd�dd��dd,  d dL,    �� /� и /�  �� � �A @  P  ]A �  ]�  �� � 
�A � 
 ]A @ 
 P 
 ]� 	 �� � �     +�  � и � и  � и � 	�01#5!#5!#5,�X�X�,������    � d��  ��     +�  � к    9� /� � и �  �� 	и �  �� �  �� 
� и � и � и � и � и 
� и � и � и � и 
� и � и � и � � � 
/� /01#5353535353###333#5#5#5#,dddddddddddddddd�ddddd�ddddd�ddd   , d �  ��    +�     +� �  �� � и �  �� � 	и � и � и � и � и 	� и � и � и 	� и � и � и � и  � � � /� /01####5353535#5#5#533333#�dddddddddddddddd�ddd�ddddd�ddddd  d dL� # L� $/�  /�  ��  � и $� и /�  �� и � %� � /�  EX�  /�   >Y013#########353535353535353��dddddddd�dddddddd��pddddddd���ddddddd  d dL�  h� 	    +� 	� и 	� и  � � � /�  EX� /�  >Y� 
   +�    +� 
�  и �  �� � �01!!!!3###5���D�����d����p��d��,d  d dL� + � *   +� � и � и *� и *� !и *� %� �  EX� /�  >Y�  EX� /�  >Y�  EX� /�  >Y�    +�    +�    +�    +� � и �  ��  �� и � и �  �� � и �  и � "и � $и � &и � (�01!!53535#535#533535!33#5#5##!!!!#���dd����dd�dd�d�d��p��pd,��d��d��dddd�ddd���d��  d dL� ! )?�    +�   % +�    +�    +�    +� � ! �� и �  �� � и � и � и � и � и � и �  и � "и � &и !� 'и %� (и � +� �  EX� /�  >Y�  EX� '/� ' >Y�    +� %    +�    +� � и %� и � и %� и  � и �  �� � и � и � и � #�01#!3353!#5#3!5335####353#5�d,ddd�dd���dd�dd��dddX�xd�����d��p�d�,��Xd �Dd�d   d dL� 7�   % +�    +� �  �� # % 9� #/�  �� и � 	и � и � и %�  �� � и � и � и � и �  и � !и %� )и %� -и #� /и � 1и � 3и � 4и � 5� �  EX� /�  >Y�  EX�  /�   >Y�  EX� /�  >Y�  EX� 0/� 0 >Y�    +�    +�    +�    +� � и  �  �� и и и � и �  �� � и � и �  и � "и � #и � $и � %и � &и � (и � *и � ,и � .и /и � 1и � 7 �� 2и � 5 �013#5!##!!!!33!53##!5#5#5##535#535353535!3�d���dd,��,��dd,�dd�pdddddddddd�d�ddddd�d��ddddddddd,�d��dddd     d�L�     ��    +�    +�    +� � и � и � и � � � /� /� /�  EX� /�  >Y�  EX� /�  >Y�  EX� /�  >Y� � 	 �� и й   �� и � 
и  � и � и и и �01#5##33753##5!#5!##�ddddd�ddd�����ddd�pXdddd���ddd�   � ��x  H�     +� � и  �  �� и  � ܸ � � /�  /�  EX� /�  >Y017!33333#####�,dddddddddd��ddddd�ddddd     � ��x  X�   +� �   �� �  �� � и � и  � и � � � /�  /�  EX� /�  >Y01%5#5#5#5#5#53535353535!�dddddddddd,�ddddd�ddddd�P    d �Lx  7�    +� 	  9� 	/�  � � /�     +�  � �01#####5#5#5#5#!Ldddd�dddd�����������    d �Lx  7�    +� 	  9� 	/�  � � 
/�     +� � �01%!3535353533333L�dddd�dddd����������     d,L # Ի    +�   9� /�  ��  и �  �� �  �� � и  � и � и � "и 	и  � и � и � и � и  � и � и "� и � и �  � � /�  EX� /�  >Y� 
   +� � и 
� �0153###!!333#5#5#5#5#5353535��ddd��Dddd�ddddddd�ddddd�dddddddd�ddd   d,L # л    +�   9� /�  ��  и � и �  �� и �  �� и � и � и � и � и � и � и � и � и �  и � "и � #� � /�  EX� !/� ! >Y�    +� � и � �01333#####5353535!5!5#5#5#53 ddddddd�ddd�D�ddd��ddd�dddddddd�ddddd   d,L N�    +�   9� /� � и �  �� и �  �� 
и � и �  �� � и �  �� �  �� � и �  �� �  �� � и � и � и 
� и � � �  EX� /�  >Y�    +� 	   +� �   �� и �  �� 	� и � и и � и � и  � и � и  � и � и � и � и и � �01#53535353533333#5#5#5##,�dddd�dddd�dd�d�����������������   d,L 7�    +� �  ��  ��  ��  и �  ��   9� /�  �� 	 ��  ��  � и 	� и и � и 
и � и � и � и � и � � �  EX� /�  >Y�  EX� /�  >Y�    +� �   �� и и �  �� и и и и и и и � и � 	 �� и � и � и � и и и �0153#####5#5#5#5#53333535��dddd�dddd�dd�dL���������������� X d �   8�     +�  � и � � � /�  EX� /�  >Y�   �01533#X��������     d �L�  g�    +� �  �� �  �� и � и � и � и � � � /� /� 	   +� 	�  и � �01!33333#####!d�dddddddddd��,dddd�dddd,    v v v v �
��f��P��@Tl�	~	�
���xL��������| �8�V����zr�<�2�X��z� �!d!�!�"("L"�"�##�$�%�&p''h(B(�(�):)�**�*�+�,&,�-:..P.�/"/�11�1�2J2b2�34464�5�5�6,7�8H9�;f<<�==>=z>"?�ABlD4D�E�FrG�H�I�J�K4L"LxL�MXM�NNfN�O�PP�Q�RhS^T@UU�VnV�W�X.YYvZ0[[�]^_`>`�a�b�cZdReHff�g�h�i<j
j�kplNm0m�n�o2o�pDp�q�r.ssTs�tt�t�uHu�vJv�v�w�xzy�z>z�z�{{F{�|t}D~~8~�      �                                 -        9       
 M      	  W        ^  	   j  	   �  	  4 �  	   �  	  ( �  	    	 	 VCR OSD MonoRegularVCR OSD Mono:Version 1.001VCR OSD Mono1.001 March 31, 2015VCROSDMonoMrManetVCR OSD Mono V C R   O S D   M o n o R e g u l a r V C R   O S D   M o n o : V e r s i o n   1 . 0 0 1 V C R   O S D   M o n o 1 . 0 0 1   M a r c h   3 1 ,   2 0 1 5 V C R O S D M o n o M r M a n e t       �' �                    �          	 
                        ! " # $ % & ' ( ) * + , - . / 0 1 2 3 4 5 6 7 8 9 : ; < = > ? @ A B C D E F G H I J K L M N O P Q R S T U V W X Y Z [ \ ] ^ _ ` a � � � � � � � � � � � � � � � � � � � � � b c � d � e � � � � � � � f � � � � g � � � � h � � � j i k m l n � o q p r s u t v w � x z y { } | �  ~ � � � � � � � � � � � � � � � �	
 �NULLuni00B2uni00B3uni00B9lirapesetaEurotriagrttriaglftriagdntriagup	arrowleft
arrowrightarrowup	arrowdown	arrowboth      ��                
                
  . latn      ��    frac                   �          ,  
      s  �  r  �    t  �               [gd_scene load_steps=12 format=2]

[ext_resource path="res://GameManager.gd" type="Script" id=1]
[ext_resource path="res://BoardManager.gd" type="Script" id=2]
[ext_resource path="res://design.png" type="Texture" id=3]
[ext_resource path="res://ArrowPU.tscn" type="PackedScene" id=4]
[ext_resource path="res://CharacterManager.gd" type="Script" id=5]
[ext_resource path="res://Player.tscn" type="PackedScene" id=6]
[ext_resource path="res://AI.tscn" type="PackedScene" id=7]
[ext_resource path="res://font_vcr_osd_mono.tres" type="DynamicFont" id=8]
[ext_resource path="res://MainMenu.gd" type="Script" id=9]
[ext_resource path="res://font_vcr_osd_mono_big.tres" type="DynamicFont" id=10]
[ext_resource path="res://paint_it_bgm.ogg" type="AudioStream" id=11]

[node name="World" type="Node2D"]

position = Vector2( 15.5125, -5.54016 )
script = ExtResource( 1 )
max_game_time = 240
time_to_claim_score = 8
timer_label_path = NodePath("GameUI/Label")
blue_score_path = NodePath("GameUI/Blue/Score")
red_score_path = NodePath("GameUI/Red/Label")
green_score_path = NodePath("GameUI/Green/Label")
purple_score_path = NodePath("GameUI/Purple/Label")

[node name="BoardManager" type="Node2D" parent="."]

editor/display_folded = true
script = ExtResource( 2 )
sprite = ExtResource( 3 )
tileSize = Vector2( 66, 35 )
tileOffset = Vector2( 2, 3 )
width = 10
height = 10
min_pu_time = 8
max_pu_time = 20
max_pu_at_board = 8
arrow_pu_scene = ExtResource( 4 )

[node name="Timer" type="Timer" parent="BoardManager"]

process_mode = 1
wait_time = 1.0
one_shot = false
autostart = false

[node name="CharacterManager" type="Node2D" parent="."]

script = ExtResource( 5 )
player_scene = ExtResource( 6 )
ai_scene = ExtResource( 7 )

[node name="GameUI" type="Control" parent="."]

visible = false
margin_right = 700.0
margin_bottom = 400.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 0
size_flags_horizontal = 1
size_flags_vertical = 1
_sections_unfolded = [ "Margin" ]

[node name="Blue" type="Control" parent="GameUI"]

editor/display_folded = true
anchor_left = 1
anchor_top = 1
anchor_right = 1
anchor_bottom = 1
margin_left = 65.0
margin_top = 41.0
margin_right = 65.0
margin_bottom = 41.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 0
size_flags_horizontal = 1
size_flags_vertical = 1

[node name="Sprite" type="Sprite" parent="GameUI/Blue"]

texture = ExtResource( 3 )
centered = false
vframes = 10
hframes = 10
frame = 30
_sections_unfolded = [ "Animation", "Offset" ]

[node name="Score" type="Label" parent="GameUI/Blue"]

margin_left = -57.0
margin_top = 22.0
margin_right = -1.0
margin_bottom = 36.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 2
size_flags_horizontal = 1
size_flags_vertical = 4
custom_fonts/font = ExtResource( 8 )
align = 2
autowrap = true
percent_visible = 1.0
lines_skipped = 0
max_lines_visible = -1
_sections_unfolded = [ "custom_fonts", "custom_styles" ]

[node name="Red" type="Control" parent="GameUI"]

editor/display_folded = true
margin_left = -8.0
margin_top = 11.0
margin_right = 32.0
margin_bottom = 51.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 0
size_flags_horizontal = 1
size_flags_vertical = 1

[node name="Sprite" type="Sprite" parent="GameUI/Red"]

texture = ExtResource( 3 )
centered = false
vframes = 10
hframes = 10
frame = 31
_sections_unfolded = [ "Animation", "Offset" ]

[node name="Label" type="Label" parent="GameUI/Red"]

margin_left = 47.0
margin_top = 23.0
margin_right = 87.0
margin_bottom = 37.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 2
size_flags_horizontal = 1
size_flags_vertical = 4
custom_fonts/font = ExtResource( 8 )
percent_visible = 1.0
lines_skipped = 0
max_lines_visible = -1
_sections_unfolded = [ "custom_colors", "custom_fonts" ]

[node name="Green" type="Control" parent="GameUI"]

editor/display_folded = true
anchor_top = 1
anchor_bottom = 1
margin_left = -7.0
margin_top = 42.0
margin_right = 33.0
margin_bottom = 42.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 0
size_flags_horizontal = 1
size_flags_vertical = 1

[node name="Sprite" type="Sprite" parent="GameUI/Green"]

texture = ExtResource( 3 )
centered = false
vframes = 10
hframes = 10
frame = 32
_sections_unfolded = [ "Animation", "Offset", "Transform" ]

[node name="Label" type="Label" parent="GameUI/Green"]

margin_left = 46.0
margin_top = 24.0
margin_right = 86.0
margin_bottom = 38.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 2
size_flags_horizontal = 1
size_flags_vertical = 4
custom_fonts/font = ExtResource( 8 )
percent_visible = 1.0
lines_skipped = 0
max_lines_visible = -1
_sections_unfolded = [ "custom_fonts" ]

[node name="Purple" type="Control" parent="GameUI"]

editor/display_folded = true
anchor_left = 1
anchor_right = 1
margin_left = 63.0
margin_top = 11.0
margin_right = 63.0
margin_bottom = 51.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 0
size_flags_horizontal = 1
size_flags_vertical = 1

[node name="Sprite" type="Sprite" parent="GameUI/Purple"]

texture = ExtResource( 3 )
centered = false
vframes = 10
hframes = 10
frame = 33
_sections_unfolded = [ "Animation", "Offset" ]

[node name="Label" type="Label" parent="GameUI/Purple"]

margin_left = -43.0
margin_top = 23.0
margin_right = -3.0
margin_bottom = 37.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 2
size_flags_horizontal = 1
size_flags_vertical = 4
custom_fonts/font = ExtResource( 8 )
align = 2
percent_visible = 1.0
lines_skipped = 0
max_lines_visible = -1
_sections_unfolded = [ "custom_colors", "custom_fonts" ]

[node name="Label" type="Label" parent="GameUI"]

anchor_left = 2
anchor_right = 2
margin_left = 36.0
margin_top = 19.0
margin_right = -12.0
margin_bottom = 97.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 2
size_flags_horizontal = 1
size_flags_vertical = 4
custom_fonts/font = ExtResource( 8 )
text = "4:00"
autowrap = true
percent_visible = 1.0
lines_skipped = 0
max_lines_visible = -1
_sections_unfolded = [ "Anchor", "custom_colors", "custom_fonts" ]

[node name="MainMenuUI" type="Control" parent="."]

editor/display_folded = true
margin_left = -16.0
margin_top = 6.0
margin_right = 684.0
margin_bottom = 406.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 0
size_flags_horizontal = 1
size_flags_vertical = 1
script = ExtResource( 9 )
_sections_unfolded = [ "Anchor", "Focus", "Grow Direction", "Hint", "Margin", "Material", "Mouse", "Rect", "Size Flags", "Theme", "Visibility" ]

[node name="PlayMode" type="Control" parent="MainMenuUI"]

margin_right = 700.0
margin_bottom = 400.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 0
size_flags_horizontal = 1
size_flags_vertical = 1
_sections_unfolded = [ "Margin" ]

[node name="SinglePlayer" type="Button" parent="MainMenuUI/PlayMode"]

anchor_left = 2
anchor_top = 2
anchor_right = 2
anchor_bottom = 2
margin_left = 64.0
margin_top = -28.0
margin_right = -64.0
margin_bottom = -48.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 0
size_flags_horizontal = 1
size_flags_vertical = 1
toggle_mode = false
enabled_focus_mode = 2
shortcut = null
group = null
text = "Single Player"
flat = false
_sections_unfolded = [ "Margin", "custom_styles" ]

[node name="2 Player" type="Button" parent="MainMenuUI/PlayMode"]

anchor_left = 2
anchor_top = 2
anchor_right = 2
anchor_bottom = 2
margin_left = 64.0
margin_top = -56.0
margin_right = -64.0
margin_bottom = -76.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 0
size_flags_horizontal = 1
size_flags_vertical = 1
toggle_mode = false
enabled_focus_mode = 2
shortcut = null
group = null
text = "2 Players"
flat = false
_sections_unfolded = [ "Anchor" ]

[node name="3 Player" type="Button" parent="MainMenuUI/PlayMode"]

anchor_top = 1
anchor_bottom = 1
margin_left = 286.0
margin_top = 117.0
margin_right = 414.0
margin_bottom = 97.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 0
size_flags_horizontal = 1
size_flags_vertical = 1
toggle_mode = false
enabled_focus_mode = 2
shortcut = null
group = null
text = "3 Players"
flat = false
_sections_unfolded = [ "Anchor" ]

[node name="4 Player" type="Button" parent="MainMenuUI/PlayMode"]

anchor_top = 1
anchor_bottom = 1
margin_left = 286.0
margin_top = 90.0
margin_right = 414.0
margin_bottom = 70.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 0
size_flags_horizontal = 1
size_flags_vertical = 1
toggle_mode = false
enabled_focus_mode = 2
shortcut = null
group = null
text = "4 Players"
flat = false
_sections_unfolded = [ "Anchor" ]

[node name="Controls" type="Button" parent="MainMenuUI/PlayMode"]

anchor_top = 1
anchor_bottom = 1
margin_left = 286.0
margin_top = 62.0
margin_right = 414.0
margin_bottom = 42.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 0
size_flags_horizontal = 1
size_flags_vertical = 1
toggle_mode = false
enabled_focus_mode = 2
shortcut = null
group = null
text = "Controls"
flat = false
_sections_unfolded = [ "Anchor" ]

[node name="Label" type="Label" parent="MainMenuUI/PlayMode"]

margin_left = 256.0
margin_top = 104.0
margin_right = 454.0
margin_bottom = 137.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 2
size_flags_horizontal = 1
size_flags_vertical = 4
custom_fonts/font = ExtResource( 10 )
custom_colors/font_color_shadow = Color( 0, 0, 0, 1 )
text = "PAINT IT!"
align = 1
percent_visible = 1.0
lines_skipped = 0
max_lines_visible = -1
_sections_unfolded = [ "Margin", "custom_colors", "custom_fonts" ]

[node name="Select Bot" type="Control" parent="MainMenuUI"]

visible = false
margin_right = 700.0
margin_bottom = 400.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 0
size_flags_horizontal = 1
size_flags_vertical = 1
_sections_unfolded = [ "Margin" ]

[node name="No Bot" type="Button" parent="MainMenuUI/Select Bot"]

anchor_left = 2
anchor_top = 2
anchor_right = 2
anchor_bottom = 2
margin_left = 64.0
margin_top = -35.0
margin_right = -64.0
margin_bottom = -55.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 0
size_flags_horizontal = 1
size_flags_vertical = 1
toggle_mode = false
enabled_focus_mode = 2
shortcut = null
group = null
text = "No Bot"
flat = false
_sections_unfolded = [ "Margin", "custom_styles" ]

[node name="1 Bot" type="Button" parent="MainMenuUI/Select Bot"]

anchor_left = 2
anchor_top = 2
anchor_right = 2
anchor_bottom = 2
margin_left = 64.0
margin_top = -63.0
margin_right = -64.0
margin_bottom = -83.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 0
size_flags_horizontal = 1
size_flags_vertical = 1
toggle_mode = false
enabled_focus_mode = 2
shortcut = null
group = null
text = "1 Bot"
flat = false
_sections_unfolded = [ "custom_styles" ]

[node name="2 Bots" type="Button" parent="MainMenuUI/Select Bot"]

anchor_left = 2
anchor_top = 2
anchor_right = 2
anchor_bottom = 2
margin_left = 64.0
margin_top = -91.0
margin_right = -64.0
margin_bottom = -111.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 0
size_flags_horizontal = 1
size_flags_vertical = 1
toggle_mode = false
enabled_focus_mode = 2
shortcut = null
group = null
text = "2 Bots"
flat = false
_sections_unfolded = [ "Anchor" ]

[node name="3 Bots" type="Button" parent="MainMenuUI/Select Bot"]

anchor_left = 2
anchor_top = 2
anchor_right = 2
anchor_bottom = 2
margin_left = 64.0
margin_top = -119.0
margin_right = -64.0
margin_bottom = -139.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 0
size_flags_horizontal = 1
size_flags_vertical = 1
toggle_mode = false
enabled_focus_mode = 2
shortcut = null
group = null
text = "3 Bots"
flat = false
_sections_unfolded = [ "Anchor", "Margin" ]

[node name="BackFromBot" type="Button" parent="MainMenuUI/Select Bot"]

anchor_top = 1
anchor_bottom = 1
margin_left = 286.0
margin_top = 53.0
margin_right = 414.0
margin_bottom = 33.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 0
size_flags_horizontal = 1
size_flags_vertical = 1
toggle_mode = false
enabled_focus_mode = 2
shortcut = null
group = null
text = "Back"
flat = false
_sections_unfolded = [ "Anchor" ]

[node name="Time" type="Control" parent="MainMenuUI"]

visible = false
margin_right = 700.0
margin_bottom = 400.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 0
size_flags_horizontal = 1
size_flags_vertical = 1
_sections_unfolded = [ "Margin" ]

[node name="1" type="Button" parent="MainMenuUI/Time"]

anchor_left = 2
anchor_top = 2
anchor_right = 2
anchor_bottom = 2
margin_left = 64.0
margin_top = -57.0
margin_right = -64.0
margin_bottom = -77.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 0
size_flags_horizontal = 1
size_flags_vertical = 1
toggle_mode = false
enabled_focus_mode = 2
shortcut = null
group = null
text = "1 Minute"
flat = false
_sections_unfolded = [ "Margin", "custom_styles" ]

[node name="2" type="Button" parent="MainMenuUI/Time"]

anchor_left = 2
anchor_top = 2
anchor_right = 2
anchor_bottom = 2
margin_left = 64.0
margin_top = -83.0
margin_right = -64.0
margin_bottom = -103.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 0
size_flags_horizontal = 1
size_flags_vertical = 1
toggle_mode = false
enabled_focus_mode = 2
shortcut = null
group = null
text = "2 Minutes"
flat = false
_sections_unfolded = [ "custom_styles" ]

[node name="4" type="Button" parent="MainMenuUI/Time"]

anchor_left = 2
anchor_top = 2
anchor_right = 2
anchor_bottom = 2
margin_left = 64.0
margin_top = -111.0
margin_right = -64.0
margin_bottom = -131.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 0
size_flags_horizontal = 1
size_flags_vertical = 1
toggle_mode = false
enabled_focus_mode = 2
shortcut = null
group = null
text = "4 Minutes"
flat = false
_sections_unfolded = [ "Anchor" ]

[node name="BackFromTime" type="Button" parent="MainMenuUI/Time"]

anchor_left = 2
anchor_top = 2
anchor_right = 2
anchor_bottom = 2
margin_left = 64.0
margin_top = -139.0
margin_right = -64.0
margin_bottom = -159.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 0
size_flags_horizontal = 1
size_flags_vertical = 1
toggle_mode = false
enabled_focus_mode = 2
shortcut = null
group = null
text = "Back"
flat = false
_sections_unfolded = [ "Anchor" ]

[node name="Controls" type="Control" parent="MainMenuUI"]

visible = false
margin_right = 700.0
margin_bottom = 400.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 0
size_flags_horizontal = 1
size_flags_vertical = 1
_sections_unfolded = [ "Margin" ]

[node name="Panel" type="Panel" parent="MainMenuUI/Controls"]

visible = false
anchor_left = 2
anchor_top = 2
anchor_right = 2
anchor_bottom = 2
margin_left = 154.0
margin_top = 69.0
margin_right = -155.0
margin_bottom = 29.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 0
size_flags_horizontal = 1
size_flags_vertical = 1
_sections_unfolded = [ "Margin" ]

[node name="Label" type="Label" parent="MainMenuUI/Controls/Panel"]

anchor_left = 2
anchor_top = 2
anchor_right = 2
anchor_bottom = 2
margin_left = 300.0
margin_top = 9.0
margin_right = -300.0
margin_bottom = -8.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 2
size_flags_horizontal = 1
size_flags_vertical = 4
custom_fonts/font = ExtResource( 8 )
text = "Player 1 - Press Left Key"
align = 1
percent_visible = 1.0
lines_skipped = 0
max_lines_visible = -1
_sections_unfolded = [ "Margin", "custom_fonts" ]

[node name="Controls" type="Control" parent="MainMenuUI/Controls"]

margin_right = 700.0
margin_bottom = 400.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 0
size_flags_horizontal = 1
size_flags_vertical = 1
_sections_unfolded = [ "Margin" ]

[node name="Player 1" type="Button" parent="MainMenuUI/Controls/Controls"]

anchor_left = 2
anchor_top = 2
anchor_right = 2
anchor_bottom = 2
margin_left = 64.0
margin_top = -24.0
margin_right = -64.0
margin_bottom = -44.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 0
size_flags_horizontal = 1
size_flags_vertical = 1
toggle_mode = false
enabled_focus_mode = 2
shortcut = null
group = null
text = "Player 1"
flat = false
_sections_unfolded = [ "Margin", "custom_styles" ]

[node name="Player 2" type="Button" parent="MainMenuUI/Controls/Controls"]

anchor_left = 2
anchor_top = 2
anchor_right = 2
anchor_bottom = 2
margin_left = 64.0
margin_top = -52.0
margin_right = -64.0
margin_bottom = -72.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 0
size_flags_horizontal = 1
size_flags_vertical = 1
toggle_mode = false
enabled_focus_mode = 2
shortcut = null
group = null
text = "Player 2"
flat = false
_sections_unfolded = [ "custom_styles" ]

[node name="Player 3" type="Button" parent="MainMenuUI/Controls/Controls"]

anchor_left = 2
anchor_top = 2
anchor_right = 2
anchor_bottom = 2
margin_left = 64.0
margin_top = -80.0
margin_right = -64.0
margin_bottom = -100.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 0
size_flags_horizontal = 1
size_flags_vertical = 1
toggle_mode = false
enabled_focus_mode = 2
shortcut = null
group = null
text = "Player 3"
flat = false
_sections_unfolded = [ "Anchor" ]

[node name="Player 4" type="Button" parent="MainMenuUI/Controls/Controls"]

anchor_left = 2
anchor_top = 2
anchor_right = 2
anchor_bottom = 2
margin_left = 64.0
margin_top = -108.0
margin_right = -64.0
margin_bottom = -128.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 0
size_flags_horizontal = 1
size_flags_vertical = 1
toggle_mode = false
enabled_focus_mode = 2
shortcut = null
group = null
text = "Player 4"
flat = false
_sections_unfolded = [ "Anchor" ]

[node name="Back" type="Button" parent="MainMenuUI/Controls/Controls"]

anchor_left = 2
anchor_top = 2
anchor_right = 2
anchor_bottom = 2
margin_left = 64.0
margin_top = -138.0
margin_right = -64.0
margin_bottom = -158.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 0
size_flags_horizontal = 1
size_flags_vertical = 1
toggle_mode = false
enabled_focus_mode = 2
shortcut = null
group = null
text = "Back"
flat = false
_sections_unfolded = [ "Anchor" ]

[node name="GameOverUI" type="Control" parent="."]

editor/display_folded = true
visible = false
margin_right = 700.0
margin_bottom = 400.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 0
size_flags_horizontal = 1
size_flags_vertical = 1
_sections_unfolded = [ "Margin" ]

[node name="Panel" type="Panel" parent="GameOverUI"]

anchor_left = 2
anchor_top = 2
anchor_right = 2
anchor_bottom = 2
margin_left = 100.0
margin_top = 53.0
margin_right = -100.0
margin_bottom = 13.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 0
size_flags_horizontal = 1
size_flags_vertical = 1
_sections_unfolded = [ "Margin" ]

[node name="Label" type="Label" parent="GameOverUI/Panel"]

anchor_left = 2
anchor_top = 2
anchor_right = 2
anchor_bottom = 2
margin_left = 300.0
margin_top = 10.0
margin_right = -300.0
margin_bottom = -7.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 2
size_flags_horizontal = 1
size_flags_vertical = 4
custom_fonts/font = ExtResource( 8 )
text = "BLUE WIN"
align = 1
percent_visible = 1.0
lines_skipped = 0
max_lines_visible = -1
_sections_unfolded = [ "Margin", "custom_fonts" ]

[node name="GoToMainMenu" type="Button" parent="GameOverUI"]

anchor_left = 2
anchor_top = 2
anchor_right = 2
anchor_bottom = 2
margin_left = 64.0
margin_top = -120.0
margin_right = -64.0
margin_bottom = -140.0
rect_pivot_offset = Vector2( 0, 0 )
rect_clip_content = false
mouse_filter = 0
size_flags_horizontal = 1
size_flags_vertical = 1
toggle_mode = false
enabled_focus_mode = 2
shortcut = null
group = null
text = "Back"
flat = false
_sections_unfolded = [ "Anchor", "Grow Direction", "Margin" ]

[node name="bgm" type="AudioStreamPlayer" parent="."]

stream = ExtResource( 11 )
volume_db = 0.0
autoplay = true
mix_target = 0
bus = "Master"

[connection signal="button_up" from="MainMenuUI/PlayMode/SinglePlayer" to="MainMenuUI" method="_on_SinglePlayer_button_up"]

[connection signal="button_up" from="MainMenuUI/PlayMode/2 Player" to="MainMenuUI" method="_on_2_Player_button_up"]

[connection signal="button_up" from="MainMenuUI/PlayMode/3 Player" to="MainMenuUI" method="_on_3_Player_button_up"]

[connection signal="button_up" from="MainMenuUI/PlayMode/4 Player" to="MainMenuUI" method="_on_4_Player_button_up"]

[connection signal="button_up" from="MainMenuUI/PlayMode/Controls" to="MainMenuUI" method="_on_Controls_button_up"]

[connection signal="button_up" from="MainMenuUI/Select Bot/No Bot" to="MainMenuUI" method="_on_No_Bot_button_up"]

[connection signal="button_up" from="MainMenuUI/Select Bot/1 Bot" to="MainMenuUI" method="_on_1_Bot_button_up"]

[connection signal="button_up" from="MainMenuUI/Select Bot/2 Bots" to="MainMenuUI" method="_on_2_Bots_button_up"]

[connection signal="button_up" from="MainMenuUI/Select Bot/3 Bots" to="MainMenuUI" method="_on_3_Bots_button_up"]

[connection signal="button_up" from="MainMenuUI/Select Bot/BackFromBot" to="MainMenuUI" method="_on_BackFromBot_button_up"]

[connection signal="button_up" from="MainMenuUI/Time/1" to="MainMenuUI" method="_on_1_button_up"]

[connection signal="button_up" from="MainMenuUI/Time/2" to="MainMenuUI" method="_on_2_button_up"]

[connection signal="button_up" from="MainMenuUI/Time/4" to="MainMenuUI" method="_on_4_button_up"]

[connection signal="button_up" from="MainMenuUI/Time/BackFromTime" to="MainMenuUI" method="_on_BackFromTime_button_up"]

[connection signal="button_up" from="MainMenuUI/Controls/Controls/Player 1" to="MainMenuUI" method="_on_Player_1_button_up"]

[connection signal="button_up" from="MainMenuUI/Controls/Controls/Player 2" to="MainMenuUI" method="_on_Player_2_button_up"]

[connection signal="button_up" from="MainMenuUI/Controls/Controls/Player 3" to="MainMenuUI" method="_on_Player_3_button_up"]

[connection signal="button_up" from="MainMenuUI/Controls/Controls/Player 4" to="MainMenuUI" method="_on_Player_4_button_up"]

[connection signal="button_up" from="MainMenuUI/Controls/Controls/Back" to="MainMenuUI" method="_on_Back_button_up"]

[connection signal="button_up" from="GameOverUI/GoToMainMenu" to="MainMenuUI" method="_on_GoToMainMenu_button_up"]


  RSRC                     AudioStreamSample                                                                 
      resource_local_to_scene    resource_name    format 
   loop_mode    loop_begin 	   loop_end 	   mix_rate    stereo    data    script        
   local://1          AudioStreamSample       (             (              (              (              (   D�                      5                  ��zu�o8j�dV_�YtTO�IKD�>s94�./)�#W��e��1���c����2�9���v�δ�Q�񽑸0�\� ���G�ꘐ�3�و|�J��~%y�sin
i�cO^�X�S[N I�CO>�8�3F.�(�#�+��1	���8�����V�߸�l���Ɂ�4�j�!�֯��D�����k�"�z�5��[`�{pv%q�k�fGa\�V�QDL�F�Ar<+7�1�,�'W"��T�����p�5�����H������ğ�h�0���Ū��X�����Q� ��D@I|w�q�l{gHb]�W�RyMFH;C>�8�3~.N)!$�����
\2 	����������{�U�/��������س����u�W�7����يX�<�`�{kvIq&lg�a�\�W�R}MaHCC$>9�3/�)�$���mT>ub�M�9�%��������1�!�����ԵŰ��2�%�������郋��~�y�tuoij\eO`C[QVIQ@L7G.B%=83.=):$50-*%# o�p�q�r�s�t�u�v�y�����������������������̏׊�쀶�z�u�p�k�f�a�\�WS#N-I:DE?Q:^5k0w+�&�!��� 	0B������������%�9�O�������8�R�m���$�B�`�~�����ي����_A{]vwq�l�g�b�]Y:TXOxJ�E�@�;�62l-�(�#��Dh��&�N�v�������D��� �,�ZȆô�������J�|���ߓ�C�
�@�^�z�u�plGg�b�]�XTPO�J�E�@<{7�2�- )W$���u��'b������Q���'�gݦ���%�dʥ�U���ܷ�d����/�r�B���Ѝ�`���h}�x�s5ozj�eaI\�W�RNI�D@X;�6�15-~(�#J��1~����U�����J����>���IП���I���J��r�˦%�~�٘1���t�ц-�T_�zDv�q�lHh�c_cZ�UQrL�G'C�>:d5�0!,'�"<�9��`�%���:����m���9ޟ��n�=̥��y��O���%�
�x��T�ĕ2�����M �|�w^s�n4j�ea�\�WhS�NFJ�E$A�<,8�3/�*�%j!��w�
e�S���A�
��� �y���n���d�E���Bÿ�=���<�����3���8���=���B�Q�#��} y�t�o}k�f�b^�YU�PL�GC�>K:�5X1�,e(�#s1�F�Z	�n ����]���y���#ݲ؞�/���S���u������4�ɨ^�󟈛���ώh� ����}uyu�p6l�g`c�^�Z!V�QLM I�D2@�;d7�2�.a*�%�!5�n��'��h����J������'���n�Ϸ�\�h����]����T����țt��Ɏu� �ԡ�}\yu�pQl�g�cZ_[�V[RN�I\EA�<�824�/�+?'�"��4��I	�� b�\����|�2���ެ�f���͐�J����ผ�X��Ч��J��@� ����?����}?y�t�prl.h�c�_d[7W�R�NtJ4F�A�=s9\51�,�(g$* ���s9 ���T�d�-������U������Ш�u�A��ݻ�㳳���U�%���ǚ�撹���`��R}"y�t�p�lah0d`�[�W�S\O/KG�B�>�:x6M2$.�)�%�!�f?��� �����\�9����������ӣτ�e�FÊ�m�O�4����ަâ���ϒ������}�yjuLq/mie�`�\�X�T�PeLKHQD:@#<8�3�/�+�'�#���{hTm_�M�>�,��Y�K�>�0�#���U�J�@�6�*�!���m�g�_�W�Q�J�D�����������$^�y�u�q�m�i�e�a�]�Y�U�Q�M�I�E�A�=�9�5�1�-�)�%�!������	�"�%�)�-�3�7���ޜڤ֪Ҳι��&�2�<�F�O�[�Ыܧ����������Èӄ��z�v�r�n�j�fc_[=WJSZOhKwG�C�?�;�7�3�/,(0$D ������Vn�����������J�d�ޘڴ�����]�zǗ÷�Ի������Ө���4�U���/�R�u���|$xDtcp�l�h�d�`]1YRUsQ�M�I�EB>>c:�6�2�.�*G'm#���4���>�i����/�\�����ې����� �Pȁİ�>�p���ֱ�=�o��B�x�����N���2�fcz�v�r�n3kfg�c�_\6XkT�P�L"IZE�A�=�9W6�2�.+='w#�W��
I	��=�{�����8����A�����H��� �dʨ���0�v��^����4�|�¡s����Q���勢��i>�yvIr�n�j$glc�_�[DX�T�P3MI�EB_>�:7b3�/�+I(�$!`� O��
u� n����e���P����Oߥ��מ���Mͥ���T��_����n�Ǭ#��=�����S����ی:���Iz]v�rook�g&d�`�\IY�UR_N�JGwC�?Q<�85q1�-W*�&#�D�;�
i�4���;���	�p���A���Y���-ؖ� �k�'ʓ� �m�ػE��|��Z�ɦ8���}��_�БA�����m��{xxt�pRm�i6f�b_�[�WvT�PXM�I<F�B?�;#8�4
1}-�)�&#y�g�T�v
�h��Z��������v����2ݯ�-֪�(���u���t���u���гR�լW�ڥ\�B�țL�єU�ڍˊS���zsw�srp�l}i f�b_�[X�T$Q�M,J�F5C�?]<�8l5�1z.%+�'8$� J���.�E���%���A���]�+��K���l�����j��Ύ�"ȴ�H�-�úW�볁�����6�Οd�������*�ċ^����{&x�tPq�mzjg�cF`�\sY	V�RLO�K~HE�AI>�:�764�0l-*�&f# �?�zG��%�h�@�����%���j�K����8��ف�n�л�a�Ʈ�U�N�����I�򮙫��J�󡞞J������\�	�����|z$w�srpm�itf c�_r\Y�U�R1O�K�H5E�A�>X;8�4b1.�*�'D$� �U��I�	�bI  ���j������|�3����X�U���Ҁ�9����Ŵ�n�)�渡���n�+�訧�d�~�=�����{�<�`�!��]\2x�t�qgn$k�g�dZa#^�Z�W]TQ�M�JoG0D�@�=r:N74�0�-Y*'$� �Q���[
"�� ��s�<������g�1����ݓڡ�n�:���ʡǹĊ�X�&���Ŵ籷���X�*���&���͘��q�F�{�O�$�(\�w�t�qnn=kh�d�a�^Z[,X�T�Q�N�K[H/EB�>�;�8o5F2/�+�(�%�"oF����	_jF !�����������a�?��9�����Է��ξ˞Ȁ�b�D�q�U�7������ ��ɠ����ԗ������p�X���!zw�s�p�m�jsgWd;a!^[�W�T�Q�N�K�HoEUB=?$<96�2�/�,�)�&�#� �nZn\H5#.�������� ����������������׽ԯ��������Ź­���۶гǰ��������9�2�+�&� ��s�n��UxIuBr9o.l%ifc`]Z�V�S�P�M�J�G�D�A�>�;�8�5�2�/�,�)�&�#� <=	>?B D�w�z�}���������������!�'�.�5΀ˇȐŘ¡��������%��������������*�7�F�R�a�͈n�3y<vEsQpZmejogxd�a�^�[�X�U�R�O�L�IGD'AK>Z;k8y5�2�/�,�)�&�#!>Pcu����	 Vn����������&�?�W�n��������%�>Әг������f�����׶��]�{�����֥F�f�����Ɨ<�^�~����N[ w:tVqrn�k�h�e�b`+]UZsW�T�Q�NL%IFFhC�@�=�:8'5K2m/�,�)�&$?!����m��
�
2�������-�����	�3�������I�t����<�jʗ�	�7�g���ƹ>�o���Ѯ�4�����J�~��9�m���֍a���F �wuQr�o�l�igBd}a�^�[YDV�S�P�M KSH�E�B@9=n:�7�4(2^/�,�)"'Y$�!�^��
D��X� ��:�u�����-�����W���K݋���Շ���	�Jʌ��R�׼����+�p���E���Ϥ�[���7�~�Ŕ�U��9���yIv�s�pnXk�h�e+cp`�]�ZIX�U�RPdM�JHJE�B�?7=�:�75[2�/
-S*�'�$4"��8��B��*
w�>����+�����J����n����d��@ݓ���8Ս��p����n��Z����\���O�����W���P����\��]����m��u�Љ�xbu�rpfm�jhoe�b`w]�Z2X�U�R>P�M K[H�EC~@�=7;�8�5d3�0.{+�(S&�#!n�L�m�S�	x�g���+��������K������u���B���E֭��y�̆���Vľ�g�ϼ9������%�����h������`�̛���`�Α����j�1�xyu�rKp�mk�h�ebc�`8^�[Y�V�S^Q�NFL�I G�DB}?�<Y:�7N5�2.0�-+�(&}#� ~�d�I�R�:
�J�4 ��!���7���%��A��0��"���Fݿ�7���c���V��ˆ��}���v�0���)���%��b��_�ަ��"���!��l��m��?���H �vFt�q?o�l8j�g7e�b2`�]9[�X6V�SAQ�NBL�ICG�DUB�?X=�:p8�5u3�0�.,�) '�$F"�N�Y ��<�	L�[ �����/���n�������Q���h�%޳�@���X�ҩ�6���R�Ʃ�8�Ǿ��$���D�ղ��7�ȫ[����T��z�U��{�����������w�t4r�oRm�jvhf�c)a�^S\�YwWU�R:P�M`K I�F(D�AR?�<�:#8�5d3�0�.&,�)m'%�"4 ���M�9�
n,�b ���^�����2����5����<���y���ۈ�&��Ԝ�=���~���ƚ�=�ݿ��_����I�)�ίr������G�롒�|�#�ɘo�����U�����
w�tMr�o�m9k�h~f(d�ao_]�ZgXV�SVQO�LUJ�G�EZC A�>O<:�7\53�0m.,�)j'-%�"� .��N��r�y	I��S �����6�����n����~�]���o�P�ܷ�i��Ӵ�h��ʸ�n�#��ž{�1��ص��F���򬪪b��ңʡ��<���򘬖f�"�"�܍��H��vctr�o�m;k�h�f_db�_�]A[�X�VrT*R�O�MbKI�F�DYB@�=�;V97�4�2Y0.�+�)L'"%�"� [4��oL��K
.��oU��������G�
����|�@�����}�C�����׆�M����̘�`�\�$�������|�F���۲��n�9�?�
�֥����v�D���ꖷ�����d�1����v]t$r�o�m�kJig�d�bt`@^	\�Y�WqU=SQ�N�LxJDHF�C�A�?d=1;�8�6�4~2M0.�+�)�'q%A#+!����]. ���j	\1� ����y�N�$��������v�K�#�%����ެܲڋ�b�;������˫ɷǒ�m�H�W�2�����ٴ��������d�A�Z�9������ҙ��������r�Q�v�K u�r�p�n�lejFh!f�c�a�_�]w[TY;WU�R�P�N�L|J[HHF(DB�?�=�;�9y7\5N311/�,�*�(�&�$�"r W:8������	�hNV>�&��� ��������������j�}�h�R�=�T�A�-��3� ���������� ��ݻ̹��ߵγ����ԭī����Х������ҝ����ؕʓ�����؋M �t�r�p�ntlgjUhDf2d&b`^�[�Y�W�U�S�Q�O�M�K�I}GoE`CbAT?I=J;?937'5-3"1/
-+
) '�$#� �����������
����� �������������� �������6�4�0�.�U�S�Q�O�z�z�x�vͥ˥ɥǣ�����ֿ�
�
��C�E�G�I���������Ŧɤ͢Ѡ����_�c�i�n��������:�s�q�o�m�k�i�g�e�c�a�_�]�[�Y�W	VTRP#N&L*J0HBFFDKBQ@e>k<p:v8�6�4�2�0�.�,�*�(�&�$#"!)3=^js}�����	�*8D R�������������� �2�@�O�_��������
��T�f�wԉ���������:�M�_�rõ�ȿܽ �5�I�\�����Ͱ�,�B�Y�n���ң�7�N�f�}�͘����i��������W;sNqboum�k�i�g�e�c�a`!^6\KZgX~V�T�R�P�N�LK/IGG^E�C�A�?�=�;:$8M6g4�2�0�.�,�*)E'`%{#�!�� 2Om����1Pm	���# b��������!�B�������+�L�o�������gۭ݊����A�d҉�����!�pɕǼ���3�Z���ռ��#�J���ʳ��s���ê�H�p�����"�L�u�ך�,�������u���e:s9q^o�m�k�i�gfIdpb�`�^�\[=YmW�U�S�QPBNkL�J�H�FETCA�?�=<8:e8�6�4�2$1b/�-�+�)((U&�$�"� "f���:i��Aq�	�O�� �Q�������9�n�����&�[�����N�����Fߟ���
�h؞���	�iџ���7�oʨ���B�zó��P���ú*�c���سA�{���!�[���ҧA�{���&�c���ܛN���ɖ<�z�����l����s6rnp�n�lkRi�g�ed:bt`�^�\'[jY�W�UT]R�P�NMVK�I�GFSD�B�@?T=�;�98[6�4�2%1u/�-�+4*�(�&%Z#�!�r��L��m��N�	�2v�� _�����J������~����o����B����9����2ߝ���/�w���.�v���/�y���4�~���=Ƈ���H���ݽ)����:�����L����a���+�y�ǦF����1����Q�ԙ$�s���H����o���s^q�o�m>l�j�h"gqe�c	bY`�^�\?[�Y�W.V�T�RQsO�ML_J�HGVE�CBQ@�>�<L;�9�7M6�4�2N1�/.U,�*�(\'�%$g"� u�p�/��D�Z�	t�"���A����c���-�����S���}���.���\��0����bܽ�ٗ���NԪ�*ц���d���ɡ���\���>��������>�ȷ%����n�ίZ����z�
�j�ˤ[�������r��f�ɖ*���$����^��r%q�o�m@l�j�hXg�edvb�`7_�]�[[Z�X WU�S@R�POjM�K4J�H GbE�C0B�@�>d=�;(:�8�6`5�362�0�.q-�+:*�('y%�#U"�  � e�G�(��s�D�
+	��|�N��;���(���������W���I��<�����	�t���n���F���Aܮ�<٫�֨�ӄ�Ѕ��̈���f���k���J���Q�½Z�˺<�ַG���S�ı7�ӮF���V�ɨ<���N���6�؟J���a�֙J��c�ؓ���i�ɪBr�p"o�mlrj�hTg�e8d�ba�_ ^p\�ZZY�WDV�T)S�QP�NMwK�IgH�FNE�C@B�@5?�=<�:9�76�4�2}1�/i.�,f+�)S(�&R%�#S"� C�F�I�:�A�I�=�H
�R�I�X��h���_���q�����������*��C���@���Z���x���u�ە�ض�6շ�X���Y���� ˂�%Ȩ�*���R���|� ���,���1�ܶa�㳑����G�ˬO��������=�ât�����4���A���|����@�Ƒ}���U�po�ml�j%i�g*f�d3c�a>`�^E]�[QZ�X^W�UiT�RwQ�O�NM�K#J�H/G�EDD�BZA�?i>�<�;	:�8%7�5B4�2R1�/p.�,�+*�(;'�%O$�"s!��$�K�` ��B�m��
)	�Y�s� 4���h�����+���a����(��I������O������^��ޟ�1���r�ؖ�J���n�#ѵ�I��̐�$���m� Ʒ�M�����.�½}��̹b�����I�ಝ�3�ɮ�� ���t����e�����U��J�㛦�@�ڗ��8�ғ��2�̏�npo�m*l�jTi�g~fe�cDb�`o_^�\5[�YeX�V�U.T�RdQ�O�N1M�KiJ I�G:F�DjCB�@??�=z<;�9S8�6�5,4�2m1	0�.L-�+�*+)�'r&%�#U"� �:��#�m�Z��G��7�	�'�|�p ���j�	���b����^� ��Z����Z����\���^����d�#���l�,���s�6��՞�B��Ѭ�Q��ͻ�a����r�;��Ĉ�P�����h������(�󷜶D����a�/�ٮ��P���ȩq������B����i�;�朸�d��嗑�<����k�A��T�o,n�l{k!j�hogf�dhcb�`b_	^�\^[Z�X\W	V�T\SR�P^ON�LhKJ�HmGF�DwC!B�@�?,>�<�;8:�8�7H6�4�3c21�/v.$-�+�*9)�'�&P%$�"j!& ��B��a��C��d��:
��a'��P ��~�/�����^�(�����Y������?�����B�����z�/�����:�����v�-� ٵ׉�@����҂�9���͚�S�
��ș�R�*��û�t�-������U��긥�^�:���Ӳ��I�&�᭜�|�7��ԧ��p�-��ʡ��k�'��ț��i�'��ʕ��n�-��>8o�m�lEk�i�hog*f�d�cYba�_�^C]\�ZyY4X�V�UkT)S�Q�PbON�L�KWJI�G�FXED�B�AS@?�=�<\;:�8�7g6%5�3�2m1,0�.�-�,A+ *�(�'Y&%�#�"h!6 ���I��n/���Y��uK
	��lB�� g�?������g�A������k�1�����v�;������L�,������b�D�
��ܵ�}�_�'���՜Ԃ�J�0����Ω�s�Y�$����Ǡƈ�R���������S�=�	�������y�F�3� �̱����u�D�� �Ω����Z�K���ڡ����l�_�-����������U�J���p �n�m_l)k�i�h�gUf"e�c�b�aS`"_�]�\�[UZ%Y�W�V�U]T-S�Q�P�OiN=M	L�J�IzHPGF�D�C�BhA8@?�=�<�;U:/9�7�6�5x4R3$2�0�/�.}-O,++�)�(�'~&\%.$#�!� �eG����W;���S'�
�	��Y/��� ��l�B�+����������]�I�!��������o�J�"��������z�T�F� �����ܷۓڄ�`�:�-�	������ѪЄ�{�W�L�(�"������ƯŦĄ�`�[�7�2��	��ź¹����y�v�V�4�1����έͬ��������m�L�M�-�0����՞؝����������g�l�M�T�6�=��n�mglCk!j�h�g�f�erdPc0ba�_�^�]�\h[IZ'Y	X�V�U�T�SmRJQ0PO�M�L�K�JyI_H?G!FE�C�B�A�@y?[>E=$<;�9�8�7�6�5m4X3<2'10�.�-�,�+�*})a(P'4&%$�"�!� ��{mRF)������wnT<1
	�������~ x�b�[�E�,�'����������������z�w�c�L�K�7�6�"�#����������������۰ڵ٠؎ב�~Ճ�p�u�c�h�U�C�J�9�@�-�6�$�,��	���
���������ݻ�ڹ�ַ�ҵ޴г��α��ί��έ��Ϋ��������Ŧ��ɤ��͢��Ѡğ��ʝ��қŚڙ͘�Ֆȕޔғh��m�l�k�j�irhbgOfAe.d cb a�_�^�]�\�[�Z�Y�XyWkV^UOTES4R)QPON�L�K�J�I�H�G�F�E�D�C�BwAr@d?_>R=K<?;<:/9#87654 3�1�0�/�.�-�,�+�*�)�(�'�&�%�$�#�"�!� ����{~uxotlphnf_d]d[d[
d	]d]f_Zc\g a�l�g�q�k�w�r�}�x�����{��������������������������������� ���%�"�6�5�J�I�F�\�[�o�nхЄϜΛͲ̳�����������������/�0�J�K�f�g�������������ܶߵ������!�?�B�b�e���������˨Χ����:�?�a�f�k���������ޚ���2�7�]�b�]��l�k�j�i�h�g�f�e�d�c�b�a�`�_�^�]�\�[�Z�Y�X�W�V�U�T�S�R�Q QP
ONML K#J+I0H3G<FAEIDNCYB^Ai@m?x>}=�<�;�:�9�8�7�6�5�4�3�2�1�00/.%-,,=+D*T)[(l't&�%�$�#�"�!� ���� 1:PYmv��������4
=	Wbz������ ����8�E�a�n���������������1�@�^�k������������"�D�R�r����������9�H�l�z۞گ�������>�N�tӅҫѻ������,�R�eˍʝ�������<�N�xËµ�����/�D�n�������� �,�A�n�����ò��5�J�w�����ҫ ��F�\�����ҥ��.�`�v�������<�R�����Й��2�h�����&l9kIj\inhg�f�e�d�c�b�aa`+_>^R]g\{[�Z�Y�X�W�V�UU$T7SORdQ|P�O�N�M�L�KKJ3IMHbG|F�E�D�C�B�AA&@A?W>u=�<�;�:�9�88'7F6^5|4�3�2�1�0	0"/B.Z-z,�+�*�)�(()'B&d%~$�#�"�!�  3W}����:Tz����A[����3O
w	���"Kh��� ��%�A�m������� �.�L�z��������0�`�~������+�J�y�������;�k������.�b�����	�;�]ݑܳ����<�^ؒ״����A�vӘ�����'�KρΥ�����6�oʒ�����&�JƄŨ����?�c���ؿ��7�]��������Y������Y����� �F�������M��������[���§�)�Q�������;�c���Ο�9�z�����R������*�o�2�$kFjji�h�g�f�ee@ddc�b�a�`�__B^h]�\�[�Z�Y$YIXoW�V�U�TT3S[R�Q�P�O�N#NIMrL�K�J�II<HhG�F�E�DD9CaB�A�@�??6>d=�<�;�::99i8�7�6�55H4o3�2�1�0*0T/�.�-�,	,;+e*�)�(�'''Q&�%�$�##B"u!� � 4`���,X���T���R���V���
#
\	���,Z���:h� ���?�z�����#�R�������:�j������F������3�e�����V������8�j�����a�����I��� �2�wީ���1�cۨ����Rؗ����UՉ����IҐ���
�>υθ��I�|�����BɋȾ��=ƆŻ��OÅ����N���Ͼ�O���һ�h����"�n����>�u�³��G���Ͱ�S���ڭ&�u�����5���ը�]����!�o�����J���נ'�a����@���̛�X����9���Q�Djyi�h�ggMf�e�d�c"cYb�a�`�_1_i^�]�\\C[zZ�Y�X!XXW�V�U U8TqS�R�QQSP�O�N N;MrL�K�J!J^I�H�G
GFF�E�D�C1CnB�A�@#@\?�>�==O<�;�::A9�8�7�6:6u5�4�3/3p2�1�0&0j/�.�-'-c,�+�*#*f)�(�'''e&�%�$($l#�"�!)!n ��4{��;��K��T��"i��.w��G��W
�	�*u� J��a�� 8 x����Q�����,�y����V�����%�t����S����4�u����V����9�����n���F����,�}����f����P�����+�~����kۿ��Wٜ���F׋���6�{����l����^У���PΗ���Ě���)ʂ��� �x����pŷ��kò�
�e����a����J��� �H�����F����H����H�����J����M�����Q�����W��� �J����Q����Y����e�ä�n�Ϣ�z�ܠ'���Ӟ5����E����T����f�� �h6h{g�f	fNe�d�c$ckb�a�`@`�_�^^^]�\�[7[�Z�YY[X�W�V6V}U�TTZS�R�Q7Q�P�OOcN�M�LDL�K�J$JmI�HHRG�F�E5E�D�CCiB�AAO@�?�>8>�=�<#<m;�::X9�8�7C7�6�5/5�4�33p2�11_0�/�.O.�-�,B,�+�*4*�)�(((u'�&&l%�$$b#�""Z!� �R��L��G��C��A��?��=��?��?RSRC   [remap]

importer="wav"
type="AudioStreamSample"
path="res://.import/arrow.wav-21566a48b0eeffd590c8c29224c4a97f.sample"

[params]

force/8_bit=false
force/mono=false
force/max_rate=false
force/max_rate_hz=44100
edit/trim=true
edit/normalize=true
edit/loop=false
compress/mode=0
          GDST                �   PNG �PNG

   IHDR           szz�   aIDATX�c`#0⒘�v�jZ���.����n�o��JM�.\ڍ����#�hb	`��u��F0�Q�:`���Q��j: W�|� t',�]    IEND�B`�      [remap]

importer="texture"
type="StreamTexture"
path="res://.import/button.png-234620e182281afdeb4aab4d2ed4f8a7.stex"

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/normal_map=0
flags/repeat=0
flags/filter=true
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
stream=false
size_limit=0
detect_3d=true
  [gd_resource type="Environment" load_steps=2 format=2]

[sub_resource type="ProceduralSky" id=1]

radiance_size = 4
sky_top_color = Color( 0.0470588, 0.454902, 0.976471, 1 )
sky_horizon_color = Color( 0.556863, 0.823529, 0.909804, 1 )
sky_curve = 0.25
sky_energy = 1.0
ground_bottom_color = Color( 0.101961, 0.145098, 0.188235, 1 )
ground_horizon_color = Color( 0.482353, 0.788235, 0.952941, 1 )
ground_curve = 0.01
ground_energy = 1.0
sun_color = Color( 1, 1, 1, 1 )
sun_latitude = 35.0
sun_longitude = 0.0
sun_angle_min = 1.0
sun_angle_max = 100.0
sun_curve = 0.05
sun_energy = 16.0
texture_size = 2

[resource]

background_mode = 2
background_sky = SubResource( 1 )
background_sky_scale = 1.0
background_color = Color( 0, 0, 0, 1 )
background_energy = 1.0
background_canvas_max_layer = 0
ambient_light_color = Color( 0, 0, 0, 1 )
ambient_light_energy = 1.0
ambient_light_sky_contribution = 1.0
fog_enabled = false
fog_color = Color( 0.5, 0.6, 0.7, 1 )
fog_sun_color = Color( 1, 0.9, 0.7, 1 )
fog_sun_amount = 0.0
fog_depth_enabled = true
fog_depth_begin = 10.0
fog_depth_curve = 1.0
fog_transmit_enabled = false
fog_transmit_curve = 1.0
fog_height_enabled = false
fog_height_min = 0.0
fog_height_max = 100.0
fog_height_curve = 1.0
tonemap_mode = 0
tonemap_exposure = 1.0
tonemap_white = 1.0
auto_exposure_enabled = false
auto_exposure_scale = 0.4
auto_exposure_min_luma = 0.05
auto_exposure_max_luma = 8.0
auto_exposure_speed = 0.5
ss_reflections_enabled = false
ss_reflections_max_steps = 64
ss_reflections_fade_in = 0.15
ss_reflections_fade_out = 2.0
ss_reflections_depth_tolerance = 0.2
ss_reflections_roughness = true
ssao_enabled = false
ssao_radius = 1.0
ssao_intensity = 1.0
ssao_radius2 = 0.0
ssao_intensity2 = 1.0
ssao_bias = 0.01
ssao_light_affect = 0.0
ssao_color = Color( 0, 0, 0, 1 )
ssao_blur = true
dof_blur_far_enabled = false
dof_blur_far_distance = 10.0
dof_blur_far_transition = 5.0
dof_blur_far_amount = 0.1
dof_blur_far_quality = 1
dof_blur_near_enabled = false
dof_blur_near_distance = 2.0
dof_blur_near_transition = 1.0
dof_blur_near_amount = 0.1
dof_blur_near_quality = 1
glow_enabled = false
glow_levels/1 = false
glow_levels/2 = false
glow_levels/3 = true
glow_levels/4 = false
glow_levels/5 = true
glow_levels/6 = false
glow_levels/7 = false
glow_intensity = 0.8
glow_strength = 1.0
glow_bloom = 0.0
glow_blend_mode = 2
glow_hdr_threshold = 1.0
glow_hdr_scale = 2.0
glow_bicubic_upscale = false
adjustment_enabled = false
adjustment_brightness = 1.0
adjustment_contrast = 1.0
adjustment_saturation = 1.0

         GDST�  �           �*  PNG �PNG

   IHDR  �  �   �91    IDATx���_�%�}���U&^�5~ؗ5!-��`�V7���gX̮��w%�-��kEJK�<����"pL�aԖ=ۛ4����1�b�X?H^f<F8�Q0����/�`��M��}�}��������~����{4=U?խ�Uխ*����sX`�a�9,0 ��&���O~�""���}�e�B!"R�����p�������;��~�sx�c�VDD���w�����O=(""?z���,����o""���O�����qS씖BR�(,�BR�(,�BR�(,�BR�(,�BR�(,�BR#,X3�Ψ2$��ò2$��ò2$��ò2$��ò2$��ò2$5��c�Z���PX�
I-��l�ZBa�*$��²UHj	�e���K Sr��+$��òWHj�e���"�^!�E��BR�8,{��FX��;��!�E�ACR�(,���QXI-���ZDa4$5���B�lI�pX���4$5�a9hHj��rА���!�� �b'3jHj��rԐ���!�
�QCR3����f(,GI��0�>;�ICR�0,'Im°�4$�	�rҐ�&�ICR�0,'I��0�.;S!����BR1,M��6bX�
Imİ4�ڈai*$5�@hmv&�CR0,M��6`X�Im��4�ڀai:$���tHj�%�P��D�
I-`XF�Z���*$��aUHj�2����eT!�� ���yD�Z���:$�auHj=�2��z�e�!��˨CR#,t�j��THj-�2���Z�eR!��ˤBRk�I���",�
I��Ж��H:$���L:$���L:$���L:$���L:$���L:$5�@S3�,$5/,E$��Լ��|BR��RD�	I�K�'$5/,E$���K uN�,"�E.a�B�_w������u.a�B�l���ɲ9��.$��KX���� V9<B�*���CR���9��T�R�_�RK?$E��jX�!)R?�T��I��9��~H��z ��}�2հ����P��!�h��eEH6�C*aY���JXV�d�9���$��J��N%,[���TX�I-��l�ZRa�"$��²EHjI�%!	����P��=BR�:,{��uX�I-���Z�a�#$��Ò�J�'���CR�*,��UXI-���ZTa0$���Z����0$5�a9`Hj��r���L��!���CR3��$��tى�
�CR3�#��f*,GI�TX�����1$5SaIHZ��ɤa9aHj���!�M���6iXN�ڤa9aHj��%!	`,!v*������FKC!����BR5,��6jX
Im԰$$�-��eа4�ڠai8$�A��pHj�����K�!���$����	���4,#
I-hXF�Zа�($��aQHjAÒ�0�!w6��2��z�e�!��
ˈCR�����+,#I�WX� �c��*,
I�UX&�Z��L($�Va�PHj��2���Z�%!	��1w>�a�pHj�a�pHj�a�pHj�a�pHj�a�pHj�aIH�j��P����w��a�9,0��� Deʝ���䷃d�a�9,0��  ��sX`�a�9,0                H o&�9岞}�2�\ֳ�\��z�Ŝ�6��(DD��syq��.?#�̩�闿#""�ʧ��S[Ͼr�S!"�?+""O�|�}?���+�9-�����n�������d�]
$-�`j+�9-��p0��˜�IK8���eNK��L���S��V��P0��˜*IK(���eN���%Lm�2��@�2&�d��H[�q0��˜Z�q0��˜Z�q0��˜Z��Q01'$��8{�Q0��˜z�Q0��˜z�Q0��˜z��p01'dc&�I3Lm�2������r�S�@�S[��)h i	sBvf"Rln�˕���H���(!��;�z>���uy��m�"��%$�Sϧ8}i[^���dLm��޿���S��ܗ�W�/&m�����6$�������N�S��˅�>�?�\���b�C���ݚ���"r8�O�˩k�A~�������@sqs����my�dذt��usMv��	�3Ƕus�p=B���ݚ����ك�	}J�꼐Gv�|��=�\���N�o�
K?$S�֣oXZI-TX�!��}��zHj���������CR�~H���G߰$$�cA�t��BR������5,SI�kX��ZװL-$��a[Hj]�2��Ժ�%!�ʗ.�#""��KD��e�!�5˲��s��[�DD�["�<,SI�iX�����U�=uADD>��yi�����4,�BR�٪ϼ�؏}���~�iX��ZӰ,I=g���#�M�2����².$c�4,sI�,,�B26M�2����².$c�4,sI�,,�B�AiP�f3)��6,sIM�eUH����-s]X���˪��y{��\CR�aY�1oua�kHj:,�B2��y���7g���b�,��fS5S몖=����j6�n�~pU�Iu{ೀ�f����T%   P�4(9�>�g�2�"��Ƹ̱�q�1.s,�-bq,(=����%Co������"�r�L�9[������K��.X�j{��7SΖ}��󇟗�=\����	9n���-���o~^2���<����O�q3��XUzQ���W%����᯽���N�ڇD�=j�-���'{��"r;!�J�>w�k�*h�ۃ�n����k�x����W%�Կ9��w����I��?��_�x����W%���/���6�=�!���I��"1)J�O �!���gv�	�XCR�@~Hjò���}�2֐��������}fw���5$�>䇤f0,k���',	IĨ6(��
I��3��>�;��T��c��M���e�Bұ�����y�2U!�X|�w�gv�<b	X4(ۆ�Em�HXVk��y�"aY�mHZ��ъ�e��!iQ�G+�H]��L!$5²�BR#,�K!$5²�BR#,�W.�{��&7.���?<]��3��>��L�YO��۷�������NW�&�����.�v�Sx�鋇�nr��ӗ�e��E���3��>��L�YO�앣}X����ܗ��eKHjm����4��{�YS8J8uϢ�ry�w�gv�Y5�+�5�.p�E������.�j�߾m.*]�],���.vry�w�gv�9>����/��J8.�Ζ<�Z���m��]F���ݻ��{�J��t�rs{�4ۆe*!��=��LU��G+-���^�m�2�����]�*���������"��e*!��=��̪�t�?Zi���rv�TBR�{fw�U!�������g(�86	�����^d��/����v�z�׊�#�M����p	m�;7�7��Q�?��ȯ�G����G�?�ڰusMn�����sU!��#�m���ޛ����y!�����*$�J/�����=$��a���CR����=$��a�;B)8!"��\	�v������U�\	�v������U�\	�v������U�\	�v��$��a�	9z�@�XV}F��ɭ�o��"�������3�VnHn��������3�VnHn��������3�VnHn�?���0a�]m� G$��aV�l.�YqD��f���b���N�����-�vͅ�[:��3����9,�/ʙ��\�xo!2��5K��w��v�#/$�`�LD��۷��Y:m~���h�;�B��������Y:m�s��h�;�B���p����b��k�N�?�;�vG^H� ����{���B��d&"�����>���6JXz!ie.3�S�v���AHj����V�2�9s��>���6JXz!ie.3�Gv�C�%!��T=�{��4�� aaHj������	�CR$,��6HXF�� ai0$�A�D����	���$,I-HXF�Z��L $� aAHjA�2��Ԃ�e!�	KB1��������M�I9�d�ca�?)G���Q�Vn~h�Oʉ0$�K�I9*�������aH�9���rT8f�=���?)',s,,�'�p�i{ )D����/旋�}=�2��b~�(6��S^Ͼ
)���{��)ϩ�b�ܼ�����z�U�Hq��v�us-�9"Rl�\+N_�Ny=�*D����_\���~qu^76y� �����z��˜rYϾr�S.��W.s�e=           r��gDr]�:��%�����\r]�:��%��FBܢ�y���ED�ō�C�l�r]�:���O����W>����\r]�:���7�����<q�e����R�����~_DD~�C��}?�����o������7s]od��ƼTZ��z�Y
*-���u��,���pX.���qX.��p`���P�����P`��u*�JK(�r]�:�!�%��!�e��A�%X��72�f�mTZā��z�iTZā��z�i�Z�a���������N8,[�q`��@���WPiV��]�WPiV��]�WHj����n�NBa�+���+��Um�A�J3X��w��A��\׻NА��e�zwJ'�T����u��c*�rs{_�\\<�>��%$��N��m�����۷E$��%$��N��m�/m��O_�,²Q@�=B��t��m����/g��_�X���7ө��u������� 
}
x~����m�V���X,K��ts����u9
�Ч�����Ե� ?���ss95�z�9����my�dذt!�usMv��	�3�ں�v�\������\���Q�S�W�<�k���_�����Ĥ6(�Pa釤En���ej!��
K?$-r��7,SI-TX�!i�[��a�ZHj���I��r�KB)h�Nװ��ZװL=$��ai=$��a�zHj]��zHj]�2��Ժ����Ժ�%!���J�iX��ZӰ�-$��a[HjM�2��Ԛ�el!�鰬��y.!�5��BRk��$R�*([����2����²GH����@P�V���2����²GH&�=��e�!���p���!$����2����²GHƲ= c~P�=�z�K��GϿ��}�����ò,$���xs���({6���n��oml,}_�e*!��,ɲ9�9�vMo+�ɽ䵧.���'�?��}�����ò,$������~_��_�y��˦��Ϧ^���o?���a�JHj:,�B�lN�7g�� '���r�����f��_.�7����\�2��n�S����@�E�k��\�x�GǾ����爘
�N���
ˍ�~?ТٵusMn������KS^����^|R�����/��y�;��/�\�",a�	�E���f6�IQ�G�rᇤ�M+�O9����/�q�\w$.~H���-��{~N�����ٸu�;�?$�l�H��ϩ���o}��[�#q��C������Sf��֧��|&��!�Y�0�o�"}ʺ�g��k�=\___
I��)�&�	d{8���p�Ҷ�އ��y
��u���=�d{���x`ٱ�r��Ν�'��>�����g5$�1�O���""����Wc,�Ր����o}\DD.������.�X>�!��8�����I��c,!�t�mPQ�����BM��xץ�l�چe���e{p�v�k#O�)[��a��Ќ5����xRN��K��f\�����t�چe����:(�g%_�pO��5�w�����[������ۄ��I.�)u��|�֭�ۃ5�����+�<﮿���6a�f��gJ�g%_{�B��A����j��p������ۄ��I.�)u����K��/t�9��[�ny�����m���$�ϔ"KA�_RwJ��:o���w߿_��\�=�����ƅjny������t��DӐl3���ԝ��òλ/�����x���n_���E��������9
K��M4�6���QH�)Y?,���ODD��KD���O�������-�����[~y��g4�6���QH�)Y?,�|��Ŝ����ׅ�o>k���py�]�_��t��DӐl3k`*3)�+�ܰ���A_�����_}o�����ܲL����,[^g�m��T����&���q�v��6�����<��疾p���s���,[^g�m��T����&�����e��)�m�}/�Ky�ɿ_��Ι;"��Y��Ϊ�թ����M>�
� 7�.�m�Ͽ����������='���wf��:�nT�j��7��CKG(W�>(���eafU��m�欺}P�G
���U!��AH����Am���SfV�\�!iΪ����,̬
��B0��*�!�2'!��N��Q�VO�Z�����h�67V�<�;��G)r��nB��VzQa�O�!�����a�O�!����H�	�<�JX��5$-���:�JX��5$-���:�JX��5$-���:�JX��5$9��N�чz+���r~�p�@�_.dwc1��me����{��O{���ss9�>���tXn�\s�@ٺ���dTۃ˫��]LşM��f�0箶�#���0+�H6�ì8"�\��ds�
�[
JK�]say�N�����-�vͅ�s�u|�����DD�\���蚥�滏�Dߋr(^H������÷o"�]�t��Ե]��������ן�X��wt��i�3wDߋr(^H���^Y�_�ut��i�Gvg��E9/$� PV]�=JXz!i�2�}|V��`aAHj����V�29um����2���F	K/$��e&"�s�N!"��e!���^HZ��LD�����PaIH"&U��$,��6HXF�� ai0$�A�2�	K�!����6HXIm��$$���t��e!�	�BR���$,I-HXF�Z��L $� aAHjA�D̺l��+e��C��w�!Y�XX���V�g���ۃ����#�2�����
��?4�gyG�e����,o��o~h���0$�K�Y�*s��F
)6�����p_O�LC(D��_.�����׳�BD�����޹y�s*D��;7/������}"R���]l�\KyN��[7׊ӗ�S^Ͼ
)nl�W��_\�ōM�/��ry�䲞}�2�\ֳ�\��z��˜rYOdl��uK������sX�z���r����3ڲ��0���2�,POo|��|��Id�߾��4���B�s�í�b���W���SO��&��a6���ߛz��2�֖p���ԛ�3AD0�氐��b�:*W-�{�,���z��2������� �tx�7 X࿑�""aEР���N�#'8�Lr�C��>1Y(e�3z��;aQ	��˹7��n�|�k��
��f��/GDD>��L����g_��g���9��(�"砘bݿ��3�����m�����+(uH:9��I'���!���:$�C�5*s\g��NAY�ZNaY�Z�aY�Z�aY�ZLayp�ˤWy�͖a����an�E`K��l�Z�a�4$��²iHj)�eӐ�b	K�^�{,�0*b���m���d�7��fo�Vo�5$�|�+���X�Cې,��ɗE$�9t�2/�~]  P��e�tb>b:$�؎X�I'�#��C҉�%  �ʠ*$w�rs{_�\�w��cH����(���/m�'/�Ha9TH:���}9{%��  _�G(���X�Q}�{s{?�ϛ���u��a�~�޹�����g���m��a�N}o�\��3w�����yd��u�T����_ �<U��_^|�oX��Z���C2F���I������aIH R��*�a�rHj]�2��Ժ�e!�uKB ��V�j�9���4,SI�iX��ZӰ$$ ��tc���1\���Y�ea{H��CYX��ZYXv�^  ��|��˲�|��=""����V����{&�Ajݺ%""���X����CR���SDD�ϟ_��˔BR�aY��yi����%�n# �D��t�y��o�.$���]�7Y����@��Q��MV���G�fጻ:/���]��l�� X$(5?$g��E��tY�?e��M��-�u�ߤ�CYX���V��O	 0n��tf��'�mn�G��v_Wi�Ч���UR�CM^76��,�  "Q�/�;��Y  
@IDAT-""O^{}����Z����O���""����WWMB���o}\DD.�������^}a��ԓý.I @,J�҅���mX�v��(�FG�|.$�}��r�t��I����yR�I�u۰��u H[iP����DD�k����6a��4ˮ�N����C�n5��Ή�'�-���g%_{�B�9�t���WC-V0�����o?���h�n.eWw �Ҡ|v�{�������|�����7I�����}���u��������,""'��������y�v|���/���Է�u^y�'""����%"G!��g��?k�����g�yv�pa��7��.����� ��~�҅�����k��^�m���ѯ\��TT�����l�U���s""�܋ψ�ȗ~����94�G��lvqN����|��ED�~r�u�8����}a��k����!����{�J �Y���n�M�
I;��V�>��U�u\XZ���Am�����2&MB��U!)��  �z� �*$��{��W�[P�(�pa����  �e�!���e�$  �eא�r�ۿG�),��q4²��!�io �U���_.dwcq?¦G$-<��-�{~r�{��r*��GjM��r��윱s�Hk��ydw�hzD��� �U��/���v)��#��pz ��т�	+����S�9�:���p� `]�y���g2�<���\HZ<��O��u$��is=���DZ;m���L���y]�����  ��2(��a�����rHjc��I�3+,]HZ��~]��$  6�WZ�1��6TXZIm�����PaIH b��*�PasHj��2���B�e!��
KB ����h�����w�8zN����fھa�Y��ch4�^�U�y�}��MH�0?47>���_�	I�sp�����9z]���� ��V�)�s�A3S�i2���          s8u�>�<����lc\�X0[ ��,o��cG����ӯ>����/�����g�j�/�@>������?�à?Oc{N���|��B��M��?�CS���g���\!<�>�Mٓ?	ֱ=��� ��P1�;��_�I���,϶�{DjE8��,+DG�D�����2�)o���Ŵ= �H�Ie�h�e+1̶w@�M4�j{(c=(��a{ ���;�^;3�4*�4���M�
���t�JŴ= ��]]��;���?���n�X��FO���7�>o}��L�m� �C����z{ `_�#��?��gyb��D�=vDJ�x�zJ�������  #A>CIXvsH:�ᖋm����C�ܧ
J���R� d��m�f""�>��EX���E�[�Ly�N�yH���5�6�A�+��1�=L����?X� �+��u�#��;�	�K�����eH1$�HU,G�Wz{X9���P���GX�?L�= �Ƞ�`�M���w�T��/K�!���q��",����~����7�=X�GX�?��= ���;�A�4V�|��S��mI_�Sz����a1�)_ۃ�}���C�!0��v&A�4V��}E�}��S�d,R�G� ��I>�>ěF*A��E�aIHv��>���,L�3
��{P�Ff�Ps�l��"l�`�A�� ���wJ��4bJ�(��M�c*�1���� d��Ω���X���)Zk�Do�����b�G� ���wR�+kP:�q�ZdX*�1���� da��P���z�A���Qj���D�S*�1�T�� da�B��"���%��?/��J*��T� *Mz�r S>�;4�0��T^W��                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       ����-��$�F    IEND�B`�           [remap]

importer="texture"
type="StreamTexture"
path="res://.import/design.png-17e10c0f51ed03ca190409b2c58f0fa9.stex"

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/normal_map=0
flags/repeat=0
flags/filter=false
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
stream=false
size_limit=0
detect_3d=true
 [gd_resource type="DynamicFont" load_steps=2 format=2]

[ext_resource path="res://VCR_OSD_MONO_1.001.ttf" type="DynamicFontData" id=1]

[resource]

size = 19
use_mipmaps = false
use_filter = false
font_data = ExtResource( 1 )
_sections_unfolded = [ "Extra Spacing", "Font", "Font/fallback", "Settings" ]

               [gd_resource type="DynamicFont" load_steps=2 format=2]

[ext_resource path="res://VCR_OSD_MONO_1.001.ttf" type="DynamicFontData" id=1]

[resource]

size = 37
use_mipmaps = false
use_filter = false
font_data = ExtResource( 1 )
_sections_unfolded = [ "Extra Spacing", "Font", "Settings" ]

GDST@   @           \  PNG �PNG

   IHDR   @   @   �iq�  IDATx�횱NA��5�g GeiEam�X`bAH���|�L	>�������XX[خ�1p�9��ۙ�#ΗP�������aO EQEQEQ���ի6LM׵ p�� �vZ��'�S�]��B��]B���@��.!DHu��ERw���]$D������ �CġoYtK ��r/���b��w".��܈
 ���N@"8�%��H������;}��0 \�~�����*�R��qtU�U?�,1�����,��K�l�eԍ�p�0��0���Z�`������ p����o�2h�]/��Pp�=��)� ��fè��w��o�l���ؽ�"v񱈃�\���^��g��Wt3t�`?qл�y�͍��r�Q��k�!�&��"*Hn~.�$�� ڂskZ�a��I��eh�w����_����AEp.#�*` `>j[@n�'���>���NH�XDH��!Y.��b���Bo
��lol��"�y\�\QEQEQEQ������W��    IEND�B`�        [remap]

importer="texture"
type="StreamTexture"
path="res://.import/icon.png-487276ed1e3a0c39cad0279d744ee560.stex"

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/normal_map=0
flags/repeat=0
flags/filter=true
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
stream=false
size_limit=0
detect_3d=true
    RSRC                     AudioStreamSample                                                                 
      resource_local_to_scene    resource_name    format 
   loop_mode    loop_begin 	   loop_end 	   mix_rate    stereo    data    script        
   local://1          AudioStreamSample       (             (              (              (              (   D�                      �0                  �@�<[9�5�2�/�,'*�'G%#� �"g�9�l$������N��
:
�		����@��1��R��`-���|V�M�Љݐ�������P�1�Ƿ�#��É����������M�ݐ�~�Q���'����,�\�x���n�M�����J�����������	�t���6�����0�{����<�w������;�f����������5�P�k���v@~|un�gRa�[V�PL�GCC>?w;�7�4o1}.�+)�&W$+"" 7i��6��w]SYo�� G�
�	a	�L�U�{�d���p������1��H�Y����ǽ��r���<�R�:��ԉ���:�[�_�B���F���#�p�������������o�0����.���Q���R���7��� �[����P������T�������#�N�w��������"�@�[�s�h@q|unugGaw[V�PL�G;C9?r;�7�4m1w.�+)�&U$)" 4f��3��tZPVm���G�
�	a	�I�U�{�d���(�"���ܞ���<����ۼ����0ȃ˦Ι�^���lٹ��������U���m���(�g�������u�D����j����3���8��������I�����@������J��������C�n����������;�U�F�w�p�i~c�]�W�R�M I�D�@�<+9�5�2�/�,*�'&%�"� �
O�&�Y������C��
2
�		z���;��.I�΅���i�y�.�����R�ȹ�������b�x�]�է��T�v�w�W����Y���3��������������z�8�����7���Y���X���<����a����S������W�������&�Q�y��������%�@��7~�v�o�h�b�\=WR"M�H2D @K<�8O5!2#/Q,�)/'�$�"� ��v��,��������+o�

�	�g�p��-�w{��{�p���"��[�x�F�˸�
���Xȩ��ι�~�ׇ���������j� �}���8�u��������}�L����p����8���=���$�����K�����B������L��������F�q����������;�Kp^y!rOk�d�^6Y�S�N*J�E�A�=�9�6C330S-�*(�%n#R!Tv�
|�]%���:q�X
�	&	��%�P����)�n�F��� r�ɫҰ����*����GɊ̝π�7���.�o܎ޏ�m�3���k���C��������������C�����<���^���`���A����d���
�U������Z�������&�T�|��������%��\x,qkjd^wX0S:N�I)EA%=~96�2�/�,B*�'_%##	!5w�I�z/������ V��
B
�		���C���v�֋ƒL�m�2��������A�=��ă������ў�6ץ��������}�����H�����������W����{����@���B���)�����Q�����E������O��������I�q���������?|�t�mg�`/[�U�P�KHGC?A;�7e4D1R.�+�(�&7$" N�� ��gMCLb���?�
�	Y	�D�M�v�䝅�ʓA�T�	�h�w�5���߽�����O�e�M�Ֆ� �D�h�i�M���N���+�x�������������t�6�����1���S���U���9����^����P������W�������#�N�y��������?�{�t�mg�`[�U�P�K:G�B�>7;�7Z4:1J.�+�({&/$"�I����aJ@I_���<�
�	V	�A�M�s��z���6�w�Y������������a������н�b���5�f�x�h�<���������N�n�z�w�c�B�����B������������o���3�����-�x�����:�u������;�f��������oy�qk�d�^�X�S�N�I�EbA{=�9[6302-�*�'�%S#7!;`��j��M����2f��
P
�		���Nࣰ���c�����	�;��������|�������t���E�w݅�v�I����"����'�V�s��|�h�J�����H�����������	�r���6�����0�x�����<�w������;�f������?�{btpm�f�`�Z�UpP�KG�B�>!;�7G4'1:.w+�(n&"$�!�	>��{��\B;CZ~��7�
�	S	�?�J�qP�����,�R������k��.�+���s������ё�+ך���������u�����@����������T����u����>���B���'�����N�����E������L��������I�q����?�{Mt[m�f�`�Z|UcP�KG�B�>;�7=41/.o+�(f&$�!�9��x��V?8AW{��4�
�	Q	�<�H���@�e��r�b���;�,�Ҷ0�M�)���6�l�q�G���u����"�����O���G�����=�M�L�=�����v�%���g����������_���#�|��� �k�����2�j������3�^����_�yor�k,e#_sYTO]J�E�A�=":�6f3U0s-�*/(�%�#g!i����j3�� Ey�`
�	+	��*�商Ս��������ε;�f�O���tɸ��Ϩ�]���Nڍܫު���K������V��������������K�����G���f���e���G����i����[�����$�_�������)�T��e}�u�nAhb.\�V�Q�LH�C�?�;T8�4�1�.,f)�&�$l"^ o��N�^	��}pw���\�

s	�Y�bZտ��������ٱ��������6�>����Mج����������4��/�����*�<�<�-�����i����_���|���x���W����v����e�����,�g������1�\�A�w�p�i{c�]�W�R�M I�D�@�<(9�5�2�/�,*�'&%�"� �
O�$�Y������
C��
2
�		z�}�ȉא|������K�,����!��Æ�������|���M�ݍ�~�O���%����,�\�x���n�M�����J�����������	�t���6�����0�{����<�w������;�\oxMq�j,d2^�XHSON�I<EA8=�9 6�2�/�,P*�'i%-#!=�O�7�����"Y��
E
�		��Z������!�٥:�L��������j���4�J�5��ԁ���2�U�Y�=���@�� �m�������������o�-����,���Q���R���7��� �[����M������T�������#�uwSp�iPcc]�W�R�M I�D�@�<9�5t2q/�,�)p'%�"� ��A��O
������>��
-
�	 	w�u�1�;�ח��g���o��O�Y�%Ĺ��=�5�Ԣ��mۜݫߙ�i���:����<�l����y�W�)����R����� ���'����z���;�����5�~����B�z�����B}�u�n�g�a�[fV<QdL�G�C�?�;&8�4�1�.�+F)�&}$Q"C W��8�N���oci}��T�

k	�T?֖���j�����8�w�e��c�z�T���[ʏ͒�g�֓���#�:�-���b���W����+�K�Z�V�H�'�����~�-���o� ��������d���(�����%�m�����4�m�����Oz�r�kwei_�Y]TQO�J#F�A>M:�6�3x0�-�*L(�%�#�!���0�'�x@'M��e
�	3	�����Ε$������ﱚ�������C�L�&���Xط���� ����9���7�����0�?�A�0�����k����b���~���{���Z����y����h�����/�g���{�}@v1o�hNbq\�V�Q�LDH�C�?<|85�1�.(,�)
'�$�"v ���a�n���~����d�

y	��� �X�"�����(�u�s�$�������AƵ��� ��Ґ��yڸ������k����q�����$�&�������[����Q���q���m���O����q����`�����'�b����N�y�r�kLe>_�Y5T.OuJF�A�=5:�6v3c0�-�*9(�%�#r!q��%��p8��H|�c
�	.	��^���X�����S�����I���Ծ��_������Ҧ�-،��������y����|������/�.� �����a����W���s���s���R����t����c�����)�e���|!u$n�gba�[V�P L�GNCI?�;�7�4x1�.�+ )�&]$1"( <n�#�8��y_U\r�� J�
�	c	-�������ޛסv�����d�ʺ���w���!�)�Ӷ�:؜����������&��'���� �"�4�6�%�
����c����Y���y���u���T����t����e�����,�e��n�w�p�i�c�]X�R�M.I�D�@�<69�5�2�/�,*�'.%�"� �T�)�\������F��
5
�	�縈؏��՜âR���z��v���g��lʟ͢�t�֞���.�B�8����g���_����1�P�_�\�K�,�����2���r���������d���(�����%�p�����4�L>uz%sCl�e�_Z�T�O�J^F)B7>�:7�3�0�-�*o(&�#�!���H�:��P)2X��p
�	
����� ��x�����;������ǁʴʹЇ�.֮��;�O�C����r���j����9�X�e�d�P�2�����5���t���������g���+�����(�p������0}�u�nh�a\�VZQ�L�G�C�?�;<8�4�1�.�+V)�&�$\"P b��C�V��ukn���W�

��� �����ңT���_��?�L�Ĭ�
�3�-��Ӛ��e۔ݢߑ�a���5����:�f����v�U�&����P��������%����z���;�����2�~����L^\x,qkjd^zX0S:N�I)EA%=~96�2�/�,B*�'_%##	!5w�I�z/������ V��
B
�I�P��"���z�����\�g�3��� �H�@�Ԫ�!�vۤݰߞ�o�%��@����B�n����~�Z�,����U�����#���*����}���>�����5�~���5|�t�mg�`)[�U�P�KBGC ??;�7b4?1O.�+�(�&5$" N�� ��dJCI_���<�
Xؑ���*�]�3���Ԯ��=�����V���@�f�[�%���9ً۷��߱��5���M���L�y������b�4����Z�����(���-�������A�����8�����^&x�p:j�c�]QX
SNkI	E�@
=f9�5�2�/�,0*�'L%#� (j�?�o'������Q��
�݉퐎�ʝ��,�[�9�Ϸ�+��Ñ������ӄ���Sۄݒ߃�T�
��*����/�^�{���p�O�����J��������"����t���9�����2�{�f�|LuLn�g�a�[8VQ;L�GfCa?�;	8�4�1�.�+0)�&j$>"3 Gy�+�@���e[aw��O�
B�g�!�r�e���;�,�Ҷ2�M�)���6�l�q�I���x����"�����O���J�����=�M�L�=�����v�'���g����������_���#�|��� �k��=�y|r�k9e._~Y'T!OhJ�E�A�=*:�6n3[0x-�*4(�%�#m!l����m3��E|�	R�ߍ����Ȧ��ӵA�k�U��zɽ��ϭ�b���Qڒܮެ���N������Y��������������N�����G���f���e���G����i����[��]�w�p�i�c�]X�R�M3I�D�@�<89�5�2�/�,*�'1%�"� �T�,�_������F�D�m�b���ߤQ�m�>�ø����Pȣ��δ�y�ׂ����� ����e���{���8�w���������W����{����C���H���/�����V�����M�~l�u�n�g�a�[NVQAL�G`CT?�;�7�4o1w.�+)�&G$" !Q����\B8>Tx��1%�Ƒe���v��������ռ����8Ȑ˶ά�s�ׇ���������x�����H�����������a�#����&���K���P���4��� �[����P��h�q�j�dz^�XySuN�IQE*A@=�96�2�/�,=*�'Q%#� �"b�1�a������>��g��f�Q���	�������Æ������ӏ��cۗݨߙ�l�%���E���J�y������h�9����e����0���8��������K�����B��G�o�h�b�\'W�Q�L_HD�?<85�1�.,s)�&�$l"[ j��@�P���j^dw��J?������>�����I������w���+�9����Rش��������I���G����!�C�U�T�E�'������2���t���������j���1�����-�>Wn�g}a�[ V�PL�G;C1?d;�7x4R1\.�+�(~&/$"�>��u�yN4-3Jm��'#����i���c��3�5��ą������Ѵ�N����5�<�$����6���k�������������t�6�����7���[���]���A����f����X��B	h�a�[cV2QQL�GnCa?�;�7�4x1}.�+)�&J$" !S����\?8>Tx��/�
*�8��D�K��y�����Dƽ�����Ҧ�2ؔ����������4���4�����5�G�I�;�����y�*���o� ��������g���+�����(�s�[�b�\7W�QMlHD�?#<�8!5�1�.,v)�&�$o"[ j��@�P���j^au�� J�
rƣ�@���z�#������#ǌ����П�I���(�^�r�h�>��������,�^�{���v�U�&����U�����&���-��������C�����=����W_^Y�S�N5J�E�A�=�9n6(302-{*�'�%F#'!)H��Q�z/������K��
5
��P�����0�������.Ǚ����Ч�T���0�f�z�n�D����%����2�d����y�W�,����X�����(���0��������F�����=���u;�\RWR"MH$D
@1<�8,5�1�.&,~)�&�$t"` o��C�S���j^du�� J�
�	W���Ͱ���=�2���gɰ��ϫ�e���^ڢ������f����v����� �2�4�(�����k����b����������_���&�~���%�m�$\�VRQnL�G�Ct?�;8�4�1�.�+)�&O$!" $V����\?5;Rv��,�
�	����q��_�q�C���=�h�c�3���O٣��������U���p���0�r���������T����{����F���J���1�����Y����M���l�V�Q�L7H�C�?�;Y8�4�1�.�+Q)�&�$N"= Ly�(�8��qUKQe���9�
�	b�u�N�۸#�+��Ā������ѱ�N����5�>�'����8���p�������������|�;�����<���a���c���D����i����]���XSTN�I1EA=n9�5�2�/�,*�'4%�"� �G��G��������+o�

~	����������Xȱ����є�0ץ��� �)�����+���c�������������t�6�����7���[���]���A����f����[�����PL�G8C.?_;�7r4J1R.�+�(s&"$�!��1}�e��kA' &<c��p
�	8	?��b�t�H���B�n�k�8���T٩��������]���x���8�w����������\�����$���K���P���4��� �[����S������%�KG�B�>�:r74�0.?+�(3&�#�!�� P�=��K!	$K|�]
�	(	��V���x�.ƪ�����ҝ�*ؑ����������7���9�����=�O�Q�C�$������2���t��������l���3�����0�x�����-�GHC;?l;�7z4R1W.�+�(v&$$�!�1}�e��kA'&<`��m
�	6	���*����1�n�|�Y�	֐���+�D�=����z��t����L�k�z�y�h�J�����P����� ���*�������A�����=�������<EA%=s9�5�2�/�,*�'.%�"� ��A��A��������&j�

y	�\��]�ƒ������ҍ�؄����������1��4�����;�M�N�@�$������2���t��������l���3�����0�{����?��:�?�;L8�4�1�.�+@)�&m$<"* :f��%��aD;ATx��,�
�	F	�/�ۜ�0Ȏ˶ή�{�ג�����
����#���]�������������t�8�����9���^���`���D����i����]�����'�b��?�;\8�4�1�.�+K)�&u$A"0 ?l��(��dG=AWx��,�
�	F	�1B�ƍ������ҍ�؄����������1���7�����=�O�Q�C�'������5���w��������r���6�����2�~����B�z��,�9(6�2�/�,8*�'G%#� �O��I�������(l�

y	�\�g�Lɘ̳ϝ�Z���Yڠ������k��������*�?�A�5�����y�*���o���������j���1�����-�x����?�w�h�85�1�.,f)�&�$V"C R|�&�3��lMCFZ~��/�
�	I	�1�:��v�v�F���dٹ��������p�����M������������l�0�����4���Y���]���A����i����]�����'�b���)5�1�.,k)�&�$\"H T~�(�6��lOCFZ{��/�
�	F	�1�:�J�=��ԙ��W�~ބ�m�6���y���Y����
�"�&������f����b����������b���(�����(�s�����:�u�����4%�/-J*�'T%#� �T��I�������#g�

v	�Y�]������|���<�f�o�W�#���i���K��������������a����\���~��}���_���&�����(�s�����:�u�������.,a)�&�$N"; Gq��(��_B5;Op��$x
�	>	�&�2�[����kۤݸ߬��=���c���(�j���������\� ����&���Q���U���<����d����[�����$�b����� �.��%C)�&j$6"" /[���{N2(+Bc��m
�	3	��*�S�����/�[�d�O����c���I��������������c����_����������b���+�����*�v�����<�w������>��b'�$�"� ��i�k��uffw���A�
�	V	�<�E�i���G�s�|�e�3���y���[�����'�.�#�
����n�"���j� ��������l���1�����0�{����B�}������C�n��=$"�3}�`��^.
'K|�X
�	 	���C��1���߼��M���s���:�}����������l�0�����7���^���c���J����q����e�����/�j������6�a������!��`�B��C���8i��
H
�		����8�|&�K�p�>�����i�����4�<�0�����{�/���w�������	�w���;�����:������J��������I�t�����F?i���yI, #7[��`
�	&	���F��1��M��&��7����#�H�]�a�V�:�����M�����#���0��������N�����H������T�������&�T�����������T�q$�������(j�

q	�T�X�y�Y�m'����V�����,�4�+�����{�/���w��������z���A�����@������O�������!�N�y�������
�(���A����|���J�
�	V	�9�?�c��G��]�����L��������\�#����1���[���c���L����t����k�����7�r������>�i����������;�X�bA���{y��� A�
�	N	�1�7�[��A��W��^(
����������q�'���r��������z���C�����B������T�������&�T���������-�K�f�~����������#b�

f	�G�H�i�I��]��`+��C Q�K�5�����R�����0���@���/��� �^����[�����,�g������9�d����������;�U�p���������)�0^��
2
�	�g�e���\�j$��k3 ��yQ; ����]����;���J���9����l����h�����7�u������C�n��������%�C�]�x��������������	�	X
�		��x�%�g�p*��k5��yQ+	����?���q���{���g���6�����@������W�������.�^����������8�U�p���������������$�2�?���_�U�n�G��R��P���a<�����eO{���l���>�����K�����$�e������>�l��������(�H�c�~���������������/�<�J�U�_�j�u�G[��.��:��p8 ��qI!�����jR:RSRC           [remap]

importer="wav"
type="AudioStreamSample"
path="res://.import/jump.wav-14683e0efd5a66adca0a851c79ecec1c.sample"

[params]

force/8_bit=false
force/mono=false
force/max_rate=false
force/max_rate_hz=44100
edit/trim=true
edit/normalize=true
edit/loop=false
compress/mode=0
           RSRC                     AudioStreamOGGVorbis                                                                       resource_local_to_scene    resource_name    data    loop    script        
   local://1 �          AudioStreamOGGVorbis          �  OggS                 ���avorbis    D�   q  q  q �OggS                 -֫�}�����������������vorbis/   Xiph.Org libVorbis I 20140122 (Turpakäräjiin)   :   Cool=This song has been made using Linux MultiMedia Studiovorbis)BCV    1L ŀАU    `$)�fI)���(y��HI)���0�����c�1�c�1�c� 4d   �(	���Ij�9g'�r�9iN8� �Q�9	��&cn���kn�)%Y   @H!�RH!�b�!�b�!�r�!��r
*���
2� �L2餓N:騣�:�(��B-��JL1�Vc��]|s�9�s�9�s�	BCV    BdB!�R�)��r
2ȀАU    �    G�I�˱��$O�,Q5�3ESTMUUUUu]Wve�vu�v}Y��[�}Y��[؅]��a�a�a�a�}��}��} 4d   �#9��)�"��9���� d    	�")��I�fj�i��h��m˲,˲���        �i��i��i��i��i��i��i�fY�eY�eY�eY�eY�eY�eY�eY�eY�eY�eY�eY�eY@h�* @ @�q�q$ER$�r,Y �   @R,�r4Gs4�s<�s<GtDɔL��LY        @1�q��$OR-�r5Ws=�sM�u]WUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU�АU    !�f�j�3�a 4d �   �CY    ��� �К��9�堩����T�'����s�9�l��s�)ʙŠ�Кs�I����Кs�y���Қs���a�s�iҚ��X�s�YК樹�sΉ��'��T�s�9�s�9�sΩ^���9�sΉڛk�	]�s��d���	�s�9�s�9�s�	BCV @  a�Ɲ� }�b!�!�t���1�)���FJ��PR'�t�АU     �RH!�RH!�RH!�b�!��r
*����*�(��2�,��2ˬ��:��C1��J,5�Vc���s�9Hk���Z+��RJ)� 4d   @ d�A�RH!��r�)���
Y      �$�������Q%Q%�2-S3=UTUWvmY�u۷�]�u��}�׍_�eY�eY�eY�eY�eY�e	BCV     B!�RH!��b�1ǜ�NB	�АU    �    GqǑɑ$K�$M�,��4O�4�EQ4MS]�u�eS6]�5e�Ue�veٶe[�}Y�}��}��}��}��}��u 4d   �#9�")�"9��H���� d   �(��8�#I�$Y�&y�g�����驢
���        �h�������爎(��i�����lʮ뺮뺮뺮뺮뺮뺮뺮뺮뺮뺮뺮�@h�* @ @Gr$Gr$ER$Er$Y �   �1CR$ǲ,M�4O�4�=�3=UtEY        ��K���$QR-�R5�R-UT=UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU�4M�4�А�    䤦�zb�9�AhI��\:霣\���#FI�!S����I���ZjsT���dHA-��R!�BCV � �MK       I� M�      ��4@=@E                                                                    M4Q4Q       M�T�4      @E�3E@4U                                                                    M4Q4Q       MQ5O4      @E@4M@TM                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           B�!+�8 ��@� I�4�cY�<xL�X<��         @�4x<�	�4�σi          y<��H�σ��4         �L�	фj<ӄi�4a�                      �  � � �@�!+�8 ��H  8�dY  �H�e �eY�  �ey                                                                �  � � �@�!+�(  ��Xp��cY@�,`Y Mx@�  � � 4%(4d%  �p��4Q�8��i��q,K�D�ei���"4K�D��y�	��<ӄ(��iQ4M    6hJ,Ph�J  $ ��8��y�(��i���q,��DQMSU]��X�牢(����.��4�EQ4MUu]h�牢(����.4MM�4UUU]�扦i������E�4MUu]��h������@M�4U�u]��h�������4MUU]וe�i�����,TUU]וe���꺮+� �u]ٕeYຮ+˲,  ��  �:ɨ�M�� �" �  �aJ1�cB
�aLBH!dRR*)�
B*%�RAH��R2J-��R!��J� �RR) �8 �X��� �  c�b�9�$BJ1�s!�s�9�c�9眔�1�sNJɘs�9'�d�9眓R:�sJ)�t�9礔RB�sRJ)�s�9 @  6�lN0Th�J   ��8��i�'��iI��y�'��ij��i�'��i�<��DQMSUy�牢(���r]QM�4MU%ˢ(�����
�4M�TUU�i��i���¶UUU]�ua۪�����u]�ue��뺮,  Op  *�au�����BCV   �1)�R!�BH)��  � � �@�!+�p  ��1�c�16�a�1�c�1q
c�1�c�1�c�1�c�1�c�1�c�1�c�1�c�1�c�1�c�1�c�1�c�1�c�1�c�1�c�1�c�1�c�1�c�1�c�1�c�1�c�1�c�1�c�1��Zk��V ΅@Y��3�$��� 	  �A�1�$��JJB�9(%��Z��B�1���Zl1�9���Z�)��9礤�Z�1�Z\!��Z�-��l!��Rk1�Zc3J��Z�1�k,J��Rk��k�E(�[k1�Zk�5)�sK��Zc��&���1�Zk���"�R2�S��֚�0��c�1�Z���S-��ZkRJ)#d���ZsNJ	e��-Քs� @=8 @%A'Ua�	�BCV � BJ1Ƙs�9�sR�s�9� �B!�1Ƙs�A!�BHc�9� �B���Rʘs�A!�RJ)%��9� �B(��RJJ�s�A!�RJ)���R!�B��RJ))��B!�J)��RRJ)�B��RJ)���R
!�J)��RJI)�B	��RJ)���RJ)�J)��RJ)%��RJ��RJ)��RJJ)��J)��RJ)���RJ)�RJ)��RJ))��RJ��RJ)��RRJ)��R)��RJ)���RJ)�RJ)��RJI)��RJ��RJ)���RJ)��R*��RJ)�  � � #*-�N3�<G2L@��� �  ���Z��r�II�CF栤�I!�XKe A�IJ��)���*����B˘Rb+1t�1G9�TB�   �  2@�� 8@H� 
�E@@.!���pL8'�6  A����� 1�(*����| ���H���.\��]BB�X@	88�'�����ST�@      �  � ""������ 	!)19A     ; �  HR���h�8:<>@BDFHJLNP      @         OggS  @8             �*/!GHK�&�+� �$��#�)�*������%  �RqΨ�gZ,W��Jy�} �%��1(�0,�G�*�"��(j�i�b-��ZAЪ��hDq��f-��P��FQkC��"5�Z�$7�*#_F�cUAE��Zc+TU�p����U+Tc�"�" ��H��o��m�5�f��%T�Zkq
YBe�}�D"AFN�ZC��8#� ��X�E��Z�莪��������p�Y����?��G�TͲx :��q���x�	��ry� k7�vB }? ��d��,+��98;��bv`1�b̜���F��#�X5F��qaQA�,WBJ�4Ԋ�aŚM���)*�X�NthE'bQ ��>���$�$��|�C�i���/��s��\��\%�]~_��`�F~�ʍ�sfN�g[�;��$N���E���#�����c�hf�)J$˛:H-R��X��y�岷'Y�mdWw0�D���6 `Ek  D#  �@h��)Cp~'�!M����m4�%�tk#���]��H�g ǀ� >�l��;���v�K�5w3�7 �4=�i�T3��11�9;;�8c�TbL� �@��S�iXL1-�iok�cX�X �T�+��rYI)J�iZ�F llD�*Fb��k���6[�?�H""bT��E@���P,�@�v����R�T�_8�ȫ����wQ�?e�iI��g����j�-�!����醍:�@����j�5]�#��ݤɲ�Xu���q��ږw�P�s��� �>% � ʁl � h�
�]��{�۾b�&(��}鲽����k�' � ��9`0 ^�5�C�����_�5�C������ ���I ��ܓH�b�,�L,�ʁ8�ة�,����,�Z�( F��6��a���ؘ��\�#*,�p`1��`���kݯUY�>]�=6l�G9��Թ�;�5)��k���%�e�����gڥ�9�*���%4�h݂���^�2�z�~��kk�����1�)�Y]�K,	y9�_��rb[-��'�	(��y�9�m%�|�ͧlkT�FhC��38�04 `/߷�h"K�l��Mn� �  t����c� Gf%�7�>�&A���	��f��$��?A�  ���Y�Vn�0R8�XL��'1�13Of � ƈ���0�δ��  (��H��ʣ �X�թ��A)�d�/�:W��m�b����4���W3�RK.Dk�"VDŢea{mh��vJz5/�61��
Fк��Z5A�0(��ʳ���\#�%��bR���E�����7�8��9v{�f��	Vm1��A ����f���}��%�m(���+�Wy�訿���~�ku�_��$ ���l �Z � d�y�B1zM ������!]���z�a�.t� �����������9�13�bf h"�vVİ������ ,B\>#*��8V,-l��aa�jju��b�Z4�����^�AA�RD�h��"h,�`������hj1E$"%�8Z���k�7jo��ķڲ�$�	{�'�/�!��f9%�H�
��^����e�9�[�刈̪��}�^O��S�s�>�n��+��=K-G�x5Z�v��<W�N���%N�a�f��ے(�+�+
~o��� �! ��(�!��%�,�F ��r�n�&`+�^�R� �m�l�W ��YG�RR�������903q
3	 Դ�S���	@W�r��R|AְnŊ[XZ�PU�،����E�j�r�I�����%KY^ʮc��">�� 6�F�1�j���� �0[� �Jv��6Z�9v ���� yg�O��"Owi���A:��4��w.5�E&�
��VknUm^(ؕwR��r9��j�Qx=��8X# � ��B���ʨ�ɯ����v��+$V�^4�UUl �8���y��a  >�M����&� ��  dMDdd�E����ȑ������t`1c&v:3	�h�PTVՂ�a������c��<AQ1�b� G�j�´1�C�j�T�F���UTF\I�|��>�E ��h��n�j�E5 h����w	XE`KƩ6TOjU���R����rN�&��]�p���;t���s�g�զ]� S��""��&O�M+�X�1��a[�*�A��RLNB�۔�së������L�ڷ��Pye��/�M��籭|�]��~a ��
���&����A_ �Ne(��Ne(�� Ȭ� �T��ّ��1��$vpH�bb��@���5j�
 `�<AD9b�,�Ҫ�-�Z�f͊aհ����h��Ѡ�UE����X�;jM" h-�5��#����[���͟V��]t�.�y� �� b  ���~<���!��h5��a���Or�"�Rg�h�t#/[l�qH��rM��Q1`1h�`#X��6��Jfr��~�ɜ \B	 ,`�<� �+��M�٢������@��ǲ<�uV�8�F� �֩1���L��YK� ���q��ǂ^����q��ǂ^�� 0�M�e:�;0;888�Mff&fGNg&"aU���P TDmհ{;[�����
�ay�D�'(�����(Z4�*Z#X�A��A'���A$��wL�YB��iƏ��u-����gȱ�h �����os�����.��]A.�KM��_���:���aɒ]"i2ɕQ�"4�,"�C�[���E�X@���Aֳ(������=ckyKp�kE5�) ��8"٦j�<>֒��9, h �AQ[� �b�i�!<�$����0 ^�m����^���:x�  �0��	1&vcN�����(g JT��ؘ
jZ���{���0M�� ���J�`�q)��u`Eȷiے�軔�5I{�.�e��$Ss��?�JnqG��(��l�?�·��c�H\�!���{�I<�����-_�<��Sق�4b\�Eu�\S��哶����M-�ZQDl��#�2*cۣ�����|c�y��͆����޴����$f� �m� Zlku� ��ֺ ( �
�A S ���b���	�W�3T�L��} Lb�_RQ��S���;��;�98bff&&>[0� @# +��T�ZM{,ةZ0VD�b��  ���S�r �#�Skj�U+����h�aPň���"�`1�h+��͊?���t�4�hW�A�`1����R�?�W���{YX��ZTGdˡ)��WA�9�t>n�۶c/�v�# &G��(����$L�F��Δ��D�#�R�c�4#�p����ξ�Q/����-�5��kTe> R7F�i��U��'D;>�m��@@{��L��� ���)�	R�rp vp���a233;Z8`H&А�
�
��*Ƃ�6�E�l�b�ډ=���
pV�_��QQC�ĺ!j�" 6��Q�5t1�؈�QHe�#�(���Ͻ!�r�3������s{��h-���
TF��FƠ�#UrP#/���m|�Ű��$$O!#P����O����`]rM�k@',XD���
�@����]'5K^��7� ��U�U�U�~;����=K?��Dn
 @��d��M�P��8 ~��� @��;�)@��7 �&�� �R903������N��L� p�I �$Ԅ����V��T1L�7,�CmA�0 �j�!B�(aX1	1JEM�.b�XAegґ��Ek#���"A@�<��e�GpB�7�*.u��7jé��;�n�t:�����Q�2^�5��#g�>Z�O~ߎA1h�\��^��4A&d>Z|H�T�_o��`�V@U�XXEV����8i7c��$-�����Z�кK�;��f��EH/*�� G�{#X�V# 6)� b�¼`:�~�}������ǋ �~ ,g`:8rpp s &s��ĈY��ac �$$`�;�Q;���Zl-����0"���2�D$���ш�:-*�ڨ��U0�5F��Vs�r:��,b�E�d�$�o��Snv��b�*E D���Ό?��W�GgO�,Z�,�%RL�HL�x[0��u��KA�	���T�n��M4��:�1�X�** ���}�0���s�X�hF�-S�� ��H��l��I�"�U���QmP P,miM@������8 OggS  @i             8W�&�-7@?8:<9IKM�%<>:;;;LO�0�7�"�&���#�۶�]ZE�{���� �7 ���g�gH�*�!������df#v��Z�L �f�0���C��UE��bؚ���c &VAT�#��&!"%&.��1�mE������֠��b�r|<��hQ1�H��$��h����g�F:��,�t�� �*V�AX�*�ixs6����v4� Zc��O+=o9���36�+6�+�8ҽ&��V,F�������t`#hDk[�* �����������J��:֒u��T��x��vi	�Y�}
|X6h��j�8���TU՚(&�k�NF� �b�%��b�%�@Fc�	���,�g�$��������r<���i��f�+�j� c~,���N�
�XR��ka1� H�B�GX��B�y�k�Y�v�At��zo���uX5 �JU��x*��\-(�t�e��A�5 k�F�h�U�`��,@ѠX��'�8��V �b{*�!g���T�C�t  99Ƥ�, W\�C�����׷d%y�[���1��yYTbݗ �b� ���V��Tځ 0��J�*L8,M*R���B���"��b�����S�ʳ]k �R�d<�饶�$x�r@mmm��!H1�h!!=�Ѡ���e[��|x�sE� �rM8���g���PH�����X(@�%T4���N��5�W��]�.�k~EY$ �j�pH��ڥ�����V$�f���Uc1�؊�N�UD�VL��0,�a�-��5u����Ѻ>lU��:�V �j�S&D�8n��:eBԊ�~�	&�ȴ�� R,W���`Et�hQ��Q�"ew�ъ�5�
�����Ϻ/�Չ� �j��4j�i[�yN5�`�#�� Z �|i|�ˊu��A4�U���"��e�TEEt ������4j�(�mU�Z����~
2_l��)T�|�  ��C����8��9���b���g� hD��
+�j��7�jk�b b "����	JI��Hrš�i�-m��U�"�`X����!w���m��#BJI\H4 �`[U�Ȧ�!X�ID�/�m�������yX�(R$)@@#۶�U`� �L+��I  ��[澱�Z�J�Ҥ4��<�{�~=�HEA��Y��	(&�5E���h�y*�����f��� ��Z�}�w2��1���4�p$� H@��fӉ���� �Js�CLN�4G�1��PoY+!H&�!HF�*��U��)�)�@���W������T�j �fC*��>��Ѐ�(�ρ �	AC��C,��}<4��E�Ų���hP�7G� �4  �b�2 r�[l�@@Nv  Y�A
���I2KXwҧ�k�D�V�Ϣ��Q�$���* �^cP?��^cP?� �R@k ����:���7)��:qx|�N���g) �fs(�l���A
9� ��b�� ���,h@_�,?��U/�_1�U��R�<?�F  �Ne�
)!��t*;�TH	I/�я@����`��ZA�N�):y�F�(v������˹_�C  �jGdg�{����R�X��dZP�� �%"k��h���FA��(V��}����*X�gQ�gnvN��X�Fq4��'"@���hd�OD�p�IZb	rrR0"�
�
h�UQEЁED� �_
Dt���:m,�M{f�R�7u�z��<�B�$���!s��[��x�? ���:���2`K������A�!�;333��L@22�i-F-��֨�2\Q		aqQ�$�J�bE�Һuӊ�l���� �j��Q�v����+Z�b�b3������x�-EP-5���8�S�\E��MM��U��ېqJ(��M8ɕr�;��H:�J.�l>U%�&k�DHjk/��j�Z�+ؗ�?��%����o����bCY--|�m��Lc���sj�\�98	�}��J��훳y�ζ��g��ԃ���X��U�|𥶽dy r�! ��Uɺ����"�1X��d]��ss��  ����)���9888�bb��L�,�,��$ ���Z� ��`koo�VC @��� �\a³UUk�X�̞Ϯ�K��*Z ����Ir��HҊ��*��;��.}8\Ud�|�$��*TEQP�Z1���m�"bA�b��J�˨��,jߧ�d��k%57�C���V����x��&�L5�d�J�ú�9�`��Ӏ bv9sݷ��ݬ�}�Z/�I�����0G�I���x%�7&��[~XoX���o����Z#ْ}�yϓ�I�F'<-��Lw㻶��}7]��DFG���DFG��@��H eŹpp$& ���� �b��������LHmoAÂQPU�����v��a����F��FDXԊ�m���]����I�@I�ŊR4�jۢZ,�IeX���|�4hV�\�bYns�$�#y=�A|&z��E\Y��c{�F������䒼*�#2~��te�Ns�"�rյ�wd�
��V��-�_��g?��;	Sk��ݖ�2�Oz��͎[�.}짷#s�$�~ؖ��r����%䁔�4Ѧ�N[e���b�\�~Ix
 WLbW1 ���gFZ��B#ԉ���gFZ��B#ԉ� ��$g88888�988���q*bfb&ff1f� 2�-CP5�6����Uİ�3�V;S-�`�  ��' )J%X�h���b� ���-K��e8]<��\+����C�l�T\���˺N��i�!�d�sW�q�kwL�ڳU���IªO��Iľ�j�B�9� ��Jk�}�&]OV挴"����k��9���E����A XH9�E,�?O Yܴ�#=��['���1�س�ze sel{h�+��]�m�6�_F�#u2\}2�����|����f��G[K ~i%�K< �,q� �_ 6G���������ŘI dF�   \Q!"�X��-l�n�����i��-�P�f�[V�Y�0EQTUT-Z
Tj��J:JDd�g���(*(�&d휓��w$�z��5jx��O�8Ⱥ�VS$ʬ����@Z��ړD·dha9��Hۛ)s57\�乛��j����o��LTZmXh�F����]��3+�9���|%����|e�D7���O��k|�o:fm��*O���o_> 1pBk��$�yU�|=�5h� �iEJ�`�x�V�Tv�� �d�"@*��11bv fcffbf ��"��4�lmm-�a�`kg���j� �/.)B��7-E��5Q��B�
���X��-�����]����Z� ���l�6m{�,��E@������m�Nֲs">dɋǟ���B&�%�����U���Va@M�C����'��my��2�]���������ˑ�v+���[u�U*L!�^ۗ�n&�>��ț`;]vp�k'�M��:v�}I�a����}��5�o��(�\��M��D�5���䡀1�P��$��} 8��D*1bb1��,&����� 	J#�Xl�����+ ��	P)aF�k�-��Қ�i]�X*X��jU�F� � Z�Xt`2|��Q��]�m�U�-���]�V�"�bY��:<״p�E�5R�c�o_�r߻f��]�8Ƣ�q�5���l��%�3���Z�ē�%�B���-<��#\�܅��* X�
���* ��*�2,��qPi��8O0���:wsY��?��=K�|H�O��CJ?�w�7'��ӹ��������&���ح� ^�,�����J�E�: �W ���J�����s��s�9s�ʑ#�TbL����a�ڋ�ΰ����4�HI#���$����li�u5k�i��Z��`�
��h�((�N���"�h��[��U4Z�:Q�Fc���Z�FՈh�X��(hQ@Ո(��F�Z�(bQD�Q@�`��*�7qS�ւ�"6�bQ��"F�X5��(��� b1Q�(ji���j�ZQ���ب�
:ATUAT�b�Z�ZUQQE�
�-�jk���b��h�X���h��j�Ek0-�hUl�1*Z[k-�[�,ZT��jX�t=6*�
� �(�6����k � ��A�"� �� �XA����$�J��Ye��+�Ă*"F#�(���B߭Zيv��.e!hl14��X��u\
a<TE �ED�m��;DDՀ-���삻�ڿ<D��5�Z�������n�_��ퟕ� OggS  @�             ٫�y���������������������u�n x��Y'���� ��	�sNG�R�J5S���t��98�r#PV��[ml�X�D��	�\*,����XZ��R�Y�`�I���i!"��5��R�w�ӊht������Ƣ� �Q������,,�jZA�� �lQUETU�����hEl������ت�t�ۨ�u
X�v��E�����ZU�je7���PA��ZUU��Zk��X���=��bP�����{�Xl4 �F�tL[�#"��A�!��-�h4E,V-�U��R�h�����XDQ�kE�bU��PQ����4�(29l�*�"� V�
X1h��j`hmU����ݷ�Cӷ֬����V�m#��kU4s�9䘴�
`D�'�F��� �A,�*E!���$I�u|Q�|���P V��ND��K�P���rٳ'M�k$ӨA>;u���C:f!c?�7;u���C:f!c?�� @5+��< ��6�Ts�r����bs�����T� 5 +�Zk@��D�S�V5�.�ψJ)����@EEŰbŚ�6ڠ�K�J�N-ZQt(ZkTCð�nZ����X�:UUQЉU+hDТ�T�V��""�U-b�VMӪ�a�a!�5�@TU�(ZA��������mDD4��CAc����SDkQ�a�����bP���1ب}���J�����"���C�*:�`UDEk�	���[UĢU�hЊ�Vk+��AEQU��b+
��EPlQT#k�����FAU�+�5����� �Ӱ�U5�*Ĉ���FĨ�b�k� �Zb��i @ ��`E`A���:A���:Ѩ�SJ*�fF+b���4V���"ZQT�j�}�5���,]���*Z�A�ZQ�`�#��
Bc�~r4ōQkj�"*F ۊ��� ��~jŸQ�w/���Z1nT��K�x   ����̝�h:�T�R9J%����(�������I�� � (�!6�`c* ��q�|q���8⌄a$ŉ��j���c(`K,l Q4Q���T�����*�jP�!XU�jEA�*�V+�b�آ`U�":-� +&�-�&1��,�nb�0�b���OwW�)��5�c-����QT[�VlD5�S1�0�8���h(�!X�*�Q��`��u��LT�
�ъ ��(F��UPU�^��Uhl�U,�ъ*��J+ݤa���D���������VUEE4(*�N"3�J�X�:�" jX�fEDK��� �"H�9�/#�:5� ��j5��> ���}_�o���Yw��o�ߡ���k�\}�����-$��M�E4�  1�   @c ؖ�j ~ze|�ݵ#
8���+���Q�A_��  P��fF*�l����MG�!��9��G)��7&�m�(� ��V��E��P��֢ XL+  "�`EE	D�����V�:�A�FD��hUQTAUDT���U, VE#�LԪ���a�hE4Z+�Eˡ�Ld+�Uk�j���`�F��:�(b� �
b���Z�V5���1�7�k��bx"hU�hQ�(Z� �Ĥ�2�^بQEQ��E�� �jg�5�������
��Uժ�  �5��,�*�h�*
1(Z�F��BA�:�DUU���XѢX��XTEEl~!$��k�:5�����:��H{���P%�F+6��բCU l�	��5H�jQU��Q[|���M�h������I~"��["�X���k�MC�,��!�o3"j
�6 (  �A��ӓ7�
 >Z���g����JX�3v����  ���ޘ����(��Ü��>Smy�T�mLh[$@S"���ۛ�ig�� X�'œ�1 (+)"!.� �B|��  �aXX��$�D4�"Z�i�V�F��"�������T�T1PC�ӊX��K,�
�*XQPD�U��
�Q�*Z�*�CEma*��Dc����Q4���U�X�`T��U0bE�j0�(ܭ�;Ā�h�X@A�5�#X-}�:/r�Y��&��e��^j�h��>PTU�hQED�h,b���bU# U�����XT��,�ȻE5DѢ�U1�VL�
b�Q��Jg#*�h��U�*
֢�Ѣ�Ŋ�,��߈�a�PD-[�Z�u  �E��aa�R@T+ l�*F,�%����5htG��*���!-�S]�yr\Y��Ʀ��V�N��@�A̟�����VDt@��
�"bZ��    ���d�6�$ ^:u�g�ﮑ^�ԑ�Y��Fx   �Kض|�s:r�3՜�ӧ���@����$@�m��b�5�T��� �	!A
	B)�q%!��|AQ_�% ��XXX���Uê��UKð.�j)��TE�UՆ���u+V,��Zl���Uc-VP�XD�UբQL���ب�XC�f���)b�E#:E,�(�U�h�����1�Ek���n��R};U,�*���V5�E[4�`��5F��:���*�k~mQT�؊NAXw9��o�)�ZT щ�E�*b�EDlDD,�FA DT�XTEŊ`�	�ڕ���STkĨ�E�b��آ*F�Fk1 *"�hEEբ�U�hDA"���)�@TL�T��Rld�ŀQ5 Ft(,�(Z��?�[���V��!����wFע}f��Z�ւ� � h���b�m}���Ǖ��n�����U�U�"`CP@@�fU��0 �j-�rn�]gQ���ZP��z��
��  �Ef�ZYƫ( �[5�p�������Q>�>�t����!���$ ڴĠb�U�Uk�� ����v�մ`��
 ��H	���0|�ni)&j�uêV�U�XU��Չ(V�hTŊŢQ��abX(ji���wK�uU�j[D�jQE�FA�Q�X��VU���U�Q�����E�`ADTƢj���Ѡ#��U���"�b���[TUhED4��EE�VA1F�b+
�E5X,�(���FU�U-`�b��
D�:Q��jQl�p� _T�FD+"�DA10������55�V4��Z�  �Q�6��b�Xb)�^6�	�+Z��h- ���X���][� �a�An�'N	A+""�r�}��ȁC^�Z�_r��Ti[����b��p���?)E"-rݝhkA�\�뼅`�Z�b`D0:u�-�b�*0�c {����v� ��^cꨬ�5 �   �d��<�W��;r��0g*��͑�������@�� �%@ �bgkk�7�5����jg+��) �r%D��BQ��<��Zc[5��FK�U�BU0Q���@�}���Ӣ
�h�ht��Z[��X��o5��bXX�����5�VE�G�h[�� ց�#b@k50ED�f��jZ7AD�TDhuG�hlkQA�2��L3�X#"��"��'���v���Nz|����F#"Xk0�XAU�Ec�����h Q1�������*���GD$��C��jv�h5(�X�Z�����T�*:�� �N����b�����B����h�dv����i�Hӭ����'*�,B_�Ԥ+�G�P�u�:��@FZ"�(��� " 6  ~Z-D��B�N��H y�@� @u���(��>�}�99�ӑ�9�6R�rppp��� i�!�kbԂ  �
�a���B�:b+6X�&��´C�PQ�ZX�"�E�5kUE�EET�
�@LC��Uk:�*�����D�*����b
�5A�R��(�N���UT�EDQ��QTA��X,�֪A��i+(ZTTQ�ڂ��1��@U+h�V-r+���èTlK���RQ4�`�
�(bѢ�QTQEE�5�XUm4
�E�hPШ��*ZQ���WU�贈(��/�:�VE�UmD#ZT�(����0hm �VAQ�F���
�FE,��X���Z�V1 D,U�YVL[щX� k@��X��"(D`}\�k�ha6���A+(TZ� ����U�B^H��_��tE˕/S��{�N�k�/�ۋ$c��   �l*� (�5�
  �V  OggS  @�             ��������������������~jM�"��N�	W<" �   � �l��SMG3�6���Tsۦ#G�R9�] iI�&�`"�a b qD�BTD��e������4B)C �*��--lTK+��b�0��ia��i�����hlkt��b�BM�LL CD�!�N���(�j"*�V��[�ݿ��XQEA+���!}�
���"�E��X�"F�R�PŌjUA�QD�*b�hu��UAU����Q�V�z9���D�k����AD���QT���XQ���"�����QPQ-���/깲���V��]ߕEQD��"�
�A���HU�ȩ����� 6�A�jtS�[�@0EkŪ֊EDPDP�DԊ�-ZT �Q�"�h���b�bT+n�����@E,h�;��\�Z�UD�("WF:�F5�5PT��<���k����`�mA�RDz�0o��2Ѐm���Xt� �(��h	"  ��u�Ӏ>K�t�C#a⛥v:�ס�0��  �j�
�E�s���tG��s�r��-���\��@�I@d#��jEc0�U[5L1L���<���4!�r�X��bi�
b!V�X�0���"�UUՠU�(��k� ���a]�.������(��jE+��������Z�V�(�آU �֢QL0-,�	�4E5��l�A�l�%*&b� -�jQ��땺jĪ��F�QE�VQPT��!]]JZ[,bQ-��"���F ��VDUT�(�TEQU4�Fk��6bQ��F[�""X�1DUUEc��
��*(
�����bE��E��b
�*ݧ�'��Z��b�ªab�X`ʹ��3�]a�C@�AԴP5bĊ 6b�(X�p�Ԗ����Y�9�ڋ������x3����Ŋ�T5@D�P5ԪuV=�{����P���x���2��̈M���`@0�+H*
�z-p������d�   ��6�m�&�T3��T�f��jn�!��6XX@:]́���% �v�iX0L����j ��� �` jokJ�E���`$��S�ax�<p	�!\aI��Ұ������`��5KK��E��b�h[�%"��:ED�(jZ�X�j��F�Z�"��0��)�P�SQT[+(h��v�I.u�X0(�*�X�Q�*
 Z�
j&�+�x��5�����,��*h����2����A@T����.��iU��FD�֢
�kĪQ�5��Vt*"�8�Z���"Z���hE�6�bAEUЂ�k���8Ђ`cA�VDP�U0�Ě�%�b A��ZE Q5��5�(*Xョ\)7�n��b[�F�8�T�Z��/�)Q AP�g[G�E�YQAQD!mѨ��}A��N�#B���|a�( �j���
2�m�V�S��   z�o[�0�L5g�T�����j.�
XX`[��� �F3Q��TLQ�ag""��Q�*��j�Z�0A�4�2�\Qʧ��"�# &$hZ3E,KŴf�j��`���b�`� j]M�QK[����UE���"X�TCK���DUADUlkQE�V�bQ�6ZX��e�mY��Y��}��E#�X���QUU,�UTEEk� c-(�U#���E#bъETt�E����U���;����(b� " �PР�
��ت4��(���*����|v��ł�bђkJ���_�mzZD#�FU5��6����������b�
6�&���4�� ��bK�ALUla�u�E����@TQ��*�X@���Z$�E+XATc�hĢ���n�*J�P�nMCmTUETT�hD C�������M���O��� �jm��Ҳ�Uk�5���%��  �z�7%��S.��2Y�3�|:}ל3�tp�t���h@Y�! �:�Mbf@�����b�����c�UD�`��`DAD������"�FD�"���/J	��!66��0SDD�[���jUDE�Nň1
�UA��S�T��UúX�DL�*�A�Z�b� V���UЩ��P�AD:�QUQ-��z赦�S5Pk"&���؂���KR���uS0C0����hAE�P4
�Ѫ�ƶ��E,A�hU��m#ֈV��� 6Z��`����*h�"(� �`����h�z�CꥻR�CK�-VE��bA�C�BU�PKe��e��DU�Ұ�R�Sd	%PA�X+��`EЀF,b@-��`AQ�*Z��F�i��"E��ؠ��j����� 6` ""����j�E,�"� �cQ@�m�� ������ {�DO)2 ���$zJ�`�   ��o[�09�J5�y�06q9�k@V����Ř	  [��i�jk���i�{{��`�*V ��������X a�
0_�/&�!|i<a��� f՚���UAT,�Zb�ج��b�a������D5��fTPA�N�l�E@E1��TDE��(
�m�UDm5E���O����ujDPm��Q� ?w�$���q>���U�X��m�ių�U�(��1���Ft�X��`Q�+���FĶEŢE�* ^+�CAŊ���(�
�ŊE�֢�ŢEP��*����T��b1��Ɔu�DӊC@�
0��vT��ZX� @X/��E1錳6�C�jQATM�@�4lRCQ ��C0S��(*�L����4<�L�G�2e�j]t��l �պ�� �   `�����(����r���Ts::X�#G�A"k� d֍�����l�*�TDը�b�FEPU��������EMTP�APP+bP������8� ,�i�0�<�5��Ċaݴ���XX���@��K[Z`i���X�� �a��i� �b�d�b@�(�@Q-bD�b+b+Z�"�ú
��!&�:QPE Q�XK����((X7�P%���5�W��n+�5E0P5U@�k�TP�Z��"�(�h1b�XDZ[+(�*�-V��k)��G�m�hG+"�"Z��`E�"*-��֠�T4��(���X��j�,MDV�FcU[@�b��ETTl�@����uj��EE��Qp^��܀띠v��I-�"�V�U�FEQ-`�E D��V�)���
  XFDK渰`\u�HhNjF)�� �z�i���p_�3�0�� �   `1�ZJ�:E\؜�;8=��C�|:r4�B8��E j��;��	�� P�k��V�Xk
���b��a/S15-������
���"�VDEE��,��0� e(ex�B"��"�"VK�F�X"`�)�����6�(�l�X`�X�(VDE�*������b�i�,R��������" ��h��"�5�(��a����
"���K��"�ŢU1��3�XAL�-YtA"JU��wD���5��Q�׋�_�QDQTETQl,�a�6(���
(��A+
��h�M�9|�hlEQAEĩ�p�(�iE@c��E+ ����P�p�*� ��&BlA0Z[��Е�
��ZQ-�Ec�mt(��* ��-�0U@�^Z�,5��X���H����z��v��<
( hk=iI�� v���%b�   ��  n�@z��& .bΙJ\�t��9r�yB�(_��/ �s f �� D$@M��EDl�4P��Ղ)j�QT��`�(���j��ִUCU��bQP�FT�bA�B�05E(�c���'#*@JF���Q�eEx���uC��놅%T��q�PpŅ�j���Z�
�����0�,1(D�b��؊-�:[���4`#���`�,#E��؂E��q�N���ƨu55�T#���,��� XST�V�*6�
�"FD�A����|a��;G�X`���� �"��1�hET�VTc�k.�n�I�Օ�"6"FTѠh��nwY�Ql�UTE�[��X�a�����+1Z���EF��ETKTUTATj�G��[,"�����Q�6b�i�"(��"
�!�1	��P<F���؈6
֨*`#U�WRޕ� KM04e ((�OggS  @�             �J�����������������۞�]@I�� v*v%s�   �E���� ғ�ę��SM��T3ő#q-�>�-U�T P,,0{�3� ���b��F�V�UAD�
��j�b�;0�b� �Z+"��U@1�"vj�������(�!��
�
�*
 �`"SLUDE� +�cYp�%D�/$"H�0҄��CS,�T�1��XEE����Elkj"�*j( �jK���`�[ �Ȯ^C�h1 ��X Dl�*"
j�!
�.h	��oGE�- ֊`@46 Xt��E0h[ն�
h�Y�ϟЩZ���b���j���3+��Dܙ��h0�F5VՠoL<DUEъF��건]�" �UAۍ����j����6 "X�kT0hU�_��3 ֪�m�EN-� (t�ѺX�r%#�tX@��� �Oy�sZ$�H �+]I��f�)pT�o�JW�#��9E
���76{�6�2�-՜s���RO���9�3��dRT1Ӱ�
���6���UM����)�V{���ni����f�Q�F#:E�""bX�`�-ST��5+bi�b� �(֩ӊF A�Zm���(:4bU5FE�hT��(EQP�Z�(EĪV�h���j �F�(
Z��(�FQT�:��E��ZUEE���Q@[D&����EDQ��j-�F�(�Z�(���hĪj�����Oٽ�>���7��FT�jQ%��O77I��y=���UAD�E#֪(�FQ���II���'Z�ZۀE�jm @ѡ��i� 1�´4�bҘ�(��:U+bDQT�:UD@Q�ZQ@ �F4�"��������֭�a���ii�D �41+6Z�
�Vk��VE4�U�֊Fl,��>�k+�ڢQ  ۈ�`�V�jlD���6��z%@��n�����z%@��n������   ���h:�S��#GS�Q�h;O��1	�rMQ� 	�P
	�@\�8R���	p$���bXX�biݚ�5�����V,El� @�U�Lӊ"���U�h"��Q�4�t������6�b�Z�6��ZQu�ZŊ�j�����ׅ�U����*��֠��UQK�DĴn`*��QT�[$��Q
t�h�"��h��UQ*��'�v�_(��1�*l#��m�jWs�jW�j�w/��"���X������4y��E�bQE���(�XQ5��f-����	�'NU�E�Q#��:th  Ś   � � ���U ���(Z��Q4X�a� ��k�uk���o�����	%`�h@����1���Yon�"��C@ D��PQ���n(  b�	���+�� �J�SڎK�0�V��vJ�qi&� @�:��L\�m0g���h:���t4ŵ�+�����Tb���"kb1X@M��ZEE�U5�IVP�ϊr	5�Y�0�YZ ����:��@�ѢSՉ�P�h�
bE�[�j�`UDETE�A �Q,:��h�*VkjE-MK��@�YE�P5LU,"���UUDD��ԩ
�5�ڪ"F���*�(�UTЀ�-(*�j8�����X�+�ѡ*(V-:��
A��@�"�֪��`�Z-�c� �U�*�XDTѪ�U����Z�"�"9I5g[ �X�������E�4�Q�zD4֨�XUEE��
Z�X�i-�����1�2ާL�4@-�ZZW�P ,Dl����"DlP Q4���1(���Q�B}��T��[���.�Ì,��������|�L�ƨ�ED0�u� Hd�ɦYMKLr����N۶ ���E��Zdc�v���Q��V�X��(�C?  YOQ
2�]H�t4g��j:��R͔�j�G��S͜I��T �V�j�-��"���6V�)
j��(���- ��ba@	�hU�N�h�*�A+���)�]��'I�hU��jtZ��!ŊZDT�N�"VV�� AU-�Tt���Q��S+:UkTE��h��\�cN�X4h�a�j�5"h����t�Vl�VE�h��Q�bYjڙC��
�kT0h���VA� 7^"��N,6V�Q+�*F���wkER�[D�b�-֡X�XQ4��bUl�]�UF+��SA+�"6�Ո���XPAk� 8;)�S���Fѩ�(bQ@D��  " �hT1`�Sըb(���*���̸��[k�آ�Ы���� �㷂*���"�j�0U���TO��(b�Ŋ���+@2@�V�"��S���A:   �uw�S�R �I�D��|�THD��q��  ����t��)�#G�9��Q*q9��"K%��� �]h�PD,��i� `���� �,(_�C$B�B�(���5�����Ś�uTUD+Zk�����1ŴA QS��a�j�
Z�֪T�NE��Vl�FQ��AU���i�PKĺa%�_KV�E���ZA�*V�SQŊ��
�EUubT4��
�A���d+��uU�0�QD�b��726�-*�h�\�Ӳ1�bZ��`E�����U�4�WySD�*�ւ5�P$ �VPPQ��X��N�X4b `�բ����*��Zt*�U�W�A�(�C�:0`��T����,�mĚ�� X@/k�őC�؊��*�J�y��6��A�"K��w�6M֢�E�	{Ɓ��"�m�s�]�4�>F1:U�����`�aS@  �:@�ʹ��7^Z�D���X�
�(�-�J���v�gQ���  �z�d@YSff��"��b�}�T�6g�9�9�J��A ռ`�$@�]�ZkE�Z���`*�A�UP 5E ��J 6�uAĪ����i�C�V�`-
��*:l�E'�"U�	:�"Պ�Q�FUEщ�`Z����(���i�P�f	- ���(��Z+Z��Р�Z��*�(�V#�؊��"�A�j��h�`Uh����"�VlPU -: �hU1DlR,��j�XQ���Z��"V�j��h�Q�QD���Q+�� �(�
�Qӥ�\ڊ֊E�5Z[�F� �bT�h�������!����G�Q-�*ZDժѠ�m�*V� �ZATTEQ�P�("b֊b�-`�`�S D܁u"[t����F���J*���*�A�	��,"F
����� 4��7��߸
�  ��-�A�"Ժ�Q�"`U�5 XcD��

������1.!�z5���z-n��z5���z-n�� �:2���u��{>��R�J�j:8�K�Obb11GI!Z����"b�  `�Ą�G�0EAD+�-����abaK����hQT�QD����`�ht�bD#�V�
��FE5P�FllT���b��U+"֨Z�j��U����j ��1��h�* Z"�VjZqOc�F��:ݥ�\"bU#��"j ]�u�$� Q/-�
�FU@D���j)�`��X[�� � k�d��N�u;]w�~��w�.���h����U]E��y���*� XQ$�茨 �hE�uC �0@T@Ec�*U�b��Zp�WvZo���㽲�&#���v[u���-V����P���c9Y�M����j �  �5@ ��f� �j����5 |�֪+��]�� P�^e�P[�|�9���Ts�9��t���ʑC.F��JB��(*5�  ��,�	I����bX�4��6Z�.��a�4��d`
VED�*�Z'����0����:�PЪ:�Z��QP��hшQm�u"��
FPP�F�`k��F��� ��Z1�"ZA��`�*`]��-�v�"�р��uLS@Q��֡(�
�:Q ��#�h�ݫ��PAc+"hE�ZĶ"�QŶ"�EUAU�h�("�ր���hTU���lk���TU1bUTEcU��Z�U-" �X�XQ���h�
�*"��"����)
�E�֪`D4`���""�EQT4Z�Z ���
bMQD��
��� `U#��Q�
�(�x���%�� ���a���(��f7�G4�U9l��F@E#��q�:|[-h@ +�aiW�T�����D �: 0�b�OggS  @�             ���������������������Ⱦj-�� �Zk 7 �   �`��s�J5�����L5��#�T;a$AТ�[5�0�CT{���PP i|"�
�,��s����(�aB��°"�Պ
6cUQ����a���P��uX��"X` j�Pê�����DAQlA�TQ,���""�F�VV���XbDl[Q+hEP�FѠ
��h� 
���`�C��AAQP#�Ģ�ht(��+XE��"���O�Ɂ(ֈ5"bUT*�X4
Ac��*؂�AQ�X�2�9��"��X�5*h�hU@E���k��)�e�Ŷ�Q�ZY$]D��":[DT� E�UQ�����E�Dk,Z���:m�bT[+b�F���`��VT��DTD�lZ�^�[����wn���Xu��G��꣉h�<��Y6Zll�Pu]���/���zϰ�j��(( �u ��J��7x7�R�7���   `߶��J�MG�͙�aN��J��Q�����$`�b��\.+�a!�g�\>_J��KQ��!jUL1l2�4M��nXXX5@5TUĊkV�X�V4��4MK�֭�jb����X��EA��FTAh��S�iE��QT�"� (�1�X�f!`*�
����Uժ��\�/��mAQ4��f��K@UPk��i�"��(�C�(�XD�*Z�mU�j�ZU��Q�o���F�FQmUEED �֨���X��a�Q�Z�V4�"�**V4"� �`E�ht �ĪU��TU���"(Q��*��δ���}�"�("("�bAQ�j�h0ZU�`4�"( �mjRi]T�H3�S��H�g����VUUk�`�U�E�(
ȍ���i����3���z.�l��8E�F4��hD�jD�bU�S��[��a�V`   �:�c7+~:81G�+��h�z:81G�+��h��   ���Ts�TsN�T�R9JE<g*GN'I �= ��$�P.�J�   ����D$������V��h�-mV��R�VQ�b@�ѡ�:��Fk:�� �(��(�E���6Z�b
���F"�(��������Uź���":Dt���UZE�E�"QUk4*��h������5�
��B�16����E,�N�VDkZ�
Z�X+�C�bEQ���
X�ŶUUT�U,�(V���*�*g
�"ƨ�V T�������X�(VDkѪ��UT��j��� +A���$Br.˖:r���5�(�Vj)�g_Ľ���Ѣ�"�7UR�����c�*h���s�3{��� E��"+
\)�uٟ�v{�*bQŢhAQU4�b���"*�V�"
�(X�k-XD@i�޾�阔QƦ-����X�"VPCL0Tm9P�_��9 �:mP�rs|�} ��A������   ���|sH5�9��L%F��R;888s��i ��j�ւ��E� ᱂�  �#!)�'B�@B�K@U�V�N4:kU�X�EA�F+�ZX�TTM�ºa���4,LKQu�������W}_�Z��+��3k��ET�R��>�i�`��h�"E�U����N�Z��j��iaa�)b���V#� �PA'V[�h�������X�֊�(
��*QEE�V0��U@+�Fk�F�XK�)��[�n�P�����"���*,�D�k��r��QȪf|��&�E_�	�oW[�u5O3�(Wǋ�P����hE@Ш����`: l��VB��Q;�;��&��q=O�\��Bhg�T��E�x]zw���DT�C]���M�K�F$�'�s�*oi��c�% *�VE���2�L�RjU48ji C�� ��RF�{�9�Ts�9S9rp4S9LG�&� -Z�U�ƪZ�b� PF�'%����`�B5M�؀--�X�a!��a�j!��bE�(kjժX�Z�0Ū�5K��u15�hUD��룉T��u��(
�j���(Z��j4FU5��UĊ�bQt��K�m����`E�A�XP�AŢS#؈FՀ-�Q-X�EU�QAU-(
VQ�V��*֊5�Ql����*�bQ�jtb,�FP����XU���-O���t����nEAQQѨ��Ե@�0Ҋj���G ��X�EETA+ FQ�U�"F� ��[vN�V��ӷUʼ&h�E����mЈj�s.�#�X�F���W�/��pz���ӑ$�G�3�P�d��@�q>�i�HL��I]�5������V��h�l��   �yՂ�^�% �Jeh���]����M�24�Z�.AC���  P�Y�,���` i�9����R988,��R98J�(U�$@��� kT��bD�[;�����ְb�i���0EL� a� #.!ţDTբAkt��(U��*
:�*���b:A�E�"VTE�hD�Q-��T��TEՈN[�� �N�VcDъj�FĊֶ�
�jEEt"ֈ�a��h�VTE��* ���FEt("���ClUQA�h�jP,�j4VD@�QU1S0M눢���j!�b4Zc�U+:Ū��j���Q�
�*"
V����H�h�� 
�VT�����,�_���k�����^��r�U��Z
��D��T����
�h�XU� :mc-���)����tH�*"""XcD�t���"R��*�rk���@UD�N0VU#�X��IFj|ݕtU���F��Eс6"�r��V�:-P��Q��#�kM�JM�p���pW���s{X �   `��s�9g�T�3�#�T�R1	�F��@�j����i��  ������8% a��R�,T��	�c�jְj��PK�	b�`�a�6Y��4hT[ck�k�"��a��bX310U��Sct*�m��-Ƣ�6��CAEUP5�ƊN,�X'Z�EUT��hu" Zkl- Z�mĢEUElTkQՂ��*
-���`�E�bDQm�(
1:,
E��ֈh�VTQPň���NATEA4 F���
����NEElTQ�*����F��A�("�jQ�fg�b������t�[H��Q���}���H`�APD�SlTPP4��(�T@#��@�\f�WE�(0
����G��uTB�r�y���͏����Z��s�y�AK�	)�� b4�%�Z9E[�X �8�� `D���_Ϛ� � ^ZuD���pK������ �   �� �lgLG��s��L��тm:rpH�*�&F�����[LðV��lm���^Ll1�L����T @�ťX	�/H���_PL�˷�D��j(���hPDUE4��XU�
��C�QсE��C� �V�ZUu*�b�>���(�:@�V��U��6�QĪX���5�����`��A�����@U��hDc�1�QA��Ѫ[Uk+Vt���ED� �*�T5-� ��XSPS����
*j��
�(��E�5�� ZE-� �VP������s\S����hEU@�"����٨1"���
�El�+b���mU�f0t ���XA�E�5QmkTD,��'U@Ţ�h%
[��@^���Y��
�XlUA,FKԯ�j�cA�����"�F4),:P㚞n!***"b�UQ T �Sh Y�cP �j-���5�Uk��|�	��   @��M\s�9�L���t��������Q�]�Bm#E�
��b��a� ����|��P��Y>O�r���S��V��5��5�l�VAD�"��uS4Z�Z1ZE+�j�X��ai�bQLk��a
b�b��&�u����AE+����r����51TL1A4�(���Z��(�*Vl�
l6
��E4�U�Z�(�h� �UU#6Z���`�QT@��[Ċh�*�VmE� �؊���i#
آ b��b�`lE�A�(�Vtj�������;j=�`D�n%.��5 6� TĪT� `]@-���*� "��`]�Ru "� �@�*�- ��}�7��� bP1�P���j|�Z;��arT:yɕ^�R�{�//EE��$��`@(�X��bĈ�r���`T@�V0���OggS  @            :���������������������Zm�! ��j��� ��   n�@�ܦ��|�3U*��j�&&���!U��I�� �	ؚ"�v������a`(���*�l �+,ė W�������8#!(HAUEѩ ��Z�CU�(������jͪM��	��*�
�"�hQQE Tkth,��jT�X���:�m�)��5US��5�ZE'`QEl�ZAU@��h,"�*���X�bT*�k
 ���"�uSUT��FDA�`P�SVDb���U�bh�%ŗZ��Rg�FA���P���Q�
AU5"�̑�bZ�DTx�Z�U?�<m"����Q�6A,������NTEsy{��*�جb��vQ��@QS4:���9r}|�͚�����mg^��h�����#D-��X;B�w�Q�H��ؠ�@񲄤~��ա��(�`+ 
(���l
�
P ^[q�Y?����;���4��  2���"(����v�H5��m�tz�͙J�A\������Q*��b$@M@Q�1�c��j/�XUU�l�1�kc�*�p�+)JX)�a��F(�`ŠhU
��X`aZ����TSDET�hEP�
��&X�S,MA�XUj���ؤ��Z��D@A��*Z��`��"(Q4Z[SLTMUS�4�\\j��*��SQ��(�`UST�0U+6��(���T�" �*�EA4*:�*� ��E�hTP[Ū :Ă1 *:�(�VQQ@D������+:{AU�A�����h�]kvv=R�`��`U�E\UT���� Vm0�+������j�X7��z�jx�A@Q10ZU0�� ��6DU���A�X�����8t]v�E���oI�S���_ֿ��|5�i��XQ4��P0�X  Q� �K� []���FرՕ��`�� �j��Id�"P["��[���s:J��BmNO��h:z5 ��T�$@ j��Uk�Uc,F��1�X�����Y���*c
 ��i(
bc��rEńy|��X��FK�A1P�ZTEc+ZS��T�VU-�X�աS�ZUTŨ,�h5�S��Z��QD����NQ�� ��i�h,�X��U��V#���~)S�h �*Vl@,��El�U*��b ja�V--��V�BL뢢X
&
Z���"X �P�UT���#
��N�K�YJĢ���b�- FP㋏�X,�P,ZE��V,�%�"
X�Z��ˈ h�XQU4*�MUPQP�X��� 6�(b����:M���U1��+b7|�$j�+���։���F�D+Vl�**�CcɴOFl�V��X��� �� �d�>�ٴqA�v9]���s k�}�p37ֺ��"f�   �ۂh!.G�tz~�t�h�m U���a��M� ��#11�Y@�@RS-���bAL�bZllm��* bX����6���b��������EE0PQ�bP1Q��rE�1�K(�Rq����p)���ժ�� ��i����t���&�-�4������차X�N���CĴ�0AU�PP-VmUQ�AЪh��� �jUt��6LT5L�4�!RW��UъN� VTİ��"����5VEDE����F+ZQ��
�Z"���j~kE�U�.� +�EU�X�h,* �"(�XQ�m-����1 �����������M�b����� Zc��I��T� *�S��"���"kDtg�&�]�r�}پj�d�0�Չ*A�X�Q,b�����X���A4XA�
��5PÖ�)j�g<��X�-�*Ta��a�  {=R/\Q|�(���(>ia�   ��,  ;�f.,	f�}��!�<��6�/�.�T�A�0� �F h� �B��v���ŰX1
 ��b
"�iQ�SM1��a��**�=��a�)�	`�+�A��r�(,�,�)G�2�JYa��P!!Ii<JX�R��RD1԰[���	"�����{�U:nT�X�"��-����"
d;҅c�1�5V,�D�(hQEE�*�����FCPQ���ڨ(��
�U 5-���C�TML4�A�X,X�A@k��*�b�((h��j��x9��ZU@ ��I��V� (����"X,���-lV��R��uV^�Y�LlDPAT���bŢ����
` Fk@ ���UQQ�t���Y%K�[�|�1�#։UD�5`[+�� �kDU AP���	�6 �iD$)@[oH��� ( >�=ݔj�n�̞͞nJ5b7Pf�   >����� ��h��ZX� *��҅���"�\\��7P� 	��S���Q~�%���$ j�Z�`PcQAEĨ`ŪAŊ5� (�`�ڪ����!*�`�EQCU�+X�Z��E,v �	j����&Q5TL� jggcU0(V `���*bg��
(��6&
�����R.GTD��J����� X�e(aD� U�Q-�EEC���6k�bQQd���˻���	�j�� �y��&[�
X�QT@�`t.�W�����6�� ��b0t��XCDEŰb�.�B�0��[ՠ�X �(������@�VDP0��`��*�6�Gh�F5@UTE��  �a�Њ����#^��&)H ��&��D��8�sTi�j�� �zA� b#�U D�**�u�0<m�j�ze� >{}�� ���[d�   �� Y�� <H�zkae (j��Ip�����;���-�@b�f�|��QO�JR9� � hI DI���٪a�j&+�b�CM��`�XUD� ��Q,�Q��6VTS �XMP5D���)*bb�"
j�������
j ��FTAE� �� QQ�; `X����%� �4#IA�#.,f�bai,1�Q-T-�4,�D�bA�-(��+6"*�N��jUQ�
�Z��a�d��[-b��FDԊa���*���6[(X"��UT�����Q����5��N���b4Z�O�
5TDliUP��j)�i!`T���D �ZA,`�u0"bD'ت���56�R5MQPLDTmB l`�����Q� Z�6
���@Q���E�*.W	D4F��� ��5E�*
`c�� Vl��PPl�&
� �Z �5�� ���Q ��=]s���N�1 ����������$pZ�Q��   �    } �T`��P��_B=	�3Fr��n,�H�	��H�M�����D 5 d�@i[@dP � �aj*�`*X0���X +� ���U����Z�"*���` �
�`# ���E�F�*�b�" ��U �Q ����'	
 �ዋ�  ��(�@ �(C8  @�
�x @��- �f ��  T���& �5Q Ŵj�Z�:t� @P�`A��j ,��KSk��E� PF�t�O�����X�� VTX}�6 XQ��@�OG�9@� ED �)�l1@�aX��������S U4��l�Z �1aXT��؈NF��A�- U�-�-�@Q � ZA �  `� P�h5 0�� ��=�8
��	�cI���)�Q��NPKb��   x�@�F  ��  i�� <� .L&����~�Z�R�R��ۛ�	�E���$ �K �h$ VE� ւ@dP0LP� j� �*��b`�*�X�P�
(���(�=j�1M�PP+j��&��NU��`�ZUA�(b������ۨU X �3 P�2<*J 0DRBX�����,��PJ! �RPB	�`@ �!! @)41X�D�E��X�ب��H�֊�f#�`��lP5��fЩ�b� D� ����Dm1�f��Q�Z��"��N�Xb�m��ULlP�
�"X�f ��� FՂ���f-�l���������Z� [���)����wTքc�2 �b���y�`AD������  ��b@�
�"
6� 6�S�@ �& ��!
 OggS  @D         	   �`�����;GIIJJ�p������������ޚ=�ث���$��&�/�[��{5�=��Y���E�   �   ���)G1  ��PO@� j#��/l�2 j�9���j @p��,p�[�^B?`I�$ �m��� j  5 �X �(V�1� ��!� ����"XE�
��ؚ�*
VAQA�*�aXQD�[ �PEUU P;{ E�N��� �_� @Ya  �g9  �QQ.  D+�� ���`	 �X� EL��f���j�Z5L��A@0,M���k�MpG�����iKQD�F�* � ����E���1�
`�"F�Z�`�V�$�+�VZ��	V ��@P�-�� VT���-)6[h + Vm0DMEU���b]5��b��X7��� j� ��w2�C]�P�"Z �
� �"���`Z����"��
�� Z�b  � �0��N ֙�pJd?bd���v8�2��1����   x�����C$@�77,�p66�_��-���ha�;J����Nw$�0�'�&Dm
�$ �� �hfdT�4���FCPQ#�1"���
�"*(�j1"" �( v�"��Xİ�TUU�
�UMA��!v�!���iUUU[[;�  ��X�P�UUlԢjZAUm�"���b��XTUU�V!�ÓdX	1	))i|IH�	��|� _�+ b#�l��@QM�[�����N���i"��aź��\zb�P�f��М�q֩(���A5D�B�Қ!D�Z��# :��0��:���0`��� &�Q�L�:nS�b��ji��a�(`�i�ELQP[������`Z �h ZQ� K�$\�0�߆�V�"�h1VA4*@Dt� `�X�b��   Xtj �  :�a�� �ZM�☔X��@U�r  yc@M *,H)��C_5NIUh�б�_X@�AVR�,[�5 �jC!���ՆB&�{�V�@$$� Pk�Z+�E��UU�3%��V+�E�Z��FPE�lA�@��Dt�Z��^e��^E$�*#�*"`�d#Ǩ$ N!�gXF1����(��"Z�ڝU�"�����
ZV����P���hV� �Ne.a�J�TF�����23#m	2r2$��jD�Vt*�j@[cQP-Z+`Q�QEPA��r'���ud����W�) �b�պ+��N��2�uWԥ��$FNFN���
q�<�0�b]4��wOi5� �*b�;�J���ͮ���Е�[���jM`k��Z�Z�*��-�-�Ȅ���ɐ`ժ�FUu��:��/���ТQ���X�`��в�e�Ɏ��t� ډUp�N9�N��;�88v����   ^�,�ղ&����0�rp�0�r������mU4KB %�1jj�
 �Ǖb�Y�r�R�cy� �&(��skVL�6X�6�de�@����#�؊�� �VQP5�m���(��Vg"�`AU�j��"���D1Z-�jEĄ��""�,����"Xрؠ� Z�-��
p\�q/�a�bQ ADQU����UDj'(�U�V,Vw�ܑҋ?�k��+�(�(F���"�V�Xҩ5cY�i �� b�1��������,�JVf .�`,�j�  t
b �� �*@DQD� �/������@׹�~�۵(#Ғ�� �ܔ�^�-���r�@�ne��	�  �jt�;�!��Z�@�iȶ|�  Bk�͙���tp��a���Tsn��1	�	@���bؙ�V �0<��Y����i�f���`��@Ű��C��� �Q�Z����jT�("֪:DUT����U�ւ�Q5`A �hQ���hU���P�BLkb!���aXt�������EP,V��Z�QKSM�°f�bXCTUE���
r��U���h��VU,��р�Ec�b[\�N�"�{g�v�T�9����(
�FAk@+��b�؊�QTEATkE���E����G�S�U�����hQQ��F���-���V"�BU�*�"��(�"֨ֈ���*�yyUUU���P �F��  �F@�l��D- �U4 �U������C�.%UUlъ1
��Vml���F@*�U�iP�I@� �� "ȫ�0��� `���@P^"��$�Zu���U�Z�V�WX���X��7 ������B
���9�L5SM�T3��m��y*�T3�#1�V�l�-6�DP+C�ZT��5�
@	G�ϊR����a��i���h��Z-tjt**Z-b�U���(VU�b��ZU�UEU,:��h�U��:E+Z�T��V�h4(,:Q4�N�At"
:�

ZĈ$*�(b��U#-��V�����+("V1����":�"�jQ5VP�XD+*��'�,��j�j���fn�� Dc�j#VT[� �V��kU�+��>c�s��u�X+������F�0Ӛ��"�"`Ŷ��UQ�X�ZPT�Q @`�J��u(
�`E�E1�h-��`tX �����&:T�`���$ �կ]].��M_�z�Y��p,���(��5����-�V�b  U�"(X�
�jU��A��]m�`U�X��}��
�v�$�Z-�C��P>4l���j!����a#�} L�"�&E0�MG�R9K5g����R�/�`1 �2E��b���jo��b����
����� �Z
+�e�$$Y.�PS-m0������FE,�Ft���-Eըb�
�(�"�ND�U��hP+��U�n��iXZA��5�bDDT#hсFѪ֡���51L,��
(ZQ�E4��ƪ�(F���h+�U4���+@kE[С��"��#l���P���"tq�WiY0�E�Z��
Q-j�������[Mc�XckQ���*��� 4Ɗ�X+"�QTD�(�بX�h-�*:�:щV,��� 
�*��;Ut���5֠�v�q��7�0���T1����B ��� ��U�F{���U+T�膍���7�u�[�#w�LR��vkM � (#��"�X��$�e�`���Q�x�y`�d�+( �Z����a���a��$�7 @;M��f�m�s�r���ќ3w�j��!U*GNwp`&A�B��-���^mث�-����V�R�8 $$�!�bXZ��*֬�V�ֱ��a)��*���(�V+�+k�:ѢA+��EEԚ�jL�!V���uC�b�a��Xb�El��Z�Aѩh�*�FEcA�j+
��ZE� �F���X>�u����-8�*���,:D+�.������W��R�bG����B#ՈNE,�5ZTՂE�"��V�	�U-":� �1��*�bT��hA������bk�(��Ӷ��DPň�`)j�B�����'1%:�`A�FU+ZE�֪EE�BZDXD�1bEQF��T�Y70ê(�������PP�F��P'ƂQ��Z.9���Z�%�*�DTS �����+�L-z"�:t�D�Y�p{9z<� A� �Z-�<섨�{�� vBT�} �O�j"$��L���!՜s�R�K\��rt��R1d���b�!��aoo��Z�"֪`��P����V��,#�A$y<q)�:E�N�Qt�����1�"bk�ҪZZ3�j��L����+aՂ��*V���Uъ�1��-�� X�-��X0`�TQ ����~#k�"��k����S�:t��L*Er���*���� �%��;�UE+�������bE�"*�U�*�m�h5�؊b�`k�)*F�b�5*6Q4TVQE�E���u���b�"`��bb�aP,��E�"
���7]�P��UED�h$t�{>�{��"Lk"���((�*�TÚ`Z�bغ�(�*�(�� .7$0*��Ѡ`k���h1¤q���V�&!�#[Tź��j]��r�� Z�`�D��fudp��-t�u[m�~���զ+�7h�� P�f$Q$J�>�}�<U�Ts�}ι�T{*1��@k��5�*���4Q�'�,UԪ-ŪKl�b�ԪZXW�S�� *j�Xk����V�FC-LDDkU����FZU��i�5ZE06@Ӫija����BT,-LU�1Q�*`�"���TU�ŨX�F�h�`-� b#���bD��mE��� ��ED��Һ������ZA����>0b�b�X�{��(b���F{|���X�6����VU��V�`��
F�"UU��Pl�`P��@TQ�*Ѡ�Z1DL���b�4���51M�"*����F��(P�jc��*֡�QU��b-F�:�Xk�
� ��& ��*( ����QA�1(������'������˽|)�v~�s7)��X���*XX�UQUQ��1�1�
���U��� Zx� OggS  @h         
   ��{�������������������~{]|)>0��^_@�� �x_ ΄ŶOGӑ�T�f�9眎R�9/Ƒ�V���ښ�{��!���֢jتUUUC, X�'"H�YAQ.k�Җ6��
X������Ut�&b�4�b�
XQXĺ�`U,źb`aM1���S�`���b1��(ZU���Z�|"��*b�+hl��FU0���U(h,⾽,OT��E��ͬӥj� �* ���伨�s����ՈTXT�F'�=Dqs��ъUƪ��AU��#V�Fk��H�V D��m�X�"(�
:P4�hm��؂bt�T������jA5��A�hD,�����X�XQ�h�QX�� ��E+
�FA��_�Ј��"� XT�(:AUpE��-�[� E����`��E�b�j0��XTQm@DT4:�j0h,�P��D،&����(�A�5�J�FF�+]}b��+]}b�����S)�J]r���眩f*G��Ts�LG��N,�� AU�(XA-li[`iii"���U����Z5�bZZ�DDL�V��º*�Eł��E0L�*�TKCEl�AQt��� *(��谨:�`�* ��j-ՊQ��XAD�j"�1���B��k-���bU��X@UE#b��b4���"bT+FTE�b@�*��b�hPE��Fē�u�@� bE�X�X+6X��1XA+��Nqd��uYW����m���UnR(@TЊU1�XADPt�[�a	[
j��b"�a�V�
�ii�a� �X�
�U�:Y��W �����
`�U�A�"�ED�b+blA�u���'ma#���1�F��j Q���P� `@kA���#�t���p�P��:* �Z�ҹr~2�8��`[��W5�"6@�q$���5�G �:�d� ��t�/ |? �� �f�&��osNG�vGs���ܷ����0�6 	#�U6!bQ�E��jkkŰ�1Ŵ��PD��D 0�|�&�qX�j����(�ƺ�������Z3-Ċ�aa�V0�b�UQ��B���b�(bш�X����V�ZAQ-UTUE�jQ��b�� VA�*`-+�j-�VA���*"NU%.�h�EA��1
�1VPځ��j�F�PL�
��}�"�(�*��� bQDQkT�U4QTQE��lD�E�bl�QE��"Z�u����"XA��FUcբ1(
"(F�1t��P�R��bi`X�ը�*(6�* ����5L KLŊa)"b �jبCU4"�"��"�CQ@��(b��K>��h���쿯�G��kѮ�
�7-:�(�QS9UF� �5�Z@k�Qq���l�|�^0�,ZQPD�4l �TRO� >k�}�#ެu��D�x?  �T�)�)�DD!��}��9��(�����h��R��I�4d�
"VEĈc�1֢�j�"jo��*��ب�� �aA �P"%!$��
�V,Qk��jb�������a�����ZGkPЈ�Z�K�*bU����**(Z��E#��( F�4��b����VQD����*�"�VР�(V����A��,��*�֢|[��?�1�bؠ�����
"`�A��5�*" `0���q�Q���)0�`E-��CSt��揚��Z��|qH�L�֝6X���*������`��!��_mW�
���t�"���,b�`,h��a("�(X��"6
� ֈVkA ,"��F�*��n�������E"� Z�` H+�i)�I����h ��!H��ތ�bA;/��QT@A �)�q >K]]��7K]]��� �����[>�t�;�9��(�ӑ�tH�/X�$@��bQ�������0EŢ��Vm���4LS�1D��^AQ1U V��rx�� �&�R�5`����b��a`���X�����a!�uT�"�hѪEATPU����ZDDSL-DUU���N�(-�jРj-("��j�(U�Q�N�(�P�h��b�`E�eR���jUt�(�Z�b`� �b���i�0�P��i)k��B-�*���X����Q����(V� hU�X#�
(�ֶ1�AD�X�h۪��VEA�с�cKKCPK� QP�����_JUǭU��FĪA���Z�Ѣ1��TS,l0ŀ�U�Al+�AQѢ��؊A�X+VFD���|N�ԉ рU�D��E�����Ĩ��6h� �qeFQ�$�4Ո`TA#�l�o�j��&BAl�
ja�%  ���M� )�
 k�M�D�����@@�� @�Y���	jP�6wG�<[ ՜s���6�;��R9�9�I �YAQ�� kԊ��5j1֊5&������Xi|1�)JA#��hEA��D��P��E�ðni��	�`)"VEUQPE,
:��� ��
�j�j�
��U'b"

�X�4QQ�,D-ĺ����P��A5Qt
��+V5�j�h@A4F�h�X�,Z4�
(� �5F��"V�E)*ZU�*V��Ѣh-X���*bE"XՠUDU�bk����4���(��jE,@�bQT� b��5SDU�T5�Dm�PCT���zQ��5C,T�SEQ,�P�"�V����iX�B+ ��5bĈ5QKQ������u%�1bEP"�`0�(Z��Š
*��Ap��%�0D@DP}����?g"�U��>g���C��hT [Z@@  ,��>k�c�H�o�:��D�   �-T�Q(���o�f>S9r��Q>�ӧ�X*1�|'I�VQ (�F�5� j�1��E,�jډ`�2�|Q�0�#��Sa��%� ���	�؀������jiX�5EM,QD��:��b`
V�+�1�b`��`�`b�U,QU�TCU��ºa"�Q�4:D����b��ߺ�{*���-֠A E�X����Z�
��XE�Vt� ����XD,D�*�ƴ�5��_G,|��РQq:�^U��*�b�XUmQ���hE�|{���סj��XT��C� ��AU1lBE���hm�XQmն�bl[tj5:�F�:QQU5�@�AE�����U�blT�b1��y�LE�,RC����������A�VР �Gn��I�^-X�%r��~���fo��X@# ������ ��-Q@@@�Y* k ~k=S� ��z�� �  � ��"�j�@�$ 6-�}NG��s:Ju' s�3��#�T�v@�f�jU�c���b�1ւZԪbX��V�N+(�UMC�Ī*`��(��� 8<*&!�HPUQ�Q��X��u�T�`M�.�(�a�U���FXU-�VD[����m�QD�Z}%�K4�"�U0h�hՈ(��;�#���ש�a����( X7�LS10U�0�:n.�i�R��"
����"��`Ŷ��CA�� +�VUU�E>-����@�6��FQP)z�8~PQ�X�` kE 5UE��b�!�Z(�b�5L��)"��U4V�F�֩1(� TkE� "�6���Y�>$�?dR�ƓB���H���@�i�u2��cq�+�t�� �m�H��u`�ha 1�@A�Y* -0 k�}�)�k�}�)�� HHB��%.���/c��M\g����<@`۝�t��tq�$	�l�Ģ��j0Vňi�؂���Z�PP�C�5,��DAClLUE��/�e)��8�i����-�X��TPCP������`�i�b�)b!�`���6����(j	b����i��b"��ul�E�FQ4UL510İAM1QECŰ��"b�Z���â��MU��B�`kl�X4������H�F�D+"ؠ�Q����ZUE�(k,n����UA PV�F��hlc�(����U�DD0�0USź(b��EQ����*���"�����-@UQ��ADm��7II�����b����ό�&*���;�(�����2HJW��In)��b�
`c@@#�Q� -���5EQ��;-�TAm4T 1l� @��: �U OggS  ��            Z�J���7<5::=;NN�������������z�i�	��kOc�H��   �"�z� j�̕�m��N�m�� �R��� ��9��bb�)s�`@D�hWf� �Z5֪��Zc�,b���ET����6*��� �����UԢ�؛`���
 �i*������ _b�����ĥ���W��p��5�j��0DPTQ먉��!Ơѡ��j� 6bCD�6��"�Nku
"���DQKLSmD�*XT�6�X0�f`XELLź���X�4���j�u�"(� "�!* ȭ'w
-��
V1�
����;DDP�b��"h��ƊE@�
E�FP�֪���t�U��l��`3�j�*� ��XE��V-��0 T,�f��6� ֩DT�0ED[�6�گ�4DA�j"}v��M�E�8)�v%ܧ$���EO�f�m� ��0  42\� A - k   (Z   ""֬�b � �fs�8���t �e�B$d�c�1"FmԮ�I׿V�9�5���6x������vc#t-a�ۍ����� dZc�M	RBD�OY�S���m�L�(��v�_5牛�5m# w�8�=��$����Tj�����! F�*�,�y�7�Qu<{�(��+���h �jy�\����T˛��l��cc�
�p����!�I��;���
�ײ��fd �r(�Ra.��y�T؁ihށ �Z�@�D��g�C=���ZA�������'����:
�fm'5s#{9�l�vR37��c@N�1FU ��8�3XY��Y8+�����)6x�Z%�o{wy��ӎ�����N;�����d0``H`���|Q��ֹ�u�����h�<�=�je�膕c9h�Vf�nX9&��~ AA�9BZ �B�|>5��h9o��ZU���Y�VU���`#��֪:bqS�7���RU���"̈�KU�o˳�0#�-�-B�m������VA�5F+X��k�b-X+�ƨ:A�U�"X�]�Yr�!	$�A�e�	E0����G�ީ�`��	d���   `�s�TsNGs�r�bbb�Ng�l��� �"# ,GPDCD�$+AXa�0GPT�rE$y���bi�PK�6ZW+�0M: ""�F�X'kuh�A����j�� �+U��UUUUUժ(�hU4�EQ-*b� �*Q�Q,:,:��D��UE���UU��-Ŷb�&�蝹hQQDQ0����-�����U�ňVU �����ƪEDU��ͨb A�b�"b@U��QUTk� ����ZQ���`Ѫ��,":Ql�!��Y�m�͋\��CkР
��(�Ġc�ҧx��8v4�j"4Ħnn�B.�����W�"-�sb��a�3�*a��؞�`'�5�4�r(�g���K��I�,_�\����:������uU@�hqT��������L.d`�zEC&�0| �'��ۜ�6�L5��tp���S�rpHE�� hm�C�L;;1  T��rDI�#h�Ԫi������iib���Қ����"���h��X�a�
�@A���1-����*Z�jm��j�b4�CDQѩ��ڊ�UTU��Uт�jE1X�"�A�b����ժX�*bE�%�X35��u�R��ai�B�ZC�N#�UU��TU�bъ�FŊ":,E�"b�jՊhUk����hUD�谈V�)���Q���	�*FQ-*� ���r��a+
F,hQ0Z+�`�*@�u "F##��V�Т�
�<~+C+ �(1�Z�Z��;�r��?Y"'�m�x�-�b���U�VĀŢ贀�� ��O��U���#�"F�F�/ZU�C��j��Gꬒj���{.�|e�r�U������T[Et�iH��%ZY��ZtS�:T{t�& ^�@��MX2�Ҩ��n�0�   "�DEm��-�ќ�a�T�a:J�h:�s�ʑC*&Zjdi�TD�"c  1JD9���5��aXX�&Vm�b�B5��4mR��j�U1�jU�St�hU��k�*XC�bX�aUU�A��ZE�*�(�V��"VLo{wGq���֡ Ut�Ft�"hD��A�U@E�Q�`c��шU �V��b� �SED���8�/g���9�B�*�"
V4U+�Ţ��V�V���ED�XP,�*h��ŨhD���B���hQ��@EU�E�(*�"��u��t��(�b,(VĢÈ*�|�濢 ��i�m�j�F�|�U	�*X@�E1��؈��(���?η�e~b+*�h��MZ��/3I���]����hm�� j���7� �q���
�hI�����$���6�02rt����&ۥI �I%��;(�ݤJ���~ �e8k%Ɯۜs�9g*�T�f*�T�9�L��E$���մ7-b��ڊZlm��� 	¡��"<�ԠjT�NUtV-�� ��Nt�VtXТj+b���5*�EU����TLKE��&X7�j�ZE���Q,֡jP�6�((":U�XA'��`��
�`4VTE�F
 �VQA�5���X�:QE��jU�jT�V�X,ZŪ�E,֩* PTU# �hňAEը�EQTQ�(Ѩ "X4F��h4V +
��hTQQ*�4wn��?z�~���):��XD�5�ѓ?Ը�8KD1 ��h�K�@E@���Z�b����@+�Jk�/7}��m4�D�2�����`A,F�]��ܝ$9�D�"��`U+Bf��kg�Țr�r�X�`[�������*�N�
�h�� ��"��V=�,�IeJ���ݤ2�@�D�~ l��s�[>�9��m�T�����RMG�Rm��B�2����bog(ؙ���کa�`/��b��  �4*	)H�,"�a��bab�a��f�VŪ5ŰԪ���AU�jUEDA��5A�`#�i�TQ��X��*�XlU��hl�R,,@L��! ZXĊV�*Z��
�u����`�uhEEQ5Zň�(*�h�E��"F5���ѨFT���(��(�ik����h�"&�"X7�R�RT�5�U��ht*��h�D'
������QDEUT[UT��b�b�bE��M�����Tk�F5Xs'1TӚ�j�ܩ���Ũ�V PCP낉��8Ă�F5�h�s$�t+��۔S>S�1� h���]�B@kDPQ�P�`P&��}�p�ڷ�:�Nъ>�#~s�b���QE �j@����p�j+���V1�cBPEĚ�!��X D����=`^Zu���E�ҪC(�~  2�>���ќs���aw���t������acH�F�$1@,�;{+�� X1Qq2��T�DlVk*"�u���C,��iU�*��"�j��*t��)�5�X�N�f)�X��!�(+(�X�jEщ�������ZUu*�+釳˳E�(��h�$��C��� �-XTբSlD4X,ZQ,�jkUDk,��V��XXѪ�EѪ*(ֈ��QTQ�DźU�PUc�hD����1(�"V-�bE'��(���ZЊQ���h�P��O�����&QG���6[�b�����
��Z7�|���(�Ũ+F����NȦ�nE�����"�� :Q�b AT`�`Z$���"؀�E��s_6��k���G�J���L>[�(�m���G[7�N��Xj��ڒ6��c���BBQQ[�  � �� X�j�^ �j�2��[��j�2��[��   �  r�|��ȑӧ#G��#��T);�@h�R@����iX�`�bg` ��&�a9��r8T�� ��qV�JR"1F,-��0U�Қ�Z� TԴj+�jE�"Z�D��i����(��jE���Q�b�Ŋ+��VT�FTAU��Vl�X4�U�A,���m�ZD��R.%�ЂQ4[E��>���5����1k�b"j��|%�qVQPu
�XUբh4ؐ�s��3F�lD���ԇ5�
(blPZ�4I��-r4�"6X��b���1�솕�آ���X @PT�	1]������b��-��� ���VqR��L�}_T)#Yˊ��zA�^[Ѹj��'�r4]�_r=j�9k�t���j��[�ƑS�j�O:l��P�����]9��6X(�� j �B OggS  ��            ��I�����������������оZm����[�6�@� ��  ��A��.�s�s�|s�h:�����M�!�C*�;IԖDS2���QQ�����abbc��� �0�����30@U�Z�i��:�CTPt�*��F��FE��5*b`Z�K5KKST1U�Y5T,Р�VE5
U��Qm*"VET�Xt(�Ɗ�"���"����U����U��"�Q@AъUAQQ-���U ��AU�5
�b�	��`����1LUEP0FШE@�݅*Y�N��ZU@ъڎC��ڊ�4���hU�� Q�(A�Z����&y�DD�F�P����i�b �� ֭`��ڨ�V��֨b�� �XZ7�PA���V� "�� 6�)�Gk�����	*�5�U%D=ڡ�l����Rw!6֪bA`y�
9s6B4��S9T1�� "Zj��ȼ�wuY"�5PDmD@����p:@�ـ (� "6(
HVKe�/ ��QV�� �� `�H�DI�y>��96Gs:ݑ�C*G�aO!��*�v��6�a���؊-`T�5֨1"�aa�/�+�g�Ŵ����%��MKV�X�j�Z��0�jT��4ZT�UE�UЊ�D4�EQ��S4Vt�F#&�b"��i�-�iEDQѩZ�VQԊ!����*��*֊ �X���֩ �Q�D4"��EE��Ơ�a��M�4C�bD�(��"�`�i���*Z�(��آ���b���F�(k-Zc�k1h� FQ��"�bE`U�U�Ƣ����t=U��D�q��vd9sq0[�*b��bUС�b#Q�2@"*��AP��h�jՈED�� �1� X�F����1AUI�*�����8jӂ-�A�&��L���� Mެbr�^��� ���R��
��UUl�VE� �VTQE,ƾ�ѭ�D,QUKlB @�AQ0���S �jd��E+ԏ��ZY��F�
�c}? �����,9 iι�9R9JE<�9�N<��80	�
�`�ZcEU�#
b�bêP��刈��3�0+���4T�ba�+6�V,�bkU1 b۠ѠQŶ��Պ*"�(�Z4��`���(ZŢ� 1�h4V�jU�[ZZUQ�5�jЊj����U�*�������X �bEЪ�uj���QQ�VQ��"
V���X�"�*��g�~�X�k��R��.�|���"VP�XM��`[S�+�؂F,�TѢ�Ɗ���ܴ^�����3R��:TUTU�*E+���AUVsm����V�Ġ�%�, 01k� �1��Tm @� � ZU :D� �� bX3i;I�,��T�D�m*bA�hQEk�fW������CD:@DՊ���@i�V۶F���h��
/j�^h�) H��Z��SڎZ���^�vJ�Q�0��   ��,�e�2�9���L��ĕ�Q*G���(���X*�)&F�RB #�X  �����%`��DYi�b|1A��bii��P�,�("�����"E�EQ+`UD���NQѢjD�b+��*c�ZE�êbi�5��b��Cա`�h��P�XZ`XUAEQJ��C,�贈N1��UQ5�ET@QA�S�*`�h��_�Q5���E�+(؊V�Xl1"0{G6���"�X5,A�K�j�����䒈Qe4�XEE�aE��Z4bk�	j^i+lG���
"ZET�hЁ�"Z4� "FѢ`�*(��K�EՠS�@EE,P��lcƍA �� F�i�V��^y���X#��W�q�ʮ�'��TbG�E�܃T��0��j�E|�g�-F�� 6"�FTyR�*��ɉ^K��ӫ�	O�_-ջN�:.$<)~   �w�j�@2,���MG�!՜�aN�;Jq�0�9r`Ȗ
�"�D�
�jko(6 `��  H�R*&�d( �ǃOJ�!�(�V��Vc���N4Z�(X�k�Ct���*XQE��VUU��(�	���`��*�i�kP���V�X�������E��
E�ՂVUD4�N�hU+�U�PIvܠh[t �C�V�C�/��4�؈EkQTkĨ�(b�b#Xe�h���Ѣ*�ZQEu�G!�Ơ�E@T+��V�QUkT�(����Fllc1�Q,��hP��Zk�C��NkD�����֫%5T�h�hШ����ш�X�Q�b@ U� �*UUEDӚ�"�A0�;l�N�+�X�jE�*6V�F�T��7�VDUAEQY�KV�Y5�X�(�hAQ@E�=��ӗ�h�T`� ��0��-,�H0�e���>k�������f�UTV��ս �   �Bk�����L��Q�T�Q�����01q� �hfK �H ;� jZ����b�i'���� �K%!.H "$ʗG@�#`��j��&6�����"ZEE�Z�ժ(��E������(�XEc��:E�����V���l�#�NX�j�babZX��0�*Q�UEc�FADQ��
"QŢ��ؠh��QD1B�����ݣh��6XlY'y
�("F�`Q,h,���_�:�"bP�����;�U�U��֊bE���"
���b+�Ec�щ谢j��ƨ��S&[��mŊ�t�� �Uk��  ��8�`�  `k lU�C�ت5��Rz�""�V�4`+�jT��TQ��5I�X�EP-V����~U���j{,�-��A0 ���X�}g�E �U�~6҃S�$�K�:-,�f��r�м�ia�5kw����  �
 0�}��>����#�/��b�90	2�&A#	   � 8�G �$��������P� WOR��! �l��4�biհ0�bE#hETE����N1`�hU�Ҵ*XWӺFt�VTUT-TTԴn`Ŋ
6�X�4L�QԴ"���)��� ����DU5U�aE,-�4,QlQQŪ�F4�k����g.�����uP��K�A�Xc֨(Dt�����!�������A�U�Z0��ɒA��QE,�ՈbPT��z�ܨZ�w��`���"
�O��q��*V,�֨hŢ��X@��y�KVk��5��VTC�Z5@	������UÊ��5,Lsaq"�A��:�(��xm�2�]����5>����X�V�Ƣ ��h<g��������Bb��|T��:Vm┊�bňE�������	�K-���w�$�Z��Rmt��5I��~? ��&�e�r�[������̧�9��OG�9�rp`(m5b��X+"V  ���傲�\�*6��DQӪi��i�d���Yڠ�h�ZѠը����j�h�*hQ*jմb�*��a+ZT���E#�XE�U�[��K��T+�aaa��`ݪ����b��-ELLê�����l�( ����1��Ɗ��
6�Q,r�X�L@�������EN�m���j�s���E�*:m+�b�:U�5"
�mU��F�
�ѩ
��5QQAUQ1bAT�"��*:��F#Za-�KP���(:���
ZT`�b-�1�FUU�`� A��AQ��`��i��%��;E���UE�b��"�V@#QPX����*�*"��AM�0������jՊ�`ĩ�����<u��I�z-N9;�nU+E��bT��Q���}G;��ŢjAZY��"�r��R�F&��f�YրP��Z-�Sp���Z-�Sp���   ��b�m�T�R9r4眩��rG��8��@i�BM	 DDE��*��i��V��ب` ��' ��\)�T�+*$����Dy,Q��(�FT�Z�TС��Ŋ�*6�
�����`E�V-�U����(:�E��E�"�FE,Z1 �ֈh0�QE1 �bkՉ��4ZŊ`���͂E�9i�Hn�r��<D�* "*F���壘X��������Z[��j���F��؊"���N�+6(Z�F5`�[4*���6��`U�QE�� �(*F��4�*ZUU4���4*X�ZQUE+��( ֪��Ո��ZUQ� ���6XCTѩ
�h�bQD�(`�5P�h-g~QЈ�VTAAU�3��!�ϸ[w�C�X�hD,���+L�o��W8,�8�Ak��mE�""�������@���?�� �@`(  OggS  ��            �-o�������������������J�>�9�W �^��'<g�
 �   `��6���R9J��Q*Gs:JI���h:0�@�� 2�  �����JrJ"%�$�
��aŚ�-����X�����MQk�P�(Z��N��:��QEE�(�`X��VL+�UE�����*�
�0�
�ai�+[k���Ղ(QTŢbE5����j���Ac�bD[�"b0Fՠ��8[��,t�VV�� �֊D����T��"
��5.Q�ą�U}�U�*��U`�-��T��g�o��E�������o�ZŢ(:1�cD�4���ʺ�e�-�*�Q-�C��hAcZ �j �ňU���h-�b0L�FW�**F5`���k���*EP�EĠ"r9����_k�U�>�2���X�C���X�j�F�� �V,�1�-�lR�3�j�*���!� � >K����Qā��R�k �Fq |   ��M �ܷ9g�T�f�9�ܶT��tH�ʁX�� �E ``c1�����a�b5T1E�V�bgPJ�yb\HQ�gF���C P�,:�X�ڊA�с"��N�K��T�RM�� b&`�BQCUU��BL�F�E� h,*�U+�E�VDkQ���*h-�Z�:���b�h�*bkDTlTk�ƶhUQTUAE�:E����\�EDT�Z��jk��w�;�Q"(�N#ZTĪ��(��UQ@��(XU�EP�|ǋ�t(��-"�*[#�X�Eщ��VE�l[��ZA�آj"
b�Q� X,*�*�Q�V��RDDUA��U(�����a)�P��4�Vu
b��K�),Xc� "�՚:q�l@#bA�E� V�@c,F��ZB�c�s�@5�0�8���K*rӋ�#�kw!�0�Q?��J �0�;�E����Nw�@�f x?  ��N5JA�<@Xsn⚎R9���s�mNG��HP3QkEE��j0�"����[EQ��Q10RB|"u+�U��X�hlъ�F���:u�FUTUTAT-�UuX�*���j�Z1-S,U,UE�&QTUP�-�Sݎô�Cm2M+*j�XQ,:-�`�V��V�m�ܫ�V�~ѢZĪX�D�EE����o�\��t�QQ���`U�h�X����b����!r��U+�X�ZD�"Vu��֪��TEl��A�j�F41���ZEtb
Uk+bUEсlѩ
��Fc�SEUE4�1`[�5(֊F4V�XZT4�m�� �ڤ
�bP,Z��V@�A4��jF����VTc�E��b��g�H��/��C}��B�1
����K���l���;n�,x�*A�
��+M�l�rz�h�� Ė�/(< �j-t����H�Wk�T}4F���   �D h����ܦ��h�9��S98J������$�� j ;��Zm�ƴj+X���v���V�i�a�j+V1 ��0���e)��
�>�q�(X�E�NA� (
֊�mEEUl�"��XQ���A,�X�AE4�XDK�T�T�&����)�6�`�Q����ժhlED [Z��R1PC�P1X-"V�V�SUUU� bEUl9[^U�� *�h�E�b�XE�F���EQ�(�Q��ֈؠ�ض�։�Q���X�Ɗu�S�UD�AAc�
�S�FPAQ����X5�Q�A�EUUl�QD��X���P0X5DQa^�MAlc@Ձ(ܪh����A�p���x��X�VED��{�r6R�9�WK5�O/�Z&+�]�P��:���v�֥����>��,-p(���Є �Zml���A��{�66B�� ���   nL���9=�����Q*�;88�r�� �L�@6� �������P[P�a����T{lPV�'(Hf�!,(�qV���!�St�� �F��EUt
�CTM���TC�TDPmQ�C�l��*bai*��t+/�W;����h�*���
�X(�b F,ZŢQmQT����XSQUP1�TD�mD1����"hAA���ZD���b�� ؂XK�0TMq/ߟ ��k��A�VAA��XD����ZA�QUEc�Etb� ��
�Z��������y��T4ߠ�bQmQ4X��Xъ�ි\�����Xl�th-���Qũ/�9l�a����5AJ~Q-c|�C1Ed-�bR}�DH�\f�V|/�AlQ5��p߄���#
�V�c�[��iԚ.�oB����V�j�tw>��3�}@� K]e�+��Eċ���ѕ_�"��   �6 �BdQ�0x�$+ ��+�L5��眎�3�0�C*f�V� P�	`؈��i����4L U�k���XE��4Lc�U1�Z�UUC����)*�F�H�s�� �dX	)�PT�0��YK�SM5MQ�aa���*�V� 6#6؊��@t�׸�!��KDЀ`0�E,���{J�� �`�*���jQ� 
���
�].�|�T�D�hm��XDDZA���"���U�((� EEъ��(h��Nk@AP��h��"`�T�jb]1QA'�i���E,VE���XDE1�VD+�� �X�U�VPEA[�"�(�谢���X5rs�;}�l1��h����Rô��DU���klT�Ţ�QP1h@�AUU�hT�b��䚊������ֿ(������ `���h�X5�`E�����)��"�b2���k&�~���W/${�� ���B�v� []d�d ���Eֈ@��   x@� �"j����� ����5g*G�Q���R9rpHEL��� @$�jkccX�ްCQ[AU�`�X�F��X;�QC��S�
�0� �K��PBY� �e	e�
b���5+����m_(�jEU���U�E,�[XGP0,5UEĈ�ZѨ��Z4։�"�hUk,��
j�X(&��b���-
j��ZSC�)�?h,�<��5�T,��"�N��ATDE��QU�X����b�(T:�4`��ҲVAcT@-����QTTEۊT�0AU4�Q�*(����5QALEQ0c�5(��u�Z���gm�UU4����T�����"�,������U��/����YsrZ֨�T�G<��ҢhTiW��4Ƃ� ��-�t�@ �:]D�x��E4p~��   x`@PP[�3�l�L59�s�9���ܑC*b1f�-@�J찢b؛���ڨi@,jQ��D��*��.ã���O(��3�/��r��XX���l5�TCM��TK@A��Z+�(�i�
XX�����VlA�
�Q�
Z ��*�DDUP�` ��@�APQ�SĈ��*�Z� �-��J1���l�؊��h�S�J��� ��ZE��/z+贂U�l�UEQՂ@�*�1 QTQ�bA���A�*��`��Z�`�h�XE��E� �h�FQ�!�*��
*�������*�*ت(ZU���jcQ���F��1�bQ�����L1TP���B�U����FL�UTTD��h*+DlŪ`�P]c-��%⻆ h��\�'36��"�$��]��r��xgK�k��o���$�$�K>�̒_{�Q�n �Y����G� v���z�A�#T���  xCFu�@/s�o⚩�9S9LG�Vp������1	)k�D��&3P��Q+�����aXll-���U[A�� �*��D�A"�p�I����4		��p>.��� b���&��C�@E��V�&�)}���D �����֬�bUDEV|���흀���5�DLQ�"DEQU��(Z��U�k�b��*���+	5EL�ĺ���(*VPE+b#*��`T��ŀ�hE1����jDQQ�)�* ����*��W� ��|���6I��_Q ����F*��bDPѪr�ZYU�*�j0�*]8V�_��*b��h���R!W�"�,ʊUTUT�f�11GSy�r��G��2�����Iv^*?ȫ���)�\��#�%�Of-A,�6dW|�-Xu{���&�$��� OggS  ��            �?��$<8JBG=7678HAGHF::57EHM�i�������������n��=0U�٭� �����q#�	py�"�G�T���!�+�h\�v/�����\gc�#j=8�Y(P�D=5E�����Ũ��|&��EUr�WɅ����{��鉓y�z��N����z��N����F4�K `DU�CP�.�aXQ�^��j�"X�XPъ��	Ub"`@��H���fS.0�fS.0]5�Hr���	TԈ�`�"��a��V#FD����z�x�;ZZr��T4�ԲƂ��r�*����W�  !�Ș��Ť�8 \�U�� �o]�)�+(�h-V���3�`D��
�>Ѧ���nkwl�{����m��r���Z�� (�	�B�*�F�"�rjX˿��Љ9��n�2Ea��m����ڲ�Ќ� �AE�46�QA�|�)���A4��W���n�2G���6 s�ݨ)Вcd �ZcE�D؂X3�_��4����"hg�o󪓁��ͫN
�ͺ5	r�@-V-�DUT,Z�����(����� �nm�\q��[�4W�� '�!��@%%�`X��5હ��n�non�@����PmZ�jg�X+�����jg�X+����ݲ��H�y#G ��(��:�(�"���7�(ҙD� ��h�*��[�FC�rG5`���rG5`���z���"bň�D�֠���Z�A�p{d]�9�|Y�V,���]F�s[TPa�mMPA��-�VJ�K��0F(�Ê��TU[��UU�������
 Q T-��NY��q{��v����n]�b\6`�6�9
 %(M(�h�b����U�X�ب�j���b]U�����͜#�T��� �v����������'`}�u�`� �֪U��AT�X����*�Z3�"r�|u;���P�8�U�X�>�n�$B Z���>��V��JQA&ȴd1F�����܆�(�v��"��#z�̉W �r�$Lu����I��re���F�jo�bb۷+�A�<c���e9"=g%m�v�n�8���0� 'ǰ�(	���0�*�����hon���_ڽ",Z1s�j��QXs�j��QXP�[I����a����#�C=zg�u	���U���`�T �r��L��/wL@�d�PS�� K�++�n7�V1�*���F�b�h�� Zռ����ZTx-��#,�je����V+3� 7���233$'HN,F���jE�E�?�y�Ek��Z�
b4V�AE��^�<�b�UB0R/���b�UB0R/�ќ��U�	rr2��*(��u��ZD�V~�����TAP�"仫M�V�w����tg�_:z%a��m���+	+�n#Pf�   .Dk�t䰉9J�@�����A�Q*G�؁؁�YZ[%d	@f`���ŴW��
`y�<����G����8e����RT�bi؈M�Uk��b�N0 ��UQ�ZAU�Q����8�V4�U@DAժz'xN�>���ZQK� + :�FD1�.#Yn�I�=�o���
":�*���b�먑���>h� �'?�:������~-:g�#)���N��:Al�kP�rjM����a��k�~�Rkw=}�Ȗ�)��6�U`�u(� ��  �w ���Z� �ƪXp��m��K9�$���Z�n�!<����b�O=��P NL@��Ӿspr� �J��SՎ�6�Z��u��q�f �   �CDQSD2j# �97G�a:�T����h�H���j�1	�F
DH Ɗ�"����b�Q#((  �ąy�2�P.xD\��� Ŵ�iZ�Ѵ&�-��E�S�VQtjQcՊbU�
�VEA+�*��
 :mAQ�ֈN��@�T�ZE�hDc	֬Z7����0��FT�b�X�nNE/hсEU+ �h���:P�آ���7t�.��x`Q�(F�jT��X��'�r�D�G �U�(�-�h5X�"F��Q�5��X�*n|-Τ��蒊���VT-���ZZ�è��`�(�U���3(֨:�F��(Q�hѪh4���(��h� ����lVtjU� k��	
�5�����#�L�� V�CъŠ��F��e�/@QUUAA#��"����F�Zŵ�������_ә\]�Dy���"&j�/�A1��h,X��ը�{���+Y;N� �Z�l�U-�i��V%iU�xZ~?  �z�J �;����T�R�"vpH5�-Oq��@�ʑ���@�XԪUP+F{{�ŊX��lM����jZ �D�'ȡ Z4�*ֈF�X���u�VU�XA#}w�޺�����a("���X�ZT��V���Xщ5Zs��k�hD4�Z���UU��F�����Є�I7|=h�!�u��AhD|F�b�Z�5�
]�?��2���.��D��]��x�z:Z�����;ow��YѢ(F�`�1�O, �V�*�(��U�*T���F�_�*����T�5
b+h `��*` �F'"���TAЊ� 0 h,��5KACթQ�bۊX�
%��.UPl�TŶ�-ذ%?��~��
A��wB�O�#�|!Gac��"�*=� �M/^Km,2�vS^` ��R�̧ݔ}   �O"�ސ@Q[MA0���m�T�R����t���������	��H0�5�jԪ����� �X)qV\�+ĕbÓR4������ڢX�#Q�V4hUK��*VM+jiM�A�"F@QDDU��UQ��aX5D�
`X�z"��YLԴD��VQE�ak[�5����Ƃu(�(
��Qlc�X+�5XD4��`�����|T�B���X�UUD���Ql1���ׯ���*��0J�}�:V,`������F�X�
��V� [,b��Q-�j��TUD��El ��`-��T�iш�*�;�`�X���f���M��)  Q4 ��ԨX�E���I$���j[Q4�En���PݚX4FĢU��ƓL�TR-�����@�k��(�	�Z�"��mU�Dg��y�V�i�K���Kw�|�2_,��B/�-��|? ���V��F��*ke� �}��(�t4�Ts�9�rp���h�i�U#jDE���X ���#��XV�Z��6 �,��X��(VuX�EQ��l00Mô�*�kX1MKô1TU�1(
�Q�NU�QD�bk�� (F��V�VPDQt�Fl���b�u��+�(��Ũ�hP��k���X�U��Ƣ �Xl����9{�bD�Vl[ �VAZQTDU����r��RU�jEЊbP5
VDD�*`Q�b QD�m*֊�T]�v$k�bUP���b�AD+��bр��E�4*b1�UE밢X��b+�"` +ZA��:PU,�� k� ZD�!*`�DcA��H�آ��5�*(�EQP�9�}ҩ��t��"]�5�y�D�`�~�U$r�5VEQ*�T	���)A���,="�g� �- ˷4~j���n�I
.��?�J�	o��$K�� �J�)�2�,��6�6S9����t�*՜����C*b&Aj�1֨����ŰZ���L (��b%A)���4T��Z�i�aaZ��� 1,Q��Ѣ�jt�`���"�b��X�ڠӊ�C�Fk�(�j���b�X��VU��"�V�`[�����5L�R@-k�(�u*`Tc�h��,�:Q�j��l�QС
�B���]���?՝���"�V��Ѕ���T[Ձ
��� VЪ,�-UAU5ШZ�VE���_��N+��h�"���*U���E�����)����XD�(�hU�����StX+���K��F�� b4U��EU@,���N@tX �UJO��(�"�U�� X�b1 �E��Z[)uW�d��s�B��D\H��ˉkB��jD�F�1X�s"�Ɵ��t�k��$s �  �J����]�F�*5�
Bwqx   ��"�9�L�j:���t4�L�h:88J�J@��		�  ���ڨմ����  *!D�K�㱄
JeDE@M,�XZ�hUM�0S,��VE��U'�VKk�����(��U4X��ԩ���t�X,XU�5:�����ЩhEA� F�1X�Dt*[TAPĶ�F��X�bQ[k�����Z#�*I~rjb��bѠ��*�[ 罖�*"�bl��UE4�V�b4V��XD������	AЉA4VQAс����*�#` ��]��Z�m� #FA�`U�ZE� 
�("�
�*�Z��DQ@ �NU� hQDDD'F�P�F#��;�����D�VU��b@ Q0�ZPl�`E0
H�0:E�w�z'Y"�A�"�)^/�"*b��XT@cՑE�� F�ح݀��D�-" �2�.��OggS  �            qE�������������������^K�KAsv�	૥Υ�9����   n�7@�>眩�t�h��ȑ�9SR9888��@4*@Vd������=�a�VÊi�ZmTDD�����8#�$��a� +�J �ZEmPð��a)��(�4,�Z��ju(��êXъ�F�:U�(�A�@�-*�!�Ԉ�CT��(���b+��m�ض�
Z�*"��6h�]]471 ��jAա���E �(VU�UE,�V��9��L:Eb�m�[u����*"��F����b[��"��ŢU�(�*b-��E@l[�Z �ED�(:+�M����`D�*����C���Ӣ�j8�|JV�N�EQl#� �`E�t`#��*����
�b��j"����F��FR�jEcT�DF�kn��t5D�睄�M��V�j�8E�;H�C��I�r�߬�J����5� ��pP.�;m�u�	��i��L��   �9�J5S9r�3���(�t�b3��	h�@ �' %ĕ��RB$9b�T�PJ(��0-m2L�j��"��VM�f��a��ZE���VAQ��谨�XPth4��CA��ATE��j��Q��-��*jŰ�bŚ�FЊ�5�-ѡ("h�����k*j�V-�*V�X���EU�b�(��ۭ#g�"bk�
*v}��PĈ�*�E�b@��(��(��XTD4�C����J��D�v�FD+(V`��)3u��b��`�
Q�*ւb��(E�(:P"��h��EQPDEEU#�
N���-�� @�-Z�
F��jPm�b�U�Uu[�=�ZUĠ ""��ڢh���#�>Z UPDD�[�B�T$��ߗuɈj�ZU�*hl,�gzi�7��#�ˍġ�(��" �ET� ��"�[��F��z��;R� ��h� �*հ���;ډg���T�RN�h'���?  ��&�"� ��f>S�}:�ӑ#�T��d���$�F X5�`Ղ
@(��0�b�<.���)��6YXú�b�u�0E�+��:E�Z�S��1F�jk�X��5�6��aiŪ��� bQUE�hk�*EՊ�����X�FѨ�NQ4�֊�E�X'�i���*XQ��*֩��D+���"ZEQ5+�hŘ�ܽ��
��F4�XUETEQ�:Dt�� ���XG���*���Z�*XQE,Z�X�����Z�T'g��D�j-b��F��" :�FT�+�Z0�(F,:E1�E�
bQ��I��U��Ţ�"��)�P�4�&5��Za���$:�q��[�b1��"�ze��ر�J'Ū�Q��E��n�5���!�۝dQQT��j�0X�TAckŪ�*VmcA4�������t~ej��w���+�ZD5D'�����(�(����2#�G+ �����o���y �kt���5�C�   �3��`ns�m�<�L��(��Q*�T�Mb&�- -���������S  �0�@�@x"<	�eY ��UU�SEt*:TE�QŶш��FtjlE�QŊ  ��aK�6�*��hD��D�
U�F����b��N�:�F���*hE+
��F�
��X@El-(:
�b���E�ZbZji�B똪�:�jTUQU��Z�j�j�jE�
�bU��V*Z��� ��j�VP��UQ�jUQ�*�4�j�b�
VPQ��
V��ʺ�E��V0�b,XDk+��ZDA��w[��.��GDOי���C�"T0
VAT4�zc�����ǹ������R h�� FAU��`�{���O"�o^�b\6�-4��{��+�b�AQD�rARWH��A,��"ZQEQ�b[UPPEШFTEU���HE[�#�E�e��-��>�[�ө��$�)�v� ���O)�8�<�  �PS�2A�g�j�9S�9�9�9�rppp4ĘI@��QkŪAԪ ²�R<)B1Q�֬Z(`iݪ�X�VP1SLS�E�QUQUAT����Ш�t�:�Z��VEtZ��X���������Aъ�Q4��n}���ZЪ��h����T�j5��VDЩ�ZE,�UĶh-�XkUEl��V�����F���� VTU,h��kD�O��lE�VQĊƶh,VATѨX4X�
��,(X#hU�b,�Ģ�j�Ƣ��QT��U�]B,bQl4F�W��x�]����?r���+�Umn'���%���*��آA_�zǟ�u>hk���V��G��Z���������?�jZEDP@ UU A+�F:-��2��8%�W�#K.��ES�/(u:�2��ff�.��=^ Z�^���Z�^����   8 k�9���3���C��0R988rp`�m"$��հXEL�jE�
 @W�e�g�ĸ�  �����(�K�aaa�l�`�UD�Q�Ŋ���t(h�����质�F5��Q���QՈ���:QTE�bA��ÊV�QZX�kEE�h��Uk�UU������Z1E�D��S�*�Vт�h+���UQЪ��j�UT�h�"��Z�Ŋ�ĺ�a
�Z��b�V�PЩ A�X,"�*�(��4 ���hĊ �(U� ���F���A�V��B��E�K�2��KW����QL��B�UQjeT�TD[����[�A�`�Ak�2�O��E��
@�b�(Za���ݘl�"b��Aj�!�w���ws�+⌒�"����º�R4ZE0G�۸VkI��2��b3V���zފ�:M�0�߸@"n�4��\~���?� "����""d�>�m�m�9g�T�b3�C*�T�9�#�v`�X#�� �JIJ2�ĺ�1mi�-�[�ja
��bCm��*"lE�:Q��btX�Z��VLTժ�b�Z���bku*�N��ba�5��*�"�QA�"X��ѠjUUT+��D�*:�b���!�@�jTE�(�*V�h4�łF�j� ����AtXb�FEU,�X�b�V�)U�hUѩUE��Ѣ#�bՂ�F��*�*Z���h5Z�"�jŢՈ�Z#�u VEE+"�X�*(�QT��
F��� UR���*�ѨVM��-��TE��Ժ/����XvD4
���
((*"bE@�����CW��I�ۜ[3��U[�܋os�׵���+��bDl[@-���J)��T@4bۢ*(�J���Њ* Xcc�M���*�o_}X+bE�
�͓\����i���Jkm�Q��j��Z�h��Zx   �k��,���t�h�9��*�#�� ��$�E %����0l�ŰbbX��Z�j( �&@������4!!�r�&�iͰfj͚�a�a�b�`��b��`-�jE�j5��U�VU��u��S�Pt*�����"�A�"����`�Z�"��(�AkZkA�-b[+�V�A��\H��*����X܎���(�`4"VE�`�Z�Ƣ��b��XѢPT�b�"h@t* *ZU0X+F�j,hVD[� Ѩ�QE�U,6��X+�^'5�XP��^D�ґ[:�#�+�Y�.9wU���  ��+:�g,Сâ*UeR�@�V@T[U��I���F@+F�X��˰�3��ry�~�y�S�Ϻ�ht�c�͝UD�����AD�Ϻۤ��K�B�䒖����n�0� ��>[�t��� �luҝ�k x   �E@�*�m���ۜ�f*�;݁8U��ʁ�I [�%�Ԋ����  R""�+�(8��KE�y\��0�j�F��fSL�0�0AE�[bE�j�X�Ak���ukb�jU�Utht*Z@Ŵ0Ӱɶ��������8N�X���L5T�:ъ�jD�"UEU4��+6���)������jkĊ��(�`��F� �SP����Ѡ�TTDkE�"FUE�FEPl�TEA�ѪZQ�b�(�b����5QEU�bU����EQTt��ZU@����(�h@PT��`B�m!�����A���� � *�b�a7HG�`AC�4E--e�ᡂ ��6`�j�Bh�q����։�+6�F���ڠXŠ�^�Qڶ�5��(�\wX$T�U�"
b�1���V���U��F�$Y�̃���\���]O۵��GR[���OggS  @E            G��%��������6DG���������ӾZ��"�O �j��P>y x   �����yff�hn�ќ�R�rp��R�r�"F�$-$��I@���&V{1������v����*b��EE-" ��� İ,��c)�r8\.X��@��A�h��VE�UTA��PU�("ZEA+֊V��(�NՊN��bETѨ�Q�`��PSTl�b`i�z�)VEQU�(*�,��Q�5�j�"`���b������ b��bE�-�U�"��h��V#� �6�8DQ�5EU�b����DE�hETŊ�"bP��Q5 �hU��"���*��U|:�NXbET�X�UM�v`�5��N�l��q�)�QT�%��<T0�Q}R��Ό��2�ݤ^y�[!$z1"�Vņ�nH	ZA�  ���#z�4��Z1��!Ք���'Y@l��v���)*�IW���j�>A�ԉ�TA ;]XE;?���.����`�   >"S��D
2JY���0�j������698LG�1��� �$��5���A0jTD��6*�!6��a��#�\�eY��E�>�)��Uc����j�ja����X�AE���F���hE��T�UTQEUD���jUA5��+:mCM�Pk*�(`U��U�P�:D4:ADD-tN���V@����FT+�ڊ�ZѢb�FUE,m�4�PSTDcU1�X,�1Դ���X� ��*��" VШ��ZP0�Uk�SQ���ضjtXQ���TA�bł bE�h��(b��
�X��U��*��Ѫ�UĨ��dժ�i��"�Ƣ�5Ɗ���
��B�
�#"���hk�F��tࣷb� �m�N�w�c^YQ�m�9��L�t��QAE4,(FՀE�����w�F�����V��hm1��[d�C410�mBh�-�& <��
�����d���}dPԖY�@�feɍ�s�s�|����tp�*�C*G<��#�Xk��
b-"*�"j��5��a��c��VĴ�ZMӴ�����F���b���N��X1-Ŵ��0�������ӚU5-�*
`��(��b@Ѣ*
V�� �NA�Ţ*��0�F��`UUU,�E��V DE�Њ�QE����h-�	������)*�i]CDMk�(����U�
`E�"(U�Q��"���bѩ�lD��Sw�I�t/�Z�/nr��5T�jP�AP���V�P��+�� j%Y�nOp�~R+!/)k�jTEU,� ^䜯 D@t�"�h�����8~��@qv�U�U����8B��K�և�2Ъ"b� b��g;/�E+( b�QD1hm�6YҙF�þ����b(�*B�:�7 �9�tD���	`wN#�~�@  ~  DD���$y m�y&��mĕ�|�r��J��0��"v`(-W 5K	 �U�VԈ�F�X���jZ���@��4�0LT�ژ�����_X@XT\HP@\������(WL�/ť�#<�����%(e)%`9���a�*���4���Z��!V,��� �j�(Z�X�hEъ�bcA�*�
F�Q0,M�0-��*`�hT+��İTú�UDEV���Q5�E���X��i`i�@M5�T�蓍�b���b��FT�j5�**����"���"�VlU��hT��F�
��Q�:���a�
ZŪ��"��QF�
`�؊N���&),�šUPETPA��&�1AME�� �`�(:�1"Y�2ň�hy��W�9ĕ'�A��ȯ�J���ŀ�Z��*X^8����ˬ�,F,�b4
"b0�N�JU�Hhr2�@ 9�f�J��H	0[ݢ���nQ	�55A99��10X��;5թ�&-��﹭�a�&]hܐ w�	y�p�pw����	W���`"A{[��`�"�������Uc�Ui}��(h�F[���um7�2 �nsU�μ��
�6+���AN����r��(�QtXkEŢv]gUU����X��]�j�V�9�Yg�ς ��p�gء�'p~&��   �H�V!����8,��ӷ�$�I��tG�J!�b�LR������$��X5Xk�P�cF#j��5-b+*���"�!(b��"S#��D��!!(&�`��ĥ	�	��AD�fk�
�Z�%*`���-UEDPkb��`����)�����A��(����	1Uh>	�4�TSպ��� �"hU�)��a�SD�"�m��-�:u*�U#"|b�O�N�Uk+:U �)*щ�3��������P��"���ڀ���J�`�N��  `�����*ݞ��E T�(���(���j0�E8�&`-�;<Z�~:#6�V+�"�("�0��1��b�AM?�)�3h�b>(8'� �z���i�k6	��z���i�k6	��   �   <�D&�A�%�o�M�3�~A���}�9r���R9�bG���� �V� � DI 1Q����(&(��b1X�bE�T5�,6v��0�5MP����V5m �aE�N DQ1mL@@���4aIBA*�b9bౠ� �qyb" �� (����
� ��Z������(hE,� �UP�SLA�� �
bi�@�j�0��k���l5+ ��aK5KA��֊ �� 
����&�j)6*�*XX������B@�a ��D�EE`Ժ�P@��F�Df��*&J2�Tn�@P4(�C_� �@���UQ���f@�:1T@�ֶ"6F'
�� �����_�6�*�Z�UQ�$��zsJJ�Z��� 6X�����V�2k �  @` ~�=�>��c7A��أ�#
=v3��   �   �$ YҀ�~&�ӷ8��ha��k�rGNwz*�;��90� �Y���   �� b���
*�`j�S5A��UPlU��a�(V�P��X �TmTmE1T0�PQQQ 5��PD�T�� ��� (��B�DO�P�p����Q�P��B��� �2,CբC�E��l�����iELAA��l+"*����Z�<�k`XEP�lT�
�`� ����Ђ@���0L���*&�؈��&�kP/�PE�n�Q�� A�S�"(ؤ �
��`��X� b*� �i���: ŀuڢ�--��+F4��	�J�(��Xѩ"V�+I�����(&*� 6M�)P�&�FAA�iQ���D4*�� ��h/{{���0��(:�e���C� %��� ����2Dc�sh�[0�b�����z��   �?   ��Ȥ
�����~�$�k���$ڀ T��3wz>����ўJ � �V�Z� �� U `�ic*���
�ZT,�U c���(��b� *������bo�
&V{��C�؛�j���"*XTPE�*�VAP@ I�p��#�JcY��� F@�
  @)��H�  �X�d! �6Z� ((*XK PC@MQP,U����"�:���@L�
*  bQ�
� ���X X���X�uTP+6�"VL Ek� ���V� �U5*� 6��&�"�ZUU�K��"�S{( ��0P ź"
��1������ � ֡Չm� F41��-�" �CE��V&�+�� ,
����M��"�����1DD��T��r
�8�UFЩ �� bD(�? ފ]�ҽ��LZ�`mŮi���c&	-Y��  �   <�d������ ^j� ���~c�����j�-w��9�8;c&B� 4%@��� ���(`bD�X�b�۫ *�������"Ɗ��A�bL��j���FED5�b��	� QE[Q�V;SE�P��ą�(����xTL�K	��e(�+�c)� ( ,).(@( PK�j� @����M
�
�
���PQ #�*�i�Ҋ!`i�A�"�i�hM�5��:$	"b�i]LDlPS���F��tfh�:1`�"V�:D���!h���E��"VDP�+�� ` �� ��`�����b�uӖ" �
��c�� U��(������E�""
X3-T�Q�DQDEE��N��>"���Fc�� ��!�����8�� �
:�^"��6�`�� OggS  @j            �{-�����JM��������������>�=��t���0܋��Y����������^D_0�   �    dT �T&�
r! �K �Lu ̅��s&q�����97��3wHab���h �4�h�	 �&�� �Q�@1� �*� �����"��b�������������#Xm,�jc �bg�3�ޢ��j�ET��a�  D�y< (�Q	!P  _HPL
   ��HJ	�  ��� 
b�  
BVm���(��*`
*�6b���i�!�S؊ ���`�FKU�0��	�Vk�"6ZK@�E4֩��� V��(j#�֊X0@��XS�T@,��`&"�P�:T��U���� ET1��â*�"�l� �ֈj�hMA�PD- � X��(&��A*F�kth�Dk��u(�t' �0
�`T��h�X�b
UEQ�@�����k6 ��� `D,�j ���V�`(  �����j?38�}�N�V}@���¾x�   >�z��Rm� ��q%�<��H&� �B\�8U�TN_X�H��),F2kkdK
 k�1*FUUk�Q5j����XU@DC,�v& � V{��;A����j�jbڈ����jڂ�U@E�� �
��",,*)ţb|A	!KY!i�+B8<���ba�RUEQ��b��EQth1`+6��� `bi@�Z��S+��jK�,���  Z$�_�fi*"�� 6YUU	ՍӊuS�4��P ��`� VET�U��*B$zD@t����{h^-�Щ�w�DQA0b�`� �"�>��)��aa�DD�i�NABz�`�֡ȃ[u6\�UF D ��A�`0�ET��,�Y.�`� �A 4 ,J�� 3�� �jy��*%ޭ�W�H�R�}���\�"�OX,��A��T�6֪�(bD4�"�(E�p�Z�ｿo�8S
E�(�h�^�2b(@��W��
�������ɐ1��ZD�`��D��1Z��XĴniUPU���VU�=Q���w���3� �YUP�	ԺofUAlL4'P�? �Ȉ:dY[֤�d�m�9S�T��r4����(;���L�$��jI��L��jUT��ib`#�a��5(�T��8�����F,�(��T���*� XTcA�i��c[�Z4�(��
��QT-�hT��V4�5*b�b�����(���N�FQP�ր+:�j�XEUP���"��G��F���C#�DE ���-���`���/	�A����H6��}�J��
VXĠQU�(F��(�o-d��R��EP-�*b��uXQ,�� �h���f0��_�FT��ƪQDAkTUш�6���9n*�uj4� ��U4Z D� �Ą��D�aU`Al��������o�ϟD4]�nNdY$������W\  ����1`4 AD�ŢA �H@0 �Je�C��;0��T*3R_�݁���   .9�Ü�̧��0S9��m3����C�#�3	��V�
�ig�Y�CUM[ �b��ˇ��ei�<i"b<B(�ikVSP@�EQ�j5��a�"��F�mUkQЩ�5րUQ�VTŢ�EDD0,,,�j)j��V+�bE���F�t*Fъ��Q���V�����(V4�F1���uAՊ�aU�U��*ZcE+�5�F�Aӿ�Ƃ"E�X�X+Zhuh U1��Z����*��*,C$i�Q5XD+FUAQ,htb+ �����(�D��Dw�h��֨���*X�Xt��Z��`[4�����R�Z\��-z-ZE�"ZU4��w�E$1����X���("���6�&��)�`0b� *��X�S��h�:T�`8�@ƫ��͒�ϲJJM�R����Xu���RW4�wG�b-`l�ˌ�n5��mUc@�f���������ɓ���Z���������*A�Sh���7  ��^���m�⚎RMG���S`
�8r�@���< &��D���bo��
��������j���j+��������())Q� ���6��&b��5�`)���::Ѩ�X�k5�EE�X��5�贪�EtZ�*�u5�Zja���XZ���=��:��X`��bi�-�F��V���� �(P=��� �UAU5�bU1F���{6���:Q����*�E0�s�uLA �jQ���N#Z�UkZ-ۍl�8L���EQ�VTQ@#��(XPI�V^MbA��hT+����hUEPi5�H��h��QUA��*�(��b�P�"��*kU���Qu��t� @O����P� :�b,"���T�(��,�BU��*�"F��� c@l�RMtR�r!�͠�%)Tc�hm��9$�݃Uk��"� �"<���,H >[��҇�)���=�>�H�} �6֓2�Y�F"g>�t��J�aNGs:�s�T��L���j5��bg���""(kD�  G�4�QaF��F��:@EA'��A������j��U,V���Q��Q5��KK�XS,Um@�!(:E�`۶F4����QT�"X��*�XUcTE�['X��U���(**�h_�9��ڂU�V�X�A'���뇢
��Q�bT�����Tk�}DlEcE�Jt�V �UQE��Tk4�(�VD�U��Xl�E4�h4�D� [����t���jA��`D�*XP�Ƣ�Z�h��r\-[A�����FKT0���(�uEP@@+ ��uST��İvA& �k��7�[Y�R����?j����Q+�P��X����h ��j�������#"D�b0VmX��f��j�b#����y�F7 ^zuJ�қ�A��WzuJ�қ�A��� 0��ڡ���k�T��t�(�t�j��R��� �5�%XE1�0l,6STM�jok��- 
�p�8xRҸԪ�S-�ba�֭�i�Vk:ETkT�bAѠ��ت�ZlR�B��bU���Z�FU0x��ԁLŪ�b]QT�U A��UUmE�Z��U���*UcE�V�bTQ�
V��
�ZM)���~�,:iE�5h�+��6��bEDc�bΩ����X� (Z�b�

�U�m����s�(-F��
U9�V�w3�b�*b��j�bPDEՊ���)yUQ@@�hEA�(ցElm�KP�TQ-��VQ5VPE���i�������,@E� A��ѨX�U1F�
 rH #��hQ�bE4A������J.�/g� ���_N9�Z�H��H���t}5�)�	����@Ě*�(�Y��q5 �Zm0����{�6�@���} �	�"�o3՜��Ts:r4S�9S9r���hnL�@f��)6b6�i���V�W�- �+MHDR��BTD�ZZ5�Y�T�bX7k�NU�[5���bX�5�b���5�bU���P+�X�a��E�h��֩�h�V5AcT[U�ڊu���*(����#6��EĠ��X � :@Q��A��'��bT���"b[���XCLU0mkl�APUĠE�Z�Z���^�Q-""ZUD�hD�(�X��������b�Z�-kT��������*V�(*֊����� ET�hT[AQTA����&��XQE����贊�l�
X��U�Z��U#�TUP�U� � �"�b��1
&��yNww-��"b�"�Z����mֵ
`���=�>�����㐣���0�3n��X@+Ā��`U5�5`�&����(�aM"  b$l� �J�� q�|�T/7H�� HY�I	�"��|NGsΙj�9���ʑC*�T�� ZT��(V��XD@�؈`�W�`g' ����(×`ĩ�!�Uӊu1-�ST,C�ĴV+&�S�4-D4bU��(�Ek���h@� 6�Zш�Q�n��
֠X�:UE��Tl�*�� VTU@ш*`UD��("�U�h���Xl��`U*�h06��*�QT�:р���h�V��� b� Z�D�F�Uk-�(�V �UMmM�(h��4�lU��DcĨZQ�(���U,��PD���X6���QQUU��` �F+�UT�i� ���������� V�Z@E�
X�FUQ�`,6�E4b��(����t��!Z�
FAQ<i��Q�' V@5�@�y
�
�Z��ؖ"�����s�����ZQ�@QU�&KT�PL�4��@ <9_MsOggS  ��            ��!#����7=?FIJDDL9HCI;DK� ������;87=9@<�jm�������D� �7 �̄m�3��#�<՜�ќs���C*�3	�I����bk�٘vV  ��H�,�'$%N�nӊa�`��Ұ�4VU,�����5kVK� V4DUuj�E�TP,����(:�(�Fk@���V@Akm�h�� 1��(~�����w��D�ԡ���`l�7M/�;��NF�b#��`�5C�AA�Q�ETM/���E��`-"�(XlE�"V�`kDEUъ�`EkE��X��XD���F�����^8��`kDѪ�`�"�UTA��-UA�*�u"
bT��F���V5�(F [,�"�(-�1DPDMEl4DD����� ���kA4*6(hQ�Z#"���T�R,�X�Q@V-�ͥ�Jx��@k,  ��?�����;�x�Y�w��\Vqh( "ֈ�*hQ��0AUAA,� Q T ] :�(� �:�(� �� (ɚ�"�K�>�9�tp��T��L�H\NO�ȁ�����ә�ȖZ���QkE���Xk�6&b��ް�����p8�
�%�����O��*b�6b�R�"VL5E�c�*XZ
�UC�ZA����h[ա�UE�*ZtX#"�(��(Պ���Ɗ���jk��jP�ՈV��NQ�Z�:A�iA�(VZE�*�h��䆣+�KQVA�����aZP1ت(�T�@LU�4TEŴ.���aMAQ�bQTE,VĪE�Պ�����VD�Z��[�u���iG4�����hQDT���Ul���AU�`U0Z�U -"h��FQ��EhlD���!�WHY��ETT�u����iCMA�DD���Z�ZX-l| ��XD4FD�e��j�k��@���e�(�l�b���Ȧ���.��{j�'@@��I�Er������+c�h1@�V-MTMPL��`o�91�( �V�� @k�	 @NFF�1�@D��r(a��Ԏ/-�`�.�h۷;���8{���v��<��T��1qO��:����� Y a�r��
Fٺ���{X�|�XC�/�jPl��jkB�N!��V[3jw
9��<Ac5 �$	�K��"*5�8�At���v�3�+��s+�ZU�'���V��I0����d�\��R�Z#֊��5ZT��>�TܤS�t�?��������ΔR*^�[{�j��P3<���dC���'�23	rA22��c�(hl+�5�*�����W.ooo/��kTQkW�4�����b�@�<; �(p�n�V�F&�Z��N[�`+�1h�d��@�[j��Z�E�e��^�ػ��6z � �zk8,w�5�
� � �AE��2[�N�T��Q4J��&�Xth��Z�"���S���E*��I��b]
 7�P �Wm!�iGN��Z�1FE��(��`kD�X��Q5�"�+�Kw�];�S�z� �~�	d�B���:��A�a�l�	0@��"D�0��5�
V�ր�"ZDE,:U�1���.��~,��/���3Q���j%�bS�K%��[l� s��{  9&���	��>����S�P��&�C��'��A Z�V�Ӑ�+�تs�p��	r���8\.E����S�ZQUk�Z�>n^��H�G�Z�ן�����JU��je�Y�� �������0@I@D@��hT�*k�>���Z�v���t�o^4�[��c��� �^�	(6�f�{]&�ؐ���-k%�D,�k��괪��E�NT�Ŋ��Z��"�X@�X�׉ ���?1�k��1�rk����\nm s���t  99��!d��S�Q'e�����`��t��OX<gQ��Z�%%�k�X���x{�jQ0r2rr@��XPѩ�*�QDժ�Q��t獬����}:YߜN�yz)D�^�l�5:@ ���֩�D��2bUT����kjZ������UUM�т"�*E��ױ>��oϱ������������ �2�U)2Er�b�]����ň����� �妤�bD�1**X��`Z԰��j"� �I#�&Ń+(��* ���Q�c{�-޽���ְ������E��.�f���Ebǋ�R+�P��B\%8�L�DQv�b��o�@DMKQD ��*�X�`ǒ���Ó�������s[C��獟>��_~1"Ǉ?�cc�n��[I�^�E���R��Z"!�����%}R�x� 
�s:�B-�`����5�(�:��<Z���ܯ�P��3�5S  � K]L�g �b���@� �7 ��W5"�ڀ����T�>9J���Q�;=�C*G�]��V̈́X�j��U-��`PTĨE��W @l�>_��c�����o�T��aS�j���:UkPE4�Z�X#��b�01-L��4Պ�)bMM+XZUA�ĺ!��VT�B-�cZ���5St�ET4"Z�:�ؠ��EZ�:@U���V�؂��Z��)nê��� b���(FE�Q�j�Z�R�b�*"��X�֬	X*� S�C+�"`D�U��T�(֪V����!тV��_�>�*��F#�PA#�#�Ϣ/�#�k��bT#��W���oo���3ʬ�����k	l+��
bUՊ�XQE�Ī��a�`�*"j��i���5�*Xب*�`�
X1�4�BU�J�@U�(�+�@�=�I��L���"؈��ƢFjQL��&��ٍ�!�bR-
���A�a,��h|E���qk�2bE�ƀk�  X��P ^[=R� ����E ��  �����@<�B�Y#��E�|:rp���s�9�rpp����I���PYkb��j��1�ŨZU,��!V�j�ت��bځ2#%&���@�h�TElE4*b�baź�`�Ak��bK�&���kcĢ��X4�hT�'���Pu�
V�(�V���*�WM�.[��WMxY�"( hѨV�XDтZQlPUA�T����&6� :E�*XAP-�����j�`+�U�؊�(֊b�XE+�lD��(�U�Z���5��l#F��,���(����"Fc���(Z��������؊�bP��(VEc�(�j������	�`A�Qt��UU,������k�X�  �-Z[ DQ�vx���&rw�dG��.��.A�� �ݑ�]K���?k4@UU�" ���Re�R�3b+ E��F"Y @0Rr@�9�����si� �  ˬT�ef&�Ao�H0g>����tp�*���X�a�;�2�h�F��
#b��bĂ���	���c�����(VU{ST���TUTT�#���HR)�#��H�*�bi�UԺ�Z��������X7(h�VTĊ�T�C+(:TEEU,���U1D+�UcDDlP���*��S#֠��"�VD+Q5������(����Q�j��Zňբ��V�bkT��XXbUԪM"�b"������U��a
DU@��5PU���-��Bߩ0"h@��`DT(ĊETD�1�
  �� �:��]eWn�J�-�a,���ƨ�*т*�9x��QU��&"��ňQ,bcѡZ� hŢQ, �*�8�R[��"���7����;�|�ړ-��m��+2�"@l �ĀA�A� ��0lTAC��|�	 �bYaY� ��X�@X/H� 0#4 ���e�V�󷫵� ��\f��ϲپ�|9�J3g�����̙l�`��-ꭐ�������Ey�r��ڲS���|���_�Aj�nm�
g�׭� S��t  r�1MD���>�ۖ�l�|��֭���|{ƣ�j���!���6� Ybi8@��cP�SIa.ː��kZ�/��hE%�㺼��ꬱV�� �Z{) �|���E
�1������c�a Q�Q��Z�iY�Y'������H��yN,�6e�v�2I+�u��n]T&i���	2rD8��B�<� TTŠEG�Y��b�Ú����VH�Q�ZMf� �O�&�Y 폷�����c�kT�����E�|���SH�?��]�jnt(OggS  @�            Si�#JLIM?<69:HAIKL9<8;JKW�+�������������~�
���ro��m+�BJʽ�H4rr@���

�E#�A��DUmDm U9��HEJ�⦘d>��j�k�z� ���S�z� ���Sޚz+$�� `�b�X��bt�ZQE���*��AT龯~�>u_8���ա�my�F���n�JF@u1��(��X��� B�<����:Q�V�(آAUQP�h�gsчj����.�v|m{��.�4�r��z02&S��r��z02&S� �V�����$Y>ltZQ�.�$EՁ��'E�a{+�F��2�h�8�!-k�ZsB8��C����\�����:�u���Z�1� ĪZ�ۃS[k��H�o��s�n�F��v�v�
�d��ݶ+�:�� �Z2r�A��˰*��y�I�U#�WLr��$8�z{�����VCA����AP����"��c�a 5XQ�Q,p�h���iM���-�L4��n���Rꌹ�>h��:���c�b�8��-V�(�-�lh+��O�??��ތȦ�j{(7J�j{(7JP��	y��DD0P�~t�G���jyKA�vӬ^Ua����jC8c���	� 1����$$�(�EQ4���Z�ZZ�I����C�b��H�h��^����$�d �v�  ��9 @��H�����$���|.G4ց�5�"bUt�j=�T�X�N����ue��g��1'�^G#2����hD@�@�{k��2H$�G�U����PAQ4"�(E:
E��M�ҩ�!� Z1Z{��ƿ�Z�~��l����~��l���~�%�1� R���K����(���V@�UTAѩjһ������s��h,�+��wGv �f� �H.w���6� �����j%#X�ld��X���(ֈ�(ց��5`E,*4�����e��CAkEE�^��*� �r��h	�T�ܴ� Z�:Ձ �d# K ��FL�k�j�u����߬��Y6�	
�fkW��J>5��fkW��J>5�P��P@��c��X��s�v��"FDTy8� �P5��73�j��fSBG�_�M�� 0F�!`�� _@����ҹj{b�j+��"�'>���D �n� �����֭ x���`$�0-$�	��R���;Ŷ�X�T�9z�l�۲�X��^�
�����ץ�2�����*��'`�1Xc�V�����h���UQU��`T��9�ok�#�����z*:Q �VYˮ:#��*XvՁ7�!Ŷ99B�1�UuZ���U�Z�j��U-�ZT-bc�U�Z4�؈�n \DB�!'YR�B頕�v	aH�qJ�\�KC�7뉒�4�#''EUED�-#ֱ4DAkk �AMS��%�(Vu*XS,@���:�
\G_�_Uh�:�
#f�P��,��1�
#f�P��,��� ��EQO�EF�T)��Ę�����db& DFS�4bj�"֊��b5�{�l������I���j���VT�U,�����wWk�����{��w�*���.A+�PQ�6�O��\�%&W���.���kP�s�F������h|JjFJ*�59X-���ܰ�AV�1 +h3+p�jtWp8u���l���k���t�pq��ҧ�b�Y�5��ɠ�i��h� �Dg�'9?�,즼���(3����=Q�[��/4������	�Y�LdA 3�f&�g�2�Y? �������<�H5g��MG�M11bvc11bfb 2�c5V�c��ؙ�ګ��  @�����ht(ZU��Q��XEQ�h5�W8QETբ��D��:E4�u(Vt�QTщ5�hETEQ5��A���#XL���#l��Z-�FAT4"*�jUE1�k&�aUTE��V�*�VT�Z+�Z� �-}UAUD���nrY��X�"��A���/bE������{G@�*b�hT@�5��(A���D}���#^5�����v�br�䦣�$���e�'����Q�/{τv5r�(��-��DYˊ6�ZD�HR	8�G�7tZ�_mA�|�����=�-���ܚ���o �V���.\�Aت"ފ٠�҅�0[U�7 @��۶�}��-�s�r�����!��L�(;"� �Ҧ�� j���-� ! ��H�Ʊ����a�؀�ba]�N�EP��Q��iab�PE��:��C��h���B+XZ�ڀ�iibiͰúX54�U��-��X�h�jm�N��ZZ�B,l�Tӊ��L�jE�b�u�b�0�PC�AШ���*��ڂ�ш�V,+����5���
�X���b�i�`�1mTP�A�����h�F�bP-��UD���5�4K���STŠZ�ՁX�XE�(V,VTTE�*b�(bUDQlE+
Z�ب
�ac+PTAE�`cQň�Vd�c�̬��0F�`�U,�(����z�H<����<!ގ}D"Z�
"�(�����b�T��ֽ/�Z��* �-@�Z⏤�ס~G�4@���� �� �� �U�**�&��H)k.b�DՀQT[U �:�H�C2�Ĥ�O�Z.'�UPEPm9B�"��>�!�:���.S^s�����(ںL�  ��m�9�99rp vpppppH�(��� "hц��i�7llMAT� @@�����UK�&�ҚU�1,ĪZ�n����P@U5�
bE��NŢ���E�U�����SU�����ض�VkT+
��
���!V�hU#Z�"*"�*Ɗ5(+VD�Ŷ����Q�U��VT������iA�hA,���XP�U�5 �X+���bQE�j P���1���A�j"�(NG���OlT������~Q���E�Bj�[��TG(�V�˞h۲i��=9���p��2)ǫ�����t"�e��psH�$Rb�%�]MҬ��ۥI�Ȉ�  `�H%2?��XD�Z���1�jURՙc���]C����ϫL�&��r�s?�:b@v�C��B~�ĖǗ�� �%[_b���  ɬ'�H5e$�|NGs�9g*G�b��S9888�ӑ�	%CKؘ6�ؙ"bck�ؙF��
��Q  ��S
_��ԊƢQ�i4����U�"Zѩ Zc�Z�V�Z[kULS���VQCT1:���jPD�a�*EEՊFA��U��EQEUTH3gաE�
 
:lۊN��jDUt��*�ب6���(V5��V4��(��EU@�Z�(��jP,�Z�XT�����A������Xk��E��UUŪ���
A+�bŊ"�`�5��X�'j�;��Ȫk0V��}���Wu��w�2��,�� hňr����d�mS<��_EЊU�j�n-�:���i�(nC.	y"�tU�䊻�ǒ��ÿs�{i֊�ƂUED�QШbDQ�� "X�
�QU(b-���6gw�mkPcՊbޟe�A{u�-VP�ؙg{ޘDae��ԘDae��� �#�W�=��s��h:888�rpp�(��X*bP�Q���j�`gk'6b����U0��00�� @�|a��J
�a�aa����V���U��� �bb�)�i�Xb����4t�U���U4CSU����`�u ����uCS�@�(Z�hTU1�X�QE5�NE�A���Ţ�*����������"��
��j��(��X��5bU�*�Q�� D�X��ЪU�ѪFEE5�5�(��b`�b���UE���X��Q�E�ZlUt��*��ةU�bШVE@��� �
b����*��<\:�Ӻ�Z�C��ԪS��V~��45y��N�m�����bAQ�
VD�U"�;Z��}ꨬ��_���"�/g:�*b-�Ky^�硱�h�b,b+F���X�����
K+�VH�*��埻���i�SkDU�&�Dm_��J(�jP��p��:�o���0a$G?�ͥ�	#9�	�~ 8oþ�9���t4眎朩R9J5g*1����Ղ����U�@�+ʰ|qa	�o��l��jݺM����*:��b�V���f��bET��5P�nE+���5�4-��TKK����+:�F�����b�NUTEDU�U��-A�u(��*V-��5���U�ZA�mщX+hl���-VE1��TՊhTA��5��ZE��� SSS���TD��b�+�
Xt���EQĠE#��`�@��(`� �\��]w�ՉhQۀ-6�jD��A�"�� �X�X�Z��(�-�l��*Z+�X� � P�5b��A0D@X���D�Tl �`kuj��* h�N�QP�h,� ���V��`�b� �UQ�(�*�E�X4 F��ҥ�S�k�vfQE��F�Z��XD0ZբFK��aE�FcA��bUUP�VA�����"*��"��D�cQ��f�Z D��m�]���OggS  @�            ��V������������������~�,� � �N��� �W �W

j���OG�f�9��h�rH�����!ő#GL�"F�U5�@��1|aIQ1)>O�ZXX�jͺ`�m�F�4-K��X�d	b�Һ(b���ZX`X`�X��U�Qt�bEA�b�"���Z'V�G��ʩ�A� �Z�/�#��h�hP4
��hT����b�6�*Mmv\FPѨ-� � h@+:�j� �(b�j�
��T�*&�5UѤ��+Ш�bE��VDcUA�j-*�XĈX����ɒ�e9�Z���E#  ň��(r�^qH8�{��&�&gJ*؂,�8���Ū98���������#��"6�
b��ۆ�s� X�(���kK,Ѐ(��� ��P��:n#�J�[9&����S�DU[�jňň$�ud��pc�lګ7�޹��3�> ��K<�a��{	��Y�2�}�-ն�T�J��(�tp�tH5S�+�#&�����aZ�����i`ETM���[ll��j�F�m�ѴA��4-4(��Ū�jUӴj�%�`E�0MEE�t���VM��K51�f�+�*��`�Z���F�NU�U��"��@�bAŪ��N�F�(:�EE��T��b�PԴj�V��
h,"("Z[��*J�uu���5�0��X�Z�j��*�iMPS0QK1�&���
�Fш���ԩ�:�
���ꬁ�yT����ưfXX����j[5�-�@2�q�:���L7�6����������`h\�r�hD�*F���T- ���U�(L*Ϋ˞n�"j"�Lm�>ݰ���6"�F4��bتښ�:V�
��VU9�DJXED5�F��[0X@�U�U��q"�yT
��j]MC��-��"�Hv:DDQlkm[��I��W�^J�D�0��8�ķ�J��a�q��   ����MG[*G[���a��s�"v��(��� Z� �� �����a�I9\�R�$"R���0��T�#�`x�j�P��ii�T[
��������QU�ۢQ�*�V�b[#���hU���:1`��UU�":,,���j�`j��)Z+�jU+Z��AT�C��qG��3���b4"����VŴ��V5�(ZEŪ,Z��Zlc h�,րTU4*"��EР�h-�j�M�^�f�F��w/M�1
�X#E�bED,�(�J=x��[,[�j�Z#bE+����a_��QD��Ă�CT�X��:4:�*�ł�j� �  t A�F'  �F4Z8%y�i��'n���+7[�VDթ� �E�4���癮���-�hQ��-�Ӷ��"�$L�$N*�8k8��e�fKxS���I%P'D[.�H�����-�m$��   n�m	��&2e��3�N���L�OG�ў�rȝ��a�1	�MK� 4# ���6�`Q����)*
 �
�Q5  �ąX� ���	k���QЪ��Ek-�A+����Pu��*�*V,l��Uբ�j��X�j���RkU�N�*�b-���� �%����a��,�I+�hUUtZ�����Z3Mۗ\Ar5�*ZED��*�huhAcA��F����+gN��U� ��hkD+hT�U�(`46�3/���
��a���X
� X�A1�N��XP��'Z�*�U�h��T�UuZU�Q-�(���×n Щh�0�º�� �bEE#���  ��5UP[թ��I�t4�C��H*��~��F��5(��)�"��ATET0m6$=���[,D�г,��i)"FDl��m�
�۵�F���ɕ�W$Y��B��=TWO�EV9��nU���|   ��VR� p6}���3�ӑ�S98r����J��r�C*G)b �	 k�*vboQ�0�X�A@��bo���bj"j��Z (xT�/ "�P ��� (� T\RȊEDQ��t*U�(V5� 
ZkQ4hUQ��jQ-�*�ۂ���-��F#�T�F�Q�A'Zt���bE�b��blUED�LD0�
�bt`E5���+X4`��hUE�Z��־X}F�C�T�."����A�2I � �,u{jQ}�n���/m���|�ծ�+���59T��?�����(bT�QѠjmlUPUD  ��(�
�-�SLQ@�C Hwf�DW" `CU5��"#6"vz#6
�� ��Vՠ(�QPU+��+{� Xڌ�	&��`���%���*'��Ǘ�QAEES>���k�:@�(��aA$�+# ^ju�g�b���_�Ց����çZ|   ��=0ŕjs���T�R9r�s:ݑC����*ő� -�� "*Pj�X���1�DAÂiQ ��#MX\XB� �\i�Ҹ"�������(��P5��V���֪��*��4���T�-����C,T���
�j��p� ���bjX7Ŋ�`��E� &&����h�t�����;Y�Q,��*(�AQmP4`���b[�XՒB�I4[��("F�(��C���"��mE�Q��������#s�lр(*�(�Ok����}�U���
�VЈh0�b�
���b*�`�Xբ�T�h �XA�b�-� Q�&��� �� �Z�lU�8�Z1��	��U���/����c`�!��uU�PTPA@���Հ4�@l�Z��j@Հ��.�	ʌ�  Q��� I�L�^Z����]�S���J�����+|
8�  2#�n=�HQ-�f>SM�T�RMG���T)�!%���S ٶ��F���`b1[�����a �
sť��@,�ڬ6X�P @0Q�nX1����ijlE�hET�Xk�"Р�SU5�E�XT�b����h:��*�6ZX`��X���*V,�EPl���C4�
V��jD�A�Zn��/_J�AcA��h4��V2e���S&hEŢU@T��TN�V�[8���+X�U�	6
(�,>�:Q�����Q5*��
h����Y+��*ZA� -(��*
�?}��"Z�E(����Z��"� 2W(�hEUЉ�(�5��#���pw+�N[�S�`��+��@��(��1��VSP���&�XkDD���ۂE�(�"�X��*�a�,
`�A�
�b�VZ��!�4�T�r=�V���!T���8�F,` �c�/�p ~Ju��q�;���R(Dp\�d�y   ��֙y*����ќ��J�*���R��5(�-��ik�vj��a؊ (� @��\�O��I	2,�3B��d���&,,LӰKS-@U�h�Ft(:U���S#�DT�Z�&PED1DPE�j�(*��c�åuL,T0M�ν��j�E4
�ZŢ�+�VT@D[E������r�i<'��-�Y#���O�r�D�D�(��APkmĊhD1Vъ����Z,��3I��U4:P�U�h[�VQ�
Ū[kA,�jy�ITQD'*�j�.�FE�XQEQ�h��.a!�4U�( �X�T�P+ � � ����V�Q��a�����ԕ%7�!�Ft�
�,���Z�(
��(���1ɸ|7R�W�}��Zk_q���&�«�y���B�
 b�������_� �Z�����$b�?��q�#��I��   ���s��9��t�j�J�*՜�r���C��� � llL���[C����Z  ��
r�I
�((+H!�J	�4A�F1��V��"�M�n`X�º�Q~����N�ZT4F��h,��ӨX��Z���T��5�*��*Uk����F���ա5V�h���E�Z�VP�ZA�`AU-��XEc��r�߾�H�ɧtT�ZQ5���ATш�'�̕B�b�(����DѨ"nE'��5
(Fш�"(�ňX�C�T�)QPb!+W�BET�(*�ET�sn�a�������yE�F�!�U�*0b�-�Z �Zlk�@����O�!�I���5�u^����M���2ʺ;hSL,�[W115L� �FN��2��lԭ��<�Y��|c�Bi�A�l� W�5OggS  @�            ��7������������������>Z�����7Z������   ���A���9�NO�j:r4�tz*���M΀�)A��F ���a�b�b��)�XTQ���4P��(��"�b@ )(Ȃ��	2\AI1V\P T@����hѩ�F':���ia�i�(��bUTQ5ZZ�U
Z�*�bC�Z�DAA��!�QPDEEl �A�F�XD��)�(��֬b�:���6i\��Ҋ�bETU���ƈ��bEkcŶ�(��u1Ē��^ `�
��
��o�����@��A#�����E��5
��b��b���f��V�hmP|�en�TD'FDU�lVuX�:E�
(A��hTE�5hD�"� ��N�EA�EET�f��i��aU$}�Hk! h��^p6�r�Zm}�&�l��b[APT�1�b1��X�hD�t�"b+Q,���G��Hn��A�|���[�-��y%��~�J-� � �R�� �   �`�3��|�J�J,՜�ќs���>��# 4��ZI�^AMQ{L����b�PV�4!>xTT�˗��a 	�����XX؈��U+���*(

:U�X��X��ADAK+*�UC�XT+ Z+�(�ت��`D��j��EA��ܭW�(�Zl['�}w��E�؈5"�����K_N�k�a۶�V"����\���bU��F,VA�aA�E�(��U�h���Q� b-:�(��`U�E1
��5ꩾ//zEѢhU�"
�U�"�h�b�Ţl�(ZD���VAQ�U��5 ��E�ؠX��(6�5
�X����(hA�XQU-� (����Q�DD@cUDD��j��"�� �hmQA ���8E�q�"�B���䜨�(���0EEQQDPTm�f�,�A� ��1���blm2��*^b-����6m!A���{�;�e�� �t�; �   ���)B�e��a��ܦ�f>�s�!���*U*�1@F	 @P#jՠ���P[��akb5l-b�= ������EP� *���v��� �e(#@�%xAaʡ����C�<AIj1�Z b���RLl��(���VT[�ѡ�VEAQ���*("�+Z����"�4Z�b�"Ƣhl��J.c"�j!�5#��x".��_ހX���� ���N[�6�"VD��fb�!�� 6���E�Z1hDQ,�CѩEQlU@l�hU���FPE4

��U�Q�Z���**���jEQ�5�((���*����D��A�jk4*�h ���(-b�
 X�hEQTŢSQ�b(��Җ�"(`���jm�Zъ�F��
����D��
b�XD��V���tVA,ZD+�����\
��U�U4�]kXc� "��].�e-���XJk�D��n�ë�F c�(����RO� ^j��C��Wj��C���   ��,m�;���R�Ts�:@��tpppp v�BI�f6 4 1��*���1l�i����`ڪ�Z
U@U����*b�
 ���a �r�� �@���p��`�`a�i Utjm�FQK�6 *j��(�/��}�2�i��؈"�D��BЪ�b���
�ؿ2_C�1`�(�K]$ �����

X#"h��U�z����! cE#9�+7OUU'
XAl�VŠb� hmq���H����������l�X�E���(�
���*�Q��U|G�G���	�a	ب*�(&��`kT�� �5`U4�"9��B��%��*�H���ѵr�H�$˔�����-�T��F�G+�v�'�]`џ���:� �:�*_ | �Jm�"+
�o��pEV< �   �  zx��� �|�s�����a���C�T�98�Z� ��(@ XA���;LӪ�Z�*6�Z5T��a�b`gk��	����X����(�I��!��_� �
�Hr)x�f �ע�����F�+X3ULQCUQUQ���� �X���ba�Z�f��"�VA��(��:4�k�!ZQ@U,��k��bE+�A+��1:����`#�V�`�UDA���T5UD���=��h@At�b����5� -�6�EĨa�X70PE@E�XA�vv��(��}T� "�Ft`U|�v�e�>)�Z��*
bUE��cP4�Q�bŊZ�����X�E�f�"`"(��k1��V��B�!��
��1Vҿ:A>U�m ��A��b�|�6K��:����16���� Q5��Q�?k�"��,�Z ���Z-�A��@nj��-~�   �OVk!B Dj���LH�A� �;J�;��s��<�P�tG)b�R� $�P+�1�ZŪ*j��1V�"��Q#*cPcӪj
jQ�D�aEQ�P�؀� ��)v�EPQ�b��j(��b��Z@HD
����� �����%�eJ�""�6�`Z F�1���UQ�N+XTUTk���j,1�� b�U�fK�Mw���<��Z,"h�N�bP��Ƣ��
LA՚Xb*�����*�Q������E��m��B���$��(�FD�h�4 *��bD�V ��NU�X�*XA4(b1��FAl� �mU��*�ؽ�T�ED1�jTQD,F�i�DEUu( Vъm��Y�R�E�[-s�����آ"��ֶ��<ڔ]J�r*x�rx6)�6���V�js���3]���-"`�[���"��Ԃ(	(�P
>[�eIH� o��˒���   ��:��2!�ND2pc���N���h�T��T���d vG���g� Ȗ@i TT��b,1MCEM�41`��U�XcC+X0M1�4�a�ib����*��6v�����Zm0U,�)�j���aA@�P[SPPA#�e�b����a ib<0��0F+��`QUQU���ֺ����X�b*)�E�``�&"ji]@A�X@�VR3-�T��F1hq�Պ�Pk5V 
�Vl �"�D'VQk�Q�E',:DX�.0��P�J���A�F�$��BEQD�*�1�5�` Ū�#��FD�X,���^�� ��j@��h���&
���� `],EE��P11��2�F�{Q@�-�`��ē_'��?�3�&����/���Jecl+�j��7�lYZ`[��V 0�U4 �贑s) � �z�`Mi n�u�5��   �o  �%O�J-��ƀ �ha0��sG�	��ih����͑�����X�S@�@V 
 0D�4���FP5��EE���`���`��X1�FL1P�D�b 5�v
�*�*�`Pc�<F���A� !,8�+F%� !,�p�#(@����FU0���h����������%�b"�b �h XD���/,�X�hQUQ�`�b-b��/�eLDm0,-ATLE�f@���
�
��u@T��|q�,�F0 h�Zl�/�dyG�J�"b4�`����"�`+hETEF�TEps��XĈ��:@PE1�bkE�hu�b+X��'�]U5m!&�X�1 "VM��iU�j#�A���]�#�E&b�C�%͒�{�5-I������6�J�[��קX�B0G���@Pu
��  U �Z]qM�zP�VW\Ӂ���   ��:Q�!� j��� ��Ad��3 m���J�07qP��U �tp���0S�
 �5D c�A�5�V��1�QQ��5(�ؘXP5�b�b�1-��*�aQ5DA�*�� ��ZP�U
(F�*�
p�<.8�<>�FeDŹT�K�!��b��V0-PЊPET����j�P�+���}���*:l����`�Uk"���5D11TcU�:l��&�h)�j�h@Q�������_��2�P0�.&b
�_�.��V��(ZD+��:�
��t�;TQ@Pu�����@��Vg��'P�B\Z�0�AEъ`kT��� ��uSLV@�2�}(�Z�bi���� ��i�a,�#� ��SP��H���~�F޺��K�TŪ�[�Pϲ&�r�*�k��I^��NO�ŀ(Z� E,X0ZU�`@� �� @OggS  �"            |������986DL���������������j]hiK!%�T�BK[
)`�   ~  �Y�  j ����̟j��.�|�Ŝ��(U�{ �� ��l�Ĉ��* J��
@ `-�Z+�j�B�k�
X#Ƣj�D�0��0�� ����`��"(��V;�D@��Ĉ
���BY!.�c��DX��T��$�\PBE$��	�2�.�P��`X�[�UA-LъPQ�f[�Z�"j���"T- �15P�I��������hq}bE,İ�F��"(�*�5�RQCm��"��Xk�����"���DU�FP�Ɵ��o���1�����YOZ*'���Ij�Ë�3�%��m,�ՠ�XU��5v�_�uCT��EUĮg�����4UЁ�`��@1� ,:�`U�@XE��d�¸?��ll���p֩�8|z"��n�w1��Iq��H��C� �u �D��YM\���x�����Q{��   xl�PT�䍨� " �!�RBBf���g�Ѷ�+������!�m� d�$vp��T� E&�M�!@fC �Y�v��ԪU��F��ZT��Q5��*b�"��a��b#v�aV�bQ���bM���"XLU0UM��P1D@Ԋ�*��I�a�y|1)B%���VP��px�;��1Ĵb���)jib�aV�C�YÄz=�l���Nc#�"�8ШV�*����CU-b��C�@P,l��Q 0D�Vq�ct��*��EAETU�VĈ��SC��C1D������^LKɎ����Z7,PQr-��k�ĺ����/VU��j,J�k��?e�Pu( �Z��0@�REX�N�����5" �����ɟ��],��4!�;�łk�#bl�XZ@�V ����s@�  "Z��4�?�" �5��	_{�,[����sE��V�gV+U99&���� @0M��+]M����`]�}B9�b�
\P���_lZ�
��jm�09� �
��h��%�������C-�(�s��^SN``������t��B AFC Q1V���Z� y�]��ӑ��鄎�É �ZI�`^k%d2�y��
#'''��j��Z�VU[��(�(�Q1���IE����#)�u���B�wD����V;SF��L{��)#�B�7k+e`�%'#C�k�*VT�h�hщNU�UE��("*���j;s
�}��8B�S�v�� ZY��Y,���[Y��Y,�����  � #l3�L5S9��R98s�9J�Tb�Ę"�]mo�FE��2U���i�W[;�	�
I�K�JH���"R�T�O)��JQb�jZZ��Fk�US@�& �T�Z��(ր�(���k��(Q�(*:Th@5
���b������h,ZU�VĈN�*�U�*�T�AT#�]}�E��ڨ�Qt�@��bUDD�hE�A�� �+���P���� b�Z�( ��
VlA���jl���JB>�IU����%+bQ�5��Ҋ�kzY^kô+O�p.��5-*���*���#eW�$�lU�9E,h5�bA,�X@D�6 � �_ � �Z�  ���(�xQ�����(�jUAPy��Yr�ǽ�����Hb��3 � ǉ � TvwM7e� �~I��N�}y(&|�T��ޗ�bb��P e��(�*n���ms��TSl:}�r4�y*��t�)�$ �=#��`�"j�3lLL������S ��  �ca� `Z���bE� ��QЪ�Ѣ�*�bр��NQlE ��i��0�R��k�VU�V1,--Lk"��,�f	��:��Zc�
bj���q/Vl��+V5�"��bQŊ�Cc�X��bD�+Z�ETŊj�֨
��jDt �bc�w�n�MPѢEA�F����V�!b)�i���p���چ ��D�u����QPUEՀh�": }O��� F�,F��*�Z+�A�갪h�V�
VlDрb����o��bU�QD�Kk�VME,Pk��bFT�@kX
�U�� QR��cS�b�|���(�U5A1 b��:u�QT1m� '�w5���΄���,X��T� F��h���B�����;�>J��2�8>�"Z��R\�{�V����   >Y7"AV��D��*s��t4�r�j:LGs�8��98�1	�M��R Ŋ5*VUD��b �i� �����C)����FTU�*��hDՊ�SAQ��`��(�CQ��h�(AkE��C���@-DŪZ����ib�f	�e*��HI+D����hT�b��V4�աڢU�X�b� ��� ���!�ZEQ����O��"E� "FAkŢ�ETQT�}��+���(:-X�*X'wD�+��Y�EAU@������؈V���Ⲣ�kTQT�EQŪ���!���?i���QuXU1�*:шU����Xmb�@U,F�1XѨh�A'  � �1�A4:t� �u
1�Zl�iwr�)hU�XU��c# ��m�C1EKK�ag��.��EE,FDTm��ށ?�dR�����"IX��1` �I�|���]�6�����˃��  ���6��(�H59J59=wpȝ�j:b&B��( 2L5�V,��� @��r$���p$��F@�'(l���f��h�UCA�j���hQU-k�hQ1:P,*"X3�U�PQ4���:�`U#F�UT�1����QU�UDkU-1�j�ڠ&&�6YUA#���E���F�hD�*�}�}�؊֪E�5VĶ�*��	a�EQU�Ѣ�-�U�FE�_� ��bQ���+��s�����jAP��VD��
>4E(hE�����ȹ����*��EU��:�*�j��i�l���QE�("hT+n��UAk�Ema��TEk�4U!4p�  : ba� �0,�Lȭi���O���*ʜ%G�@�`ADUUKk�**��
b��`6"DMTŶ ؊� �5��H8l ����(�����q��5�Y z�J��)����B�ZI��7�S�]Q� �*��������>SM�;8r�����T�9��g*bf "K�3 ��VD� ��������+lͰ��M6Z���b�b��a��������ؠVK�0�[C�ʪ�i�`�j���*V�TC�L�*``M0LK�b5D�QPc�j�hP���**�XU�*�u���� ��X�*�+`�**
��5酗O�mw����Ԛk�쭨�UP����$�,�
�
X��P��*��vU��"���"�qx)������_����7u�Z���FDQ�$������j�����""XT<��aU�X�N,��Q��!�ӊX��H���}.�XE�4Q��bTC@MTl�� �6� #��b�*��*9�!��U��NG���)|��;
O�Y �Z�l"��]�5�jU���v\wUp��   �}�-�s:r��t�*��g*�|a�����I "%�d�����  �3R� �# pyҨ�����pl�� 1,�Y1-��5Ӫi݊"�ب���":ADDQ�h���h��V��ZAQQ�CE�hTŰ0E�b��b�ĊE�A�FU�UQTQ�C�j`���!(:0�h�����Z@�!
��F4�UAQU��j DED��[�F!��u	+�DTQ@�W������kQ��bU�(*F�i�j0(�EQ���hD������ضc�(��1Xk�����;�"XQU�@U�*
*��Zlw��}UT��ڪ`���d�V�Y����X��a�� k+�Ek�
FQ���;�m� �"���]�FYZ�:I;�g�bA�XT�&E&qePr�6�H��$5%��<F �X���X�iPK�6k0 >Z�D�a�V5�@p�@@�   ����m���T���9S�T�>�+%E�A�I i)S���L���Z�0�"V X*(@�E����PB$�D�r	O����NP�:U*�j�u�ҊN�(�:�Q���6����VPEEE��b��X"��V5
"��`)�ք2�7�H����(ZU�-�Z0XA��7� UU���ۻ�,,b�(بVQ4VD�FUAjտ*Ba�ZA@U,��FETժ��(� b� 
�((�(��VED�(�ŀE56:5���ךS��1�N1���XE5b���bQDcU�ޗ+���I��祦�_J �U1-P�:Q@�1�Z5DUQ[  �QP, 0�
��ƂZ16b�'���r]�Wf:E14���\�[�P1�� *�`Qt����qT�TQPD2>�֗L��ߛ9�a�8�_'d���cY88yY:P OggS  �F            N!tl�����������������՞Z-��l _j��
p�|   �}s�>g�T��L59ضT3т�����LIiM@� "&����b`����  ��� ��r����b�>C	>OD�Z�b�aa�5ĪiX�Ѫ����bKӊa`a`�a�R1L�@ъX���+�n�bii�BT,�T�S��W*�AŰT���j	�Z3@�ԊQ�Q��UQTE�Z+X��*V,�ŀU�"
V�:����Q���td0�N��Q~]�X� �QUayy� �(���VU�@���֊h�؂FDTQET,�j@��Xc^�r.���Q4��U�Xc�F�(��hi�!VŨ֡�
:M*Z�
�U[U+��^��Ѣ�(�VQ��Ӛ!*����uS�ET�"��
�i!XQ��҈*Q +`-`k��h���XDAU,Z��E  ����Z�EE����cTA�`Īh���(�ڨV U�j��i%U�E��d&�r�h�@ �JM� bg �R�	@� �   � ��9�L�0�L�h��ۂT�� pz*�)�$h#�(	 E�L+�6�b�*X�@MSm�bQ�D�T5%�qA"�_�/($�0"(�R�b�d�h�V�X�0PD4�u*�bĢ�Z�`U�Ոj��XT�6�h����QEP��"�DP��!ƪX4�b4��A�֪EQPP4`ѡ�N_��Ej
���[y�(
�5Z[UQ��F�`Uk[����`E�ATE��(��l�U�X4
��"��$����͗��E1�h�
X�QPDDQ� Z�ZlUA#(��EE��Z�O�jY�5ZUU�"

���j�Y���f����łEİ�
�j�i�P̌�DT��a��~<S�(�l[ [�*��yIUݚh- �QU�بi��
`Z����pLE� Vł[�+ֺ���x-��"����AՊ�D���Ŧ�?�n��^Z�D+';���u�V)���ɎF�mp�? ��,�J����ط���a��h�J�ʑ#G��r���c@�5�(Vc1* ��p9�!��(����jժ�6Zǚ��jaia
�**`�l],��ai���
ш�VEcU������Xc��AD��TU����Z*VT,�b!��PU�(
ZQ�"�*�jQL��hAkE�êh��"���;)����8�~Q�Uk���EU��@U��hD�5�V���:�A��Z�"���@��OZ]y4UT��Ŷm�*`���`�1b����X�C=ʨw��A��|Uq�f1���"������؂#��[�~M!F�(Z!6Z��� FD�@��C9�x}R�)�a��D.^�Y��V��P�T�a*�j�����fP����{7�7��TW�/�wFwUA�Ţ�[�*�t�G{,>(�v�9u�f�{�<��9u�f�{�<��   ��|��sΙ*�b�R98�+�C
��	H��H� �P+q���E%�R�
&`aa�&[�`�f[�* �E���TEZE�U�h4��֊��ª�
�bbATU�j�Z�֢�j��P�� ����V�*Z��hT��(��0��h��ÊVD��/�}k*ZTXѡ�bQ���*�Z�U�)��Cc��Ū�(Z�:��V�*�
bU����UT[PPQQ4��������jQT-��X4XUDTkD��V��V,XEъE�{~�RD��X�*U�`��X�ck� X�*؊��bG$=��w<�[٭6���>9헟T��"�a|�� ���H#�Fk@p-z;oOBD��K��e-���p��������5D�`�&��\��'�W���H���XkP?������i]���_���>_�NR�ɺU/� `~IjˢP�]R�Z��(�y   ��̂}�m�Ts�)����Nspȝ���A�I ��(H�����XL�(   B$9"b\VX\A����[��,�5kbմfZZ3D�4�BmUUU�VEEU4���aa��V5��uk�bi)bai1u*Z�bb�lUc+*�6*�hD�"(Щ4hAQu��5�ĺ&�VD���
(ZQT �QЈ`�h��ڢ��*`�h��SшŢCkATE�"
��UQQ�_����jT�*�Uсb�FE��Ѫ�QTkTDUDբUm��ŶQ@PbQU�V@UDE��jTպ�F\łn�^t?�[~Yz��;�U�Q�"h� *�����5���X�0EET��o%zkm��ӋtH�;������E�еEBDDc�6 E��IUUA�T1m���^EϩX��^mG[a�� �F-�T})���4")<Iί-:O��9{��i��'v�a ��i��'v�a ��   8X`�s�9�L598��88J%.�;8��� �m# * a�j��X  ��
����P |FPTP�� Õ`Ú�h!����&��m�&���(�ƪ�hUl�ATQ��*��h�Ѩ�� ("��	֪؊1:UD�ƊEшE�iъUQ��"(#b[��Q[�Z-FUc�hT1"����QEP�VQ��(�E��XUEP,�j��5Z�F��U���(��؂��A��E� �mU��XPD1�6��Sbk5�
`��(V #p��0-4P��Uԇ" 6 Z�LG��NS�Ն�B�� "F��ه�h�ʲ���4@�j�X� ��� ���������9!b���ؤ*������5���$��[}bQ9��Ik<��k�+�ح���m��e� ���M~I�V����R+�����  8`��ܶ9��0�ڦ�t8�`a�MGbL(m2 � ��Q5M�0������T�@m0 �P._TH��R�g�DY.�# �
H��FkV��&��5LC��[�`að����aZCM���BUE+**V�*�U��j� ����VE�j���V��j��ZEUPE�Etj5E��NUU���*�UE,źab����j�(:�iE��uLK+ZU�h5:Eۢ��E��
�U�
:��`�hQ@���ۊ������/2("�Q��bE+�QD5��V,�� AcUc[hE+bEUQ���v����ti-щj�X#�E��s��g��`U�b1U��"J�3�"��(jZS�(h�*(X���T�l� *("Z)���x�WU�����h(X5�1: �N�q�T#uY�Ĵ b��H9=�`]LT5UA��!��hD�ڢ��EET�R9��#1`��!2���۞�*~j�D��GY@l�}j�D��GY@l��   8X`aI�o3՜S\s:J����Nw4�0��2�#11@�h� �0�X�Z�4E-�*�ZUCULQTU{SQ��b b�b� @��_��Q� x\���J	)i��֬Z�4T�0,,D�Ǎ|���X`S��)jaKEA�RMQ�DA��X�h@Q�h5Vu�"�mU+��E�b�b���k�UU��PU�"Z���X1�UDՈ�hUĊUT�XcQmQ5b�b1�bQ��*���G�uTTD� +bQDA#*X@�AT��mDU��*��Ѣ��\��K�T�
�j�5V0�"��9I��bU�>r�]�b"����
�����XZS�%���FPTh���-��C�`A,�A#((�� �O�m9�����F�-:���h�	�1݂sQE6(/A=d�m\���[�Y�>Z�`D���M �hU����7�   �}˷��s�9M����#�T�`a��Tb hIP
P)"*V�EQ0AUMPU�@8b�|��J�)ax�F|�˲<�ji�l����6�d���i(��i,Ԫ�*bi��XQu*

�"bш��MVK�T1S��*��"b��(��XQl�6!`���X�NA�QTE�4,�O䯾�TЊ�Ī���E���uQE�5�Z� Z+�� �р"��""*(�j�jщmk-*hEck4Q@Q,F���jE�A#�� �! .u��ZТ�bUl����*�Q0���B�h�-�N���"Z[�Ƃm0���R=��"�0 
��ڬJҒ4��uTLUĴT�T ��H�'rV4��Q�&?"e�\�U���hE�CZZ!��uC�K��Zc+�XD\�PQ'��"�2�嶘 �n����4X'��OggS  �j            I
��������������������^j�D���]j�D����   8X�2��|�r�L5�T�R�ms�� <����A,E �	@V 1U-*V�ê(��)��6&`�V�5�PQQAU,*P**˓ƈ2<!>X�/&�C�DPBʊX`iU�Zbia]DQ�0LSm6,TEkPPU[#ج�X�a"j�
"�
DE��V��Ê�EA1*h�!�V��\��
��`�<�5�-	�TQUb�*"��� �A�!`�`�����eQU�

 �ckѡj=��ϪZ� �D��X�[tX��(�[�*`��`�A�)*���{�@��
т��tX�h
�K����rkA@��!���ŊآXD�"`@+��(b
��
�0,U,�E'b��baa#*"�*��"(V5 ��X���2��E�W�ը�I�1��1X#rk��""��hUP�b4�*b)�P�PKU�FQQ�Y�i:��A��f{ `�� f�p �z-��Ҫ ��k�5�V`�   �h���9s:l�����#�;�A�Q&XX`�Nw�@F[@4@D�ژ�a؂���XmL����"*�b*��)"
���TE0EPT�DSDPl;�JQ*(E% ��0�<Ap������U1�PôT1S�j"R�nɠU�5�؂bAkDQU�hUDт ��Z�"U� �:�	
Ƃ �VD���
b�!���_Gf��� �5TE�U@�Q/�p��㾨,F�U0j�$e(Z[�b A�U��&�T�q�& ;�f	Z$oU�i�Ɏ'��+#�A@��
�b݊!�>��[� (
�� �;���E��lQiDlŢ�U����[����htbQA4���*(j��cPu8ԓQ�J���Ei��0�Q,a �;ݒ]����N�dE/�xoI�jԣ(CZ��n��b�99���h�T��H̑�����ΤA�1ր�[{;{���j����c��ְ؊�!b�i�B���Ĵ�0M,�Z���XQ�&����P�Ţj�hEDQ��(bia��XC��i����i�4��XX(V@DĪN+hTE+����)�(VTU�֠�5:#��`�:T�Xl�����}�!�-`A#�u�R+X� b�Ӱ�Ɋ)��b�U�b5M4��U,
`�)�Z��@,L0Pt*��5A��b�ﾋ�^�XD��U@cEl#VQ�b+T�X���hňh�ƨ�ETE�"@T���{]\�q����\Vl0MC�f��TQPk�QS�Q�a����P��*2w���b������1����QQI���U�-�VQUEP�f�5� (�@�tY~G�U|�6��y�ljW�a-(b��E��ZZ�` *��b�B!��� * ���E�[Z%�*v�li��   ���H!	u$�E8,�L�[�0���L5f�K&vK������ȝ�� d���kU+j�Z#�QA���@�b1Ղ����1�EAlUUA�PP[��	�a��B<�a� X!	��8(�(ϚZ��`"ji�AD4�ZP-jX`�b�f�"VET���"*
`ѩE�4DEAzq�����-�0ň-�����؊X��
V����uUU@0-��`X11�Ҋ��
``ZN=5ZҊ c��Q���EF-b1�ӊFE ������`D'`A�����b;s:�rDc@�*b b�F,:��m�- ,��@EA�V��"-�bMP�BU0�� �*؂A�j�@TG�*Av�ja���i�k��I�c�TN��4QL_���>��ٝ�Y@�� A ӪM    � ��j]i�Y��j]i�Y��   8
d  �p�.�䎶�, G�f*G�Zp Xg 6�C*GĎ.X�$@i@��5�����V�j  ���0հ�(��b�FA�QQ;PS����� �jة��*����
j��i��� �v�
 G�p��J�
��qD� H�		�B�2\B(��%:��E��Z�bE+ht+*���a"&`QC��V�hT Ê�bj�.r�:U`ň�ͪj���b�
�bT�1���U���biM5�PA�a�������d��+F��h��EUE���E�**
,�`�Ul�b�ZEc��$�VN��Ѫ@�%�Wo���(�i5���
����� Z����"*�	��sC�=�I�ky���	��� `?ɯ��~��XP��b,��W�������+�  ��j    `� �$ �]�2�`���ٱ�E,����@��   � PS'��f�pC��.�m���<՜�v�_������X
�;	��
 j�
 ��U��
��F[{�iT�4 0Q��"��i��a

�����bg��EUl� @L���0,aD9�<aPJ�,����	R�p��e� �(�:+�b[L[ڨ�
j( �&�`i�`��M���i՟ĮV�.&b
��i�Vl��
�b`"�E�Zl16�"jZ�,�
6��i� ����i�!��� Z[������� ��b T�:,�2<#�j-��mѪb���N��� �%�!�NTDcQE0�X@ K���a 
X7QEU  ���U��	(��
�VmU TD5mF�PL �!�( ��ֱVĀ � ��  4�^M1��ג&�LM�"iS � �@�   Pl	   �5CH�=�4l��Xc���Ƃ����   ��)P�. �J�	����5 ����,0S�3�)�@ ��ٶTs:���I��H�lD$1�"�b��5�b��� (�b�*����""�U�P5���DPS [ �)���^S�G AUl1 L����`!*!,�# �� (N
�2Vu�Dl U�����V�A�!b���X�` ���Q��`��S�
Q|��%K�fSl�6���
�S[4�6:E�ш �VTR}���(�5Ěj�!���P �(XP�
Ш �V�V ��� � TE@t�0F6Vt "X͔��FD@QU��! � �ա��� 
 �PD� �5(��@@����|F ��Q� "X'`�Al�� @-�N C3-   w  Tl�   ��`j ޺ݲi����*z�k���M�/u�U��^3�   �    �DY | �o�P��x �:@I\W{�EU@
�� ��8�e߶9S��	8��))�&	 �U�F�, ����  (�X, T $ �b#  �b �5F+��V@{ PQE0j5��j؀�(�b� 6V�������ư� "�XlQQ@DAmU�
 �J)�0� %bb�<BA� ���P*I�   aE9\PH�E�) �����0L� �D��bͪ��VQTAM�f1 l@��
 bݚ� �� ��`�-T-  � X4`0M@� 6�(�b @+  �U@c @��@4b�
 ���0@�6� ��U+�   `i�Pk(����U S  [�� � �`@��L`h� Z�1��OVD�Xc PDD  �9L+  * @a @@4   D�   @ ~���=��s	:�1�nw<m���\��uAL   �?    C] �F��N �	5�,�P���*R � �% \ط���Y�6���!��RRM@h��B@ �* @X  TTň ��X�  @Ԡj"(��� �jAĪ#@T D@m���b Ac@P԰��v�j��Z ,��1U EE P;S1  @)����  ��\J�40����X�(e( FB�K��l)� `a#�@@Dm)��0l @P�uU�&D��
�i�U+ X3M@��`͊�V@� V 0�b4:c �� * �֚*X� @� ���KDA��  �    ��T����"�ZE"� D' `(�;*�-d:��:@l1�f�� ���5� ����Ձ ��  �    �   �! POggS  ��            a�J����69=KFM��������������޺�ʶݪ�yI�.H�Z�Wٶ[�5/	���   �   u�(#� �  x��[-��� ��p��6S9�~kc ���@����*%%�$�vPT��  mP P���b�  H%  �ig �`�X�C ��U@ AP��lLQ [ӊ�i'
���U��bc�`,( � `� ��*���U U 5MPC�   "�Jcy x"\�)> ��J(����9��-  � Rb�¢� �@�
X�0@, 50��&l E�f��� XX�4� �U��[X  X�fQ� (�`� U���P�X�X@l� (�X�E�H�=w �� :@l �R��V����E�&P , �# T��b� �b �X'r�Ɉ�܀�I&����h��a�
  ��� @T$E �  �
  �N    ���]�X�q�bc�T�JǢ���3�   > "�N�f5u�<L/dQ�	pZL��v�e�}���+?�!YX��RR�&	 �����M�T#��1kE���
 V�Xk�����
 �1`U  ���N{�� "b�� 6���� ���ak�VSQ{  C�T�bc�	��IQqIBJRT�O��<	!q)I)qi�A  � k6��
(�
��6��" ��6�� `- XZ3 �TU�*��0 L5 4���*�(�l���6ji �Z �UK����*�""�6�X( ��u � ĺ��贪A   lE�
 ��`A�C5m�a����D1 ����5@�� �h� �5Q�`�ZQ(� ��,���O�� Ϗ�  @@+ lA  @+��0�P`<  A�
   �F5 �^C�f�!�x�����d@Ź����G�gQ5�K/������f������fC
$L��Ё	�H���cH $(F�G�QD@#�Q�(_��);9�R�����	�f�䕮��!��͚�+]ŋC���c@�J�2 �ET:�h@�|���}_x���4(��r� ��s�������֭���`B1�Tc�5� ED4(�(��b����4Vt����F5-T�TҠ� �h��ba���5�X�@&�`�@.(HF�Q�@��������Z?j���i���T4�"t�Q�A���{���� �N�U���r�,�%�l#'è &�/���!b`)��)b-Q�5��"�F�*blEc����j�;j�wU���շ�ZY��
Y[��@Ip+�_!k�(	�7  L�{��S��R�r4M�)�hs���AL`2	���6�6J��X�0���bc�v�W@���ዲV,�P�l�i�����jiiiE,-L��U @E��Zk�b1�(��U�*�ت���b���5UE��X;������)VLk�bʹ�j�"X5M�6->ywa"Z�Q� (��j�|~��| �V@��X��TU� :�X�`DQ?!r/�Ù\*�"֨��b�5��Z
FED#ƶH}A+*؂-X�*�U����[PQĪ��5�i38ה-bE��*b� �UA���~_j獃o���E�UXT,�f� �:m  ��D/ �U� [ժ���I*������v,�8�|ki�[P�U�,'��w��]��/�6�����uj  ��V ����	 >J��A�w�6�� w�
E����m0��   ���a��6��tp���t�J\[�9s�(U��Ц��� E&0m��m��!�& ���"��
B���
K�R�ai�� ��*�51Êa�VL��ѠU�����V�X��EDT4�(U�����:шVP��5��ai�ªZ`��XW�n ��FT�FU@QPD�XDE�h�Ul��E��"����Xc��"V����nײ�F��bEE��P��T�G�Z�Ə�x7G:�jPlD+Z��"VA���G�'�����5��"�A'h,Z��(D��
�`�t���X���(��ZE�Q�hU����~@`����biM-MU ��i���Ŷ�`A�1bP����j��� P�* "X�#F0�M�G�l�VUE�
��_�m����6�t˖�MDT���-K�����ŊV5`�56��ʉ�UTc����Zw���
j] # �N������~ze��w��E��,��W�z׎^�;��� ����dE��Q*Gs:rp��(e:��8rpH�1 m�j��XlT,����c��k ��Hai\QQ 1,�Y�Zѡ�jU���V�A�(VE���VE�VTA��Z�[��Q@kU���u�h5��*:A�"������@�j4��ub���T�{�)�e~�ªh@��bU��:,� �QQUtۊQE�`� �ВT�'��EE����5�r�Ъ����DlQU�ǭ�I�{d��Ȱ��"���hQTՂ���"`���fU�A�hEc�ƊU��z&Flc �)� ��5L@'� � l�VT@t(�b,�E�J�˟�)}g���"��	]d��M=(�C�8�zbP�-�F#آ5��j�g��o ��**(6�"*  �NE��<�IeV$f<ְ�$n'�Y���X�
��_ �г�}nS\�RM�9g��h��R988�� �mI&S�{1��b 
��e$Ť���X��f�6Y
`ݺ-l��
 �(�T5�-ZUUt��
��"j��a�!��!�&bib]--�*�-L+�Z[ѡ� ��"":U-��u*��
���Қ(��F��" VUD��V+�Vթ��
�%J��i��6��5�"؂����h+��`�VU���^@����"����X��ܿ^>�#�ޅhP�(��V�U��A�X�Ƣ�VС��U�h��A5�E�XQ�F��U�(�j��>���bD54֠*1Zt�A��z9)��1ZQA�QD�X�T�b@+ �"  �F� �F+�Tz����Q0�U���}c��hN���ɫ��L�5����\�
��>YE/�L��X��`D4���1h��   ��X��M�ޝJ5D����R�@��|? �J	2թJ.I��������3O��)6���� �mQ!
jE��j�XL�L1b؛ �
K�$+		1	,KK�jM��S�b��P� QSź���u,LU�a�֡�j51S��P�"�u�VEEщ���
�AAl��M�魊hA�**�ED��**�K�'�i9�y$P�j1�
�b��آ�
VDT1��
��"��C�(֊�ZA#U�5�|�ЁEkQ@@��NŢX�*b��b4�@�@PT���F+�
Vu�hU�V��(�mQ-���jTU�����ZP-�P��f�b!�X4�j@E�
�'��i�4ML�� �S@DD�
bT�0�V@Ј�  �"VЈ��b�;�V��n�QA�QDA�Z�*("�"b@���k����  A����H��׺"�Fr�w=�f��
�aZT P�V���V�~Z�� $�x �Ӫ�!����   �J���m�6S�J�h�Tӑ��*՜���&��e��������X��1�b5M;��	  |���0EkE��Ct(֩�U�!Z l�V��X10�XQ+6Z���*�*�����ED�Q�؊b���V��
bl�
cQl[D�+�VD|�V�f�X5�j�br���m�b[���T�Eբ�-*�؂�b1`�(:T����QEP�`��j�Aъb�h~}�����j�֨* �1 ��˯CТ�b��p��~cQ,V�X�(���`��UU�FUQЈ*���m̋���h�QŪ��Q'A4PU�6`@��E:TkU�*��(j'�8�G��Z�ʥ��
��`yuD���ܙ���u��7}�u���ԧ,=��4��w���{@@��ۈT ��km����2���+j�-�� @Qdd���� B֕2#�9�C*"�>S��s�9������071�h6!0�Z�V�b�(�1�1b��
�A)*.baմQ��X�����N�b-�֢��u�������@QDѨZ-�*+�F��XQEA�1X�� ��`ъ
(� ��	`��Cߣ�?8Ww� �A#m>�����s��f���������T1Q1Q���褭b�U���ZՊ"�APQЀ��%��J�Q��VQ���[Ċ ��QT�E#�-��U�D�#:4�� Et�*���"�#X0(b�N�ÊƢ#�Ī(��m����FĪ��CPtXU-��T� �T��E܇��UQ�� �"�h�U�(EE[2(�����R�$�ΧwTP��� � ��R'�ibiU,�CAT 4��D�� �� �S# �B�OggS   �            �u�g����������������6688798�jq�F��_�#.�܈ �7 �@pA�ڶm:r4g�9�#G��6S�#b1G[
@�("3��ۛ�a��Z�AM�ڨ��b����! (+!B���	�|��
��)V�BmiULK+�ai����1(
X5��TĪ��`Pt�ѡ���a]A-�0PQmt(Z�V�h����

QAբ�R���| "Z�Z4�ӕh�j���(�UՀ�b�6:���X+�XU��k1�`A�V��X�b+b��@��E���jDQъX(�*���j���U+*���
Fъ*X��*b+X�����"�VP-�?��&FD+��bk#��R��(VDѩ��ш��*�Q�"��֩�(�X�D���:F�C0���ZcѪ-"`P���5b�L���I?��>�X�hE�  ��j�I4" �� J䠹��^!����ъ+�bD4 @A�&EA,���N  �A[����F�c�=V��H �  Q�j=���Y�̧#G3�3՜�MGsK���j�ڙ�@��)Ċ(+�bkk��������Nai�d����� W�A'��huhujQ���j���MKT��b�.:4b��Z�ND�U�X�8��{֨bc+��S���U�Jr�s��e}�hU[��~��N]��l�؈bD�CPPl�F�SA+�U�"���*"�QU��X��-`�XT�(�5�UQPU��UP5��FT�������Q-b���"ZT-(VQ,��*�X�ZD�(
E���*"�ĪH��.����z�TlUt �(�"����mT��(�Fdݝ���A1Z+�*�h�1X1MS똈%*  ���*�Ek���|4�s�I��\|
3�K�c��ު-#�@��X��h�*��
��hP���P8@E �� ����U�4� [�X�G�/�:��� �7  &�os:J吲��ќ���T�����!��1��� $[�4L[��� `D��BR��,W�ia�bZ�A1M,M��j��VL�0�&��uK,,�Fk��UQ�
h4�"�V�AQQ���CU�5E���(XD��*�S(�4�U4�#V�QH/Y�N�#D���%T�UI����`�i����"��* bź���FG&����U�c":AE0U�X+bс�m+b�*��AD�h1�����bU�Akm�bQU�؊�������(��j۠�NE@�����t[T1hTQDU��E�|��s)�MEk� �@D��i�|u�����11�P�+�I<�K_�g��O�D!���b���JU���ٹG�Wt����z-E����Ɇ\� k
0 K�e�G�b��l �H �  �J�������9ڧ��j�9��t�����fA�d0ƈ��U�s�\!)O���b�����Ѻa`ET��b��0��
"V��U�TL�TU���BM�&b���i� +�VT0� �X���b�C4��V��Q�VQD���V4�#�AQlQE����F�!���M��mQ4c��*"7���=-bED��n)j�*"����)��uc+��j,�:E�:$���Z��T,�����h�"�*�5�bcE��UE��;��<mtZTQl�D�X����X��ZkDTQ,
�jU���k��؂N��(�(`T�"hQ���Q��*:U�FDP���X��� F�Ѩ�m����X4(�mT�5ZE�FQ"T�uT1EED:Ū`1�QD���`���("Aq��{.�`@A��JwXn�WZ��n���ۓ�����%)�EP�X�v�t ])^;=R�I n��H�'�   �W$IYS�I��mN�Ti 9�s�9�tH�ʑ���P4@`�F���,*���b��BBb��D\��"��!��j"X�AL�0,Ūa(Vl4��B�աڢjuXt��֢�:�:tjPDX�X��-E�RD�P�.b�ѩ�@DDPlDk�U�E���*�j�A#�XQ@�b�)��GK�]}�/U���:�����KM.:ѡZlD+
�-,��hQ@Q�hDU�h1FPU��jU���j4�+�UD���E��*��բ�
bQD�h@��ZT���XUP�b[P��Q,��ET�*Ѫ�jcAՈсAQD��V�"��Ƣ"FD+
:t� DH��{�H���h@A1����+��*�:Wo��#�hŨ���wI��Z�� �`A+X+�pM��)�	
����>�C��Hg����я���%fy^�ZmfL�����fƴ)���  �,�-2�  ����|�y �t�j:��ќ����Á�d!F����@lհ7L��bc��bU��` �"T���)e��Qp�� ��p�[�iX���P�TC�R0��bbU�""b�"V0-1�b��R��*���-h@EPu
�N�(�- ��Z�a(X7+�X
�ZTE'ZQ�
hQ4h�Ƣ*�*(
XcTQ�5
�Z��b[ATAlш���AAPD�c�
���A�(`���QTT�Ŋ�Q5���-��QA�� t Z� ��#ZC[+(�mQ@+֨bQmQ��`�����ZDTŊ4�6��ԗ�"XEt`��`���FEա
D�5�j�`TE�U�  ��F���X��(�j�X��V�6"X^yU��ڕ/���c�>*�}��^�5�<Ay-�)�3N#=���[�+jQ��RK4� ]+ �Z]E��VWQ�@F��  �^�Yo!��0��r4��h�J5���C*v` -���Ű��ڣ���Xc-�UE+"V��j"(� ç�0��Q�U�D��-T-0-D[(���b� "F�(��D�AQUEՂ�h+�*�-�֨�bU#kEU�jss}�%����5K5@�z�T��(F�AP��m��*XZ�*bTD�j���`EP-6
��j�"*�``��j�ͪ��vc?��6 ���l��(EE�XUD�(�`Q,-:��Ky�@�FU5�ت��K!UU�E@kUQTDkQQ�"
��֢l�AUD�*h�V Q@cUl���XtA�b+h�A�(�����e�;z0FT4X'��w�!(h�1��1bT�vD�;D-��A��c�mM���D�A�k�<�?�zN.����\�@�T��K��ʈ��< pC�U6� �   �wY�TJ����Ɯsn��s�9g�T��#1G��$�v�h�V�, 5�Z�*cD�*�b+vb6�aX��N����!b�FDJ��Jc���4i�+�'��0#"��`y�+`"�bi�����6�d�-ZE�S�j,"h�(V���PP����jt��V�j�j��
:Ѐ""�NEU@����F�j�*ZEUE+��b���b
��`���TJ�y�t��aa
����%��	 ���u1�""

h�("���5Z�:E���S0V�VT�FP�uXA4X��@+*:E�UT�F�b����u�hT�U#֨"6Z��*�mUT�S���kQ�����h�ZQm�VT���bEU�(���4�Dtآ�VA��-6V�UA�Pt�
:�lPE�uj�X}*�8�$ֈ�EP�����Dk,*��(DDD����FE+�Ul�#RDHQ���jk�]��c�
�^�"�f�8��h辥g��	 �fCSq����M��Yo�L���00*"F��V�I�vN�es*��2{y��ZKM os�2vx����	���a�P Ia	�e�+����sk��|����v7���=w�j�0m�TƿՆa�0��@�jQE�H������Wצծ"A���&Hrz��F� �j��<uB�~�}�	�:!s��S)����c����"
�M\�#�Ծu����X~נA)�~�Ry���[��[$�0� dxb�a�����E���Yǋ��_$�j� �����5t�
ށ ��4B�(˕F�!W-� "h�;�ئ�uوg�	h񿿂�j��5��w�[ʚ���Zo5A��F�Z���"�4�!G��$�გ�'Z����xSOggS  @�            X�]�JKDH��968765OO����������������
$���npx�@�+H=�ޚ:��	� C@�k,hDkkUDTT��EѢ�jkDT�wT-"����f��w���D9�nS&S�e��JݦL����a�6rAH��������U�����hD+���*�:U�@4�h-��&	!�يE��(���H �jk��	����YV',�-�)�	d����NQm��V�V�*��~ݭUc+��k����y*>]�_� ܂�����܂�����|�D�$C�f Aa.��h4��������0D��ZE@���WR4���l�hUQ�S�<G�J����� ;��uA�  ���""��,*B�`��3��9r���!��TN's#f&�R�ZR6#P�#�QE�A�b,ƈ��"��
&*�������|ʑ�T���b�*j��b`Ś)�a]L0DQT�X�a릥*�ڈ��*�b�(:�Z�j�4-M�+"�AQ��6���������EQD�(��"�U@�U���}�E-BT�"��U[ժ�c�X��`�Pm�R��և��,�"�e;�VcE웂HU�ڀj[K�G��X$�~��EQ@�gm���}��P�b�Z@��?�HXD��(� "����jk��ެ�A�AD�����lCz2)ւք��.C�2mB߲4���Hu<���d����Y�ֶg��u�A��*���-0 �r���N�o�y�m��ԓeJ�d�cU�U������|(U���9��og�5�p�:�^� �M���k@�	�{�-��k�``T,"�Z[A��(�� :ֿ#y">.���v�b
ٹ��nTL!;w~@=5efC�� �V������R���ӊh�&�9�����' �n��	!��m�9!D@�t�E���#�X�bŢ�.��ơF?a��=�� �^�Y:�n�u�`��C�P�(2	rr2�!��X�e��8�Բ��[��#>&�O��v�\��m�m���0@��00 5)� �-����C^��`4���A��\��j]���$Q�nV�2�=�&�t@p	A2JdE)�Z������߫*�FA#(6�(�""����hn	��Z������_L��ZYd۴M�����"ۦm�`�l`�#''CUI).ayUV�i���ĊXn���[EDcUk��Q��������� ��z���	�����2��r
ۧ��P��P5��(##msΙ*՜��T�b��L��$Dj{�P�I�����X�!\QI.��,#M@B�1����K��T+�b����h4:kUEtjT+�bEAk4�(���h5Z�� ���jѪ��QT+��5:ѪV��(�UA�Ek��h�hA��
�E��Uc�
Rr�zݢXcElUuR�ȡ�j��("F#������(**�T�
b�U��VET�bE+U�ES�����*7L�Z-
�El��
ZU#���(ct�XUE+�Xc��r��m\H�[j�Ԗ+;�H�r;����^�����&B@��a�䋯�.�_D,��Xf!p�!Cֱ� ���},�Z��<�'�<][提�k+ý^�5d�y�\��G��B����k�`���Ȁ��0�F+2`�A�?  Y+(2A^����L�o3���tp�@�h:̙j�b����k�{��޴`Z  |J�4!#%�kְ��USAc��EE�UPCAK@�F#"����aZŴ�UU�L�(XUt �jѠ�"�F���UT�
F�U�w*ѷ'(�Z�Q�Z��X3����Rk&b�K�`Z����h,��X��Z�A1��m�bT�֪EQPt"(
�b!�����b�DѢ(:�5�:Պ��S��*V��`�jE+F+�oJ��[�(��� ���(Fl�b�-��`ъX���������S%�8�@ł�(������W��oO�	Nr\���E+�EՊlQtcР�E�Z����t7y�"�Ѩ�*������FcD���
�j�U5"�hD�""���[PPEE5*�ъ�U�Z�*����V����n���jʯZ�ȋ�P�= ^J�D!;I��w)��8�$�Z��  md?{�6Smsns�T3����#G�9J�(3	�-!��ao
�i�1 ��YaI		F@L��b���j�fl0M:uXQD1Z4V5��b]T�E�PE�բ�X4V4�@T[�NDkE�!b�TU���V+:E��ؔ������RM�jaX�b"�*":ѡt�"�Z,�
(FkTE4*Z0�V5�괈 ��j`�4�XѢT�VA4��V-(hTUЪ����� �j�ZDաѪ�� ։��E��m�bŢ��(������B+�b+h5�E�`E����XT���њ*,�O2t�=��5)s�&�����D�ZX���s��j�U�AchI�v��-��*�E���X#�1*b�\�vp�ǴC�E��5	�1Q�b0V��F Q�e��v'�jQE��hEk@cU�s.B����O7W�[��� >ZŰ��MC���b�A������} �}�e�ۜsι�s�r������a�r�L�eA-Դ50-���i����v&��j��ۨ`QQP  ²T�#�Q*(��-M,D,�`MU�QQTE�h-��**�Љ5ZD�[��Z��N-F��Zՠ�bk4��U4Z,:u�5� �(�bшF4"Z�(��DUEQU�bU����hU�X�Nc����X���Q0���Z+*ĊuUDSԴ*"Ƃh�Z:E�6�D�#
��i*ZDD�*�X@�QTD��!(`D�A�`�F�XD5"�
�[T���@_EA� #����E��i��ƭCWy����(j�jQ�շ��/0*�
��h?W�h-�NA@@c[�1�hD �"*g�/��~G�]v�/ł �ED���b�,VMn�
�Gmg��{-g"���kդ�hBb���)T�ZMD!n<@w���B�<x�$�7 �%�o  H�9�s�9R�9rHq�����t`&ѲHM�0{{���jkP
��ՊؘX� B�����O��f�\>ˁ���eXZ-։�*
��S�F�(FՈ���jE�E�*�F�QE�
Q����V�Q�"�ZDD�FTը����jT4*��U�EUTk�Ѩƀ��ScTQD���h�(ƪ�h-F�(�`UР�`[�PAb4�ZPAbTEŀ�A@ъ*(�c�
hE��QE��U��
(*֊�5`Ŋ"���~��l�A�����*"����~W�����{w}�c���s��X�j+��v{�Z�Vʡl���5FVsx�I]Ϳ ��ъ�|y�PEW��R~|5%��$����h��"���U㸮�Z�(�5֊  ��  A��v��Q�VW����}�����:-��k� ���F(�u�? ����Q'�@��|�9͹9rpH�8�a�J5S9�LJ�ɪ���V�Q5j�Z5  ���&AE%%8�5��j��"j��BL��b�	������UC+ZE�ZPD+`i����XZ3MKE���*Zt�F�DU�b�����Z�`kD�h��aQU�(X4�Z�"֨FTb��*����^�
-Z��QĠ��NFUP� �*�E�*E+��D�
�E��FթX4V�P�
�*b�bZ�"�S��E�T��U���E����a}�%��{�&q�O$�FTT,�h������p���-��
�{m#�)c��F� *TE�O��_����K_�ZP�� �EQ ŢZE�XQ m��Щ�
�bU�� vm���bPPU�Xcl���j����(ȑ�w��걛�E�X�b���U Q5��b4T��Ȃ���.o���:-�C��cҀ�:-�C��cҀ�   xA�(�F�Ҟ�9�sΙ*�t��T�9r����-��0�`@D�����+$.)%"�H	q  M�� e�,,l +��V�@0m4@l2Q�4D-��.&bXC�UщU�T�j���b�j��QѪ�h5�T���ÊjUU,�hU��AUDU�UQP�ht�h��j�a�Ū�h5*"��[PEA�ֈ"�*A�*�Q���h@�""�:���h���VT���TEU5b�cE���hUED�aժ*؊��À�#QA�؊Q[A�
�F�X� `��E�FT�V�A�ւ"�TP4���qu��*"*��XD+�7� F�֢���̹�WD,Z������u�|
4����V�ʥ�����V�b!Q��R���ܭ�Q��1ըX#R��b��VlUtK�����'��hA@��E��ѪXAT��

�1j��d����L��ɚ�OggS  @�            ا�������������������J��C��m�vѡ��~ `�8@b���S����h�����)ӑ�T���FI4��5m1��V5����ikj��) "�B�����uK�V�ڬjiŴ�4�4Ě`�hEK,1P,,Tl,-L�PC,�����*�
��4"4h�V�D������(bEcT�Z���-TQ�"�ƶh���j�`]Q5b�X�iQ���N�KEU-��C�%����5+*����`�"X�n����"�!�*��h(�ӈ*���a��UUTѪhU�*bPT�F����l,�ZщVQUAI5=>D��X��XArG;�UlT��)�_�6\ku_޳�Q�V P��X��̵�Ҍ��V4D��Q@D9��]��Iq�AEEk�"���+*�u��E���V-Z[z�RƟ��aD�ܶ�??���D�h0���$��;�*]B,Z�-؊�n�}h�we�[�L� ���d*H� ��   ������9�rH������a:rpp�@C�
�
 a�������yb<�|AQ�d)��X`j��6�ҴjZ�� �֢ՀN,���5����*ZT1FE�:ъjE����Rժ)�V�����Ѣ�:4�(��j�iXð0,EA������,��`t �m�(*�*�*b�*ւ���h�VѢ5-,K�T�(&("
Z[Uբ�	"b�֘�b�V����j1�FEA,Z�
��F�(��XAD1�`cA�8��zP�*b0����5�����-���3
��U���Ӻ���9��r�"�Ϭn�8�S�Թ�Zm���a�����&�����O�n)�l�/;���Ms �`U���h@PUՀ�yW ^("�A!	T5F.`�z��?�h6�ж�1 @ۮ�g��K5���A���K5���A���� �hٶ9�97G3��I<�my*��3��Tb$%!����(vV���Z�r�� ��\�_�0EQ�4��hi�%�*�FQt(��0b�6X� UU�֪Z��"��F#hѡ�hE�Nc���0+�����1��:�Z�b��fX���ՠU��iDQE�u��bQQ5�
�jTD�Z����UQѪVUE�bհfZ��aa)��F�!VU�jT��QI!��F���m�((��F1hT��(tZ�Z [��%�`s�"ީ��F��5�h��Q�V-�"ZkEA#�X���*ǟ^F�UEt�QDE��TEQ��(�'e��k�WD��:km#���1@ET# �� ���j@Q ,�F�XT�Z�� �KYS�*�D�jD�V� �NkA>m�+ƊX��`��:E5 ��A+ ᾦ[�1#�N�`�V�`�b �`+�VjK0=�b�]��:e��h�~�S�*��p;�!��   �i��68�`�۶;̔�0S��hϧ@*�TSL���@ ��ac�ô�1ll0��l-*  6����jvb ���O��	3 �
Q1qA��(��V-�U���5*�*֡kEъXQU6`�jEQ�#��VMK�0����%���KӰ
h�V�Q�1�PCE���jF�	j����L�Dĺ!�Bc�[T�dk��"�"�F��A���4D0b{��
�U���h���ƢSAA�˷�]�k�D�`TŊ��谢��U�E+ւ.�F� �lA�bEEc-�h�X�V��(�F4(Z-�""� R�����Щ�@Ŵb�	
��X@� ��V,  �u�D@�juh�bVQ��b���wA�"EUE� ��XE����#��\�y�ӗQ@+b+���曀�h��$�36"�-b#�`�" ��K��R� ����Z���L?VM��żתL�f��j�.��   ���-D "d�i�|:J�����#�Ts�8�"Nqc �� �`�EcQ�j؊�ab1D +)>+� eE��%9<BXJ�*�V� QEQ5�"
��V�hA�X 먪*b�Z�kmEP�
Z�+�5���{�`P���S�E�Z�E'�F�ջ)s��۪E�����5��AQ���4�"��CάPU[��*�j�"�������SU �Ո؊���t�{�����Y� Z4�UDЂ�`Ak�10���һ鏬�VET�(*��㌠�R�TEQUQ� ZE�wx��cA�{b�ͽAĊ�C X� @�`�UlU�E�*����?�%����8�m�D��jTD�*��uZ����I>�`Q����kbo4�;h��&F�V��^KY�/q�_���RG�K��< ~   �+�6�<��f��(U��(�t���9�pH�m � v6&�Y��a� ��J�s(@���ą��\ai���lZZZZ��X����)-

�ִ��`ZS�4E,�`�V�V���P�4,P+bX�XA+b��
�2�M�{�bѡ��T-VE�FՊ�"���`��Z`X7��*��X+�Uъ�V�*�*�T���ED1Ƚ��U1h(��UE#"�UU�}�8��j�A�E��5�A���Lb��/��NUE4"����D��QDQT��"�R����X[���:�؊�U����k3�"FPmTE�F��N�bU#�*�� � �hlc1�Y ����5@�   ��F1 �a�RPUk��QfGժjQ�jTT�EY���)ik����`Q,��T��o����^Ό�xq�iTl U��c�o��t�,����F�"���T^;�gݾ���ī��ڳn�]�wP��   ^�eM]	��|a0�%��Q�9SMG3�$K���!�I��NM@�Ԉ��E1�4TA-& @L�2�������J2R\�� ���6�i��V-�P5L�:b��i�a�"����QK�ְİ���baݰbZ�%j`Xc��U����ii�D�����jt���D�jt���*b�ucz��KCU�.�R�ו^+��bUЈVQ��.�����)�"�ZEEтQQ�blEQ��<��E��l#Z�ZA�*�F�(�6Z�1h[��`UZ EY�G{Pu��U4Z,��� ��ѾNJ�1�b-
�� b��5V�bEk� �����5h- Ѩ�QU�>Z��ϯ8Ԗ��O[(�����"h��_ؒ�ߙBR_�� �ǊTdQ�l�yRƪM�R#����l�������ݿ�fxJ����3P��J�@ٙ���   �$��As���h�<w�Ϲ�3��tH�2� 4�$�Hbg�i/��Vl,V��Ql-��Z�EC� �#) �
��Q��� U���!�V1���Vպbai]L�j�VL,-T�hT�����j�*VT�VQ�X@E� ����"*��E 1ֈXk�XDU0F�
�FĈ(��h��$R��r�u�hF��"�(�EEPUT@EQ�jU��T5��h5�V��E��FT�(
:U@MATCE1�*:Q5�E��fX����V����nPT�:��*�uZU5
������KԚ�Q4��T���50"�EѪ:��֊"�hEA, 
FӚ!��V�TP�: b
�EŨZ�Bk��Z� X1� ����h�h�-��F�?3)T�n��Gy\�4�k�Ŷ���T���
N	j��}zDUT�ր�!|�[, �qfX��)bA,X��Ek#� ����jM���#7 �՚dC%Gn �   `�rG[�T��T3U�TsNb1���\j  V@�ሱOP��')MD�@�+�g(�b��b�ҚZ�,,M�n�+�b��i����!j�j�`�bX���UTT@�E-m�f1�TK��\v>�Z�Fl��*j� ��* ��4 ��ض��h�H��T�"* Q���E���{:GMX����-�R�񮖧G!�-* 11�@E�-���A��Z@zj!܁h�U�(�5تEUk��Uhy٨a�E��F57T�;����ZPQn��Ն1�؊Fk�1��"`�U�i����� ֩ "��U(�!Z�R�RG��凿����[Wz��)U_�.%YR��"�D�m �����'H��A�J	@g�X�0OggS  @#            L*�Z�������� �����������Jm��Iܮ�R�+h�k x   ���h�|:��f�T��t4眩R�rp��0�H@K	��P��b����U�b��aZ�j��Q ��JRa!RJa_�� ����i�ST��ĺ�����i�jUTU#��CŊ�b���i��C�NE@D+��� ������PKA�ۃ��U�0E�f�K�_�k�|����AUmQDl�DAQE+����  `�!X�V���Pi�Q���
���WT4"�X����[�a4�X�VTEAA�
�E��V-
c�
Q��C1�*��VZ�Fk��`AP���"�VT��jUA����U�"��A�-E:E4hD��� `�ŊN�*�hm��� �UUŜMx�קX7�7qf�E����
�(�&�(�jc4�r�����bG�U��QD��W��"
�5�{rD�Ԟ%͐�W]�h� X0�"h�  ����K��< �b��T� �   �B��� �t����t��9��9S9L�T)���
 d� �bo�6���Nl�Tl#jT-� 	AI)aA	.�H	��+��0 �a
�M5-�"ְ�UQ
�C5��V����-İ��B�b�*((����m�kŶ@DU�D,I�*B��ւ*"�֠�"(F�hU�؈ED�X�TU��PE�gE��R[��N+b�L!�P�
X4�`�V5�5T+b4b��V�F,b6DLĺ���M��o�w��K��TD�FU���EDD EU+h�X��""�h�E�F�Ѩ�V  h���iT[#���Q�UD�5E4� �b�(:5��06 �*�A-�-V�Ơ h+-W1Y����.rr�M��X Eب�X,�|�TSO�\@�j1��|�W����;��h9H"/�e!�hD�b,"{�� , �;�M� ���nh� ��   ���j! #-��Mq�J�;���t4MGĩ�R�H j& �L���U5��[��X�D1Ma��'�bR�<�/ ��Ó%��c�Ҵ4�,�Z("��X�f��� �hU@�"V�@U��PT��bQѨ�E۪"��:�ZG1L11UE���ÊƊU��
�щ�FE��(���S�O�b����X�5�B P,*ZT[����EA��"jv$�� b�iZZ�BQ$U�=h�F #*(�ѩ��  ��E�[ѽ�Ra[�h@����Ţ��Z4�b���*��Ac#"Vm�bETQUQ��Eھ.�":l�`@U�֪*��* hQEQ�>�H�P�b��`D��A�D����_N�ȈkQE�,l��KW��� 
��q�I�z��,|ľ����8�dU�;���C��w�9<Uk0 ����Ud�7� [�=>P�N7�:�z|����   ��)2j�L���)2H�|ۜ��r�#�9��sΙ��tp䐒Bj+ hF��j�1�*� �Ű1�Ĵ��
�XccQ� �XFD@JT@�.C a�� b9,�C����UC�R��*�(�mXX�RQ1MSLK1�X�E���ZkT�Z�6��bU�0--EU�FE�SQ�����b����-�F�ǚ�XTkQUF00D�j�iU+k@k�e%Q�SSSE�&��w��O��n��
"b��F��ϳ���j��c�V��a�"�����(�ƶ�*��VZ�5*�AcE���߈�@E���4
���*Zl���Hq��M�M�E��4�5(:UP"��ZE@��F1���:@�Ū1(���C��U@��ѢX��Xl+��:4"�b��j�T4�-#k[�`�bC���Ȯ�~��eP5FPl�(6�b�Uc���X0jG��Ga�ȩ#�E�F� � ����%�Y` �Q   X+$( >[�t��&���x�$0��   ��5HK �69�r4��(U��(��T���� �5 -2��"�V{AMS��0l���ǈK���(�˧�e�� ���6�6ֱ� QĚ����XXbb`MEU-h�ѡ�QD�*(�*Z1O�>ro�!����U�@TĊDQ��ŊjT�A����b��級��A+�NTn��E�G��k�`1*Uѩ�E��_TӉ�/ESA�h@�Q1��i�Qm@U+X3MT ���=��$��wS� �VDQ,*X,"�Z�.O��bUT�Ek���}RV�"�E�U��E+���>O� �؀b4VT�ۀ�ηQ�keTl� ��V� XŢ�v�s�_L���sƯv�-��D����q�

����*�,T�2jHּ�I���Վ���ݭ!�	��( �Z���  q[�]�Bd$�   �b.�i̹厦��Ts��s:rpHE� ���$�5 Z3��U��bk1�7Ĵ����Ŵ�vUUS �Q����D���(��J)e�AP�\�cAD�
6X1-,ELTKL놘���"�@QUTcQѡŢ � b�VŪF�N1�XĊ�"��j�j�
�`�B�[��f�""��F�b�jlF��T�ҪUM��V�X@DŊb�(��Q�+ ����ť�v�nH��c6�� D��Z�*6���]x���mU�ZPD@@c4*�"��"�`��iբ������j��@UD'�h�*�b4�"�TA�`(F���Z���AD���qr���c E�(ֈUѭ=���҉���k�qw���*��
qJ���֙GGC���D�俚c)o��9-��b�k� ���S� `�7/1 ^:����G���N~D��   �1H<�P�*E�`��;=O�J\s:J�(�W*G�9J��I� h)`X�V[ӴC�j5,LEA����5"`5"��1�b�)�P����I���*,!( %�
�`)cEU���FQmT��Ӫ͆�
F��֠�QT� �U��VUA1�R�QA��fb
"�����-i���Q�(��4EDM��*A�Z�y- �V4�`�_��$�s�i�a�&�,�4��E�V-"��E����Q��"b�h������n���h����E�bPl�t��}�ЮӪb�"��hPt**ZPt
b��'�A��+(�V����ޚ����" DctbE�4���܇�r*�X��
V-ҭ��v ��-"�S�(h��X�ϪQI�qCnH�@��b���E�hG�4�m�@c
 �,�;TP@�D��6H �J�Y+Z �n�ά-�	`�   �)�Y����/ طm:��5S�9�ӑ��#�T�R Rk	 hf$�jc�1j�V���4SA��4m-j�T�P|"@� Ɨ�QB���rE$�����
�����PIP0�ՈjE�N�FT�`"�aʹ4ULӰPSk���Z�)�`�j�a�f�L�4E�VQ����T1Q�V,lTk���h���Z �bU46�`+bU0��Q5��Rȟ? ����DT�T�j� �&�U�bDѪ���v�c�"��X"hQ�
�-����`kD+bc��E��t����T+hEQ�*���X��h�X��mDlETt FPE���FT+bcDE�����"`�(hA�(�* ����������A�F��A A+T4�X+
PT[ᨋ��� �Zc� dU*r��<�w�DU�IQ�q̪�h'�`cQl�ݓ;��]����#��"JK���u�[W@�� #� h� >[�u��	��Vw���g�   �/"�T� �� !qD>����Q*G������Z ������6j1X1j��Cm�,VDl1Ű*Ƃ�U1��a�P��V�§�4)i���a����ケ���P��F�R,,UL�0UTlL1,1@ELl�"
*�AD�C�1ZEѢ��F@L1,A�Ĉ��h�6��hEQUD+���`��-AE� ��hE�*�E�Z5��)6j
Z�`�"*
XA���ت��XPtX���
�%�^n?�ZaDTt������,�/v�BÙj��)-�n_`+���U#�Ū�*�z�D�U�!�rS�"�h�X�(�� �)q�+������b
bk�����J�~��jn�I�r���w�k)�.�R�&:�k2�z��!�:�za�b4
`F�( ����` � ��
 OggS  @J            Dp�����795FMK��������������^[��XgG
�][��XgG
��   x����"hㅨ�K�������L�tq�J���L��a
�9�$K��  �� c@�Q�Z� V���X-X�(F"��6�ED��(*"���"��������C� �"b��*(&ɥ|aB �40E�&5-PPCM1���a���i�ia��Z�
�b�jX�D0����V�V��Eq�կnjU�V#��-�
���P�hT����]UQ��0,lK��.�;���DLD1l@ŰTTѨ�E�!����h@PEE�nkj�Ǻ�ق(b,�QUOi��Z� F�-�5�Z�A�[���Т��aQT��B�N�BW�ETtZP����H�☴�  -
���bQ4�ĂŢ"�EE��rR+�:��vn(w������FՂ��
F# �7�p_�EeG���U'*  �� ���9���hcN+� ����   �Y�5B Hk3�_�!$�E5�0��;J�;L�;8"&&v�Tb)���Ȭ�A Y�����b�����X�D�ֈň � XԨ5�U�D�(jgE���X����4	iB<(�'(!D$$x�������5k���"�)�b�M�j�V�b!��ai]1T+
����m0�BTժ�BMD-MCT�F�0M,TP�0TŚX����XA�+��V�EAt
��V0*����`�ƪEL�°��1-��*���U� T�,�UK���	�!f�,����E�E�X�uU�愋{T�*lTԺX�j��Ŗ&�&�Q�؊P4�ET4b���*jbMLTy9�\�j"-e9[�v}:�_#��F��~��\��뽾��qwl~��y�p�@��;+Oh����|4��� "�����Hx�<B�cF̬C  "t$ �n�D����18�� ''�M8� %Ue���|M.�ă����#� �j��t���Z;8��� O���)@E��@	������L�i����}s �n� Iow�H:x��R�F�1� ��R��`�ჿ�v�8���^:P�r�	t�r�	t��TXy��*�XQê�-��"�ibbР���VE|�UZ�1�.H�� �jmf�+�s�Bҫ����ΙɭSVJ�6rr���5����XՉ��U�F1V-lE���UDЪ�П�����,,�M�^�e*$��߫�L�D��z��j��%��ɐU1�V�":�ZP�*X4����E�V�����r��g��Y�\
�I�
��m���I�
��m��� H��Ԩ�(�� �͙j��������0�f*G)���bLBdCIf b��V������b��6��
H���8BR�����b�iݺ��0�Z��Z�UEQ�
((��b-:TU��Z�ZшV4Z�(
֊��Qc�4�>߬@4�Qu�"�*�):-�CUhEE+(*`Ac�Z�(CA�BP떨�XT�FE+�+Sb�|�Z'E�"ӪĀ(
�r�e���_Q�^E����]��I�x�� b��*Z�5X4�`t�����(h䨤�7C����
�h5V�(ت���(֪�E���p`kT�� bE�hT�X�b�V#�`8zd�
X ��� ��(U���&�w�g]\�+�~9G��PN����r�{#uKG��/ ^`�NH�X��JղӪ��;@��R��껇�P~   �7���""� �s�s�J��h��h�k�S9J���0��H�r%eT�`��V�ؘ�[{��  I$���\	
�#��3b� ��Z��P���a��PK��*��X+h�����:TUQ������XZ���k��XUT[UhT�*F'�-�V�Q��E��CEQ�"��4�V���ըVDUP�Xc�PU�X�`�L� �b�Q�r�χUw�ʺ�"�|�.�С��*��a�*FQ�:D��QE�U���h�E�hE��X�(���:�Z+:P,VAl4�� 3]4�UkUQ4���h�j-bQ�(�Z�V�k0գ��biKKU K��"
��5(U A�b��P TU��Щ�
��q{�4xU��>����V��QUՊ������$:���x��,��n����0ߵN4'�Xd���E@+PE�
���{k(����! ^[u~�i-���ڪ�#Mk����   ^e�	2#�9�r�0��T�R͹M�:rHE,� � ��B"� �AQ��#  !*!�� ,#ɑ! !i�(X �PSk�h+E����(�����Q�*+�ml�с�ZUP�U+:D+�U*Z�p��$�":U��bU��ZQШ������N�B>���X�"�@c���cq���'(��b������E��+��:�I����@E�*�5F�QDcUUAp.�BcE�mEQTUQTETU��yN����qˍNE4�X+ZU[,
ZA ���VT4�֢U�"ZUQDT� h �*��m��D@�Қ�CP��5�  �����C�U� ��TT,�Z,�7Eߩb�VE�˱�\T#���
DUYUT�3��H/����'��M0�쉶������0�JM,2�>.$B����"s���A"��   x��ST�����L5���Q�9������!�#b1h�-K�l�  #֪ �+%%�� ��4HF�r���$8| �Ҫ��a�6����*�5hPUQt*��Q"�u,U�4���"XW�*bX��!�(V�����U�"������U��UU�
jXGP[k�j���ض�(#��U�+XA,V�"� �j�F�բ��W��ZP�QEc�FAP� �.WEQQĂU����j��b� G�A��(�*E4b[A,FT��Q�h-(VQ���S���U���E��:���ҾK�#ET�X�C���F��:�"�֪*"� ��("bê5Q�Kł Z @ �: U+:T��h���O�L�(���?KZy���:������[��y��;��Ԣ���#4��}�FP@�Z����bt��*����½�$�b ^J�|�f�̬!��WJ�|�f�̬!����Y���� �(�,����ۜ�R9�s��NO5�9L��l�5TU��`����@U ��8\��L��������aaZE�VՈV�F4VE��h�*�b���6�XU��0U4�0Z�*VT,�hDt��a�bZ1�+*b]԰*�
�b�b�N-��Z�QQ4*hETQ5�����E Q�� �h��ElQ���-�[��ψcUQE�8%�|�H;ਪ�`U�AQED�b�,
DA5X�łb�X�`��**hT(V-VmkAЊN��""���j@TU�q֤^âՀ��"VPEUT��F���(�;uuM,mK5DD��U>#�Q�5t*���Ec���XU����!U@�"hQT�G=��M�T�~鮠�C0�(� Z���(
"[Ż"LH��BD�Z�1Jzۯ��vO·	.�A*�,��B@K��є�cDD�|��*M�=FDT��   �s�;}N��h�}�9�|w����!�1�@i�	�"   �yB���f9�#*!�$�c����0�aU5����*�-EmUQЩ+ ,-�V-�b*��F��V�@1��\����iZ�Z*��z���D[��QEE+��VQ��*V� ��@c���"�0�i�s��i�@��bU���#IEATk��"Z��Z@ŠQlA�"�F1���jEŢ��U�-��4����X5Sm@ADL�ZXA�����`lE���FPE�֊؂�hUQ��Vt
�шlEU+���Q�Zł
EA��*"j�lZK�4-�*Z�X�jD�C��@�5SAT��������b *���fai��ji�m�V=��EU�(
�4�-����/���_*��$rd�����>�'��C(T�ީ�� l,"� @>���	nX�K^����r���Xc �j���vד�W�7�0���4��   n k�m�T��T���T3�6988J�@,FQ� D� ���b�7���bcڈ��[�T5L `���(�r�(K@Y�����8�(��h�UD1���(�����`�QEQU-֩hUc�X�@TAM�`�h�X��b@��T��!���jT�b��� *�N��(�cѨh,
�jUQ��y��(*��5L��E1D�j���Dc�m�b�j���~QLRn�,ʗ�S~�vQp�� l�bc@�(� �N�(,�m���A�X�j�XT�"֜mF8������(h�1XA��.��  QU0����6��`���V��`,� ⦻$�����X
(`j�@�9���̋��A�K��j`�� ��"�I�l��2������?@P OggS  @n            �_���������������������:m������:m������   xSf�UȂĢe��9�Tsι;���T3U*G�Q*b�Hږ � ����X�5�"@��
���B�(+	FX��dXB)��uL�L��P���h�AA�Z��ab��TQ�����"����
XX3�jԴ�j�X��i]0�iU�Z�U�X���U�XU5���ZPD���UQ� 6��b�����VQU�(���6V� ��|u��z�jEѪ�(ZATP�FU-֢�Њ�`�(6��FDT[Q���(Zk�E#XcъV+�Ѣ�5-�Ě��& " ��@M��*KyYD�bT4��*�`�
"��htbщFQ��R�h�V��`A����ԈV�*ZE,�F0��N��q `�
Z����A�F�ت(q0�"(�NAk�����'�q+UD���X4��Z��   * 1⒨�T�E�XcU�DD+X�J�>�����4Er��I�ˆ
*��;�]�MC�w�������֩� �Șs�L5�L��h�r�9=�#�T�R�r#���Xk��F���ikUQ;[_HXRH�!�R�u�f�-M��*�a �b�Q-�X��: �h�jT������V�
"*b(�a�"�D+ 1�j�p�/twX�5C SS�Q�XT��� �� h�UEA���Z🜻��U�Xl�A,h@����*6�AUU0�QETE-������bA���XPŀF�Ś�j��n^�J��3e����hUE�h�XlA�*�V��UUEk[TcE,�Q8�("�.��k��UT@c1#�M�"���
�
֪�ZA1�	r_�4DEЊ jQ��x�gYA �hP�f{IAM�նU���!��j��[4�`��mDN)�y�`T�6V�M*�BP U��V��i�A��q ��f\3~�&An:w���=�F�I����B�rO?  Y���:E�}��9��L�0S�J����#&N��R�1	R�1�k#b�e�BRb�$%JVT�F�6�hiX3�Z�1-,Q�bV�KEL���"���(VE�*XQ5�bAALU�EQDTU��Q�����bZź�j���Q�VЂQu��jUDlQ��X4Fщ��*ZTDT[qֵS7�i��*�V�UQDU��V��â(*�ֈE��V�
��E���UŢ��Ȝ�|�ݗ��>'O��h�Xt(`�
��F��b-b1:T�ww9�CT���}WՁ�T0�FP��5���Q�A@�2;��N�Sa�r�;Ɉ,����e��@�Z���(�md��ʓ�O����!*ETŢExW���[D�"��?�B�m���5,9K��Q��VPl�bu,Z�{'%�t�p�����XЭ=�0�F;tk�G��L@  ���H`�3��眩�rpp v����t4��H��2 �Z�X��5  �<)CAa���$�%!*�@P�Z��Z��*�:m�(��XաU,U5b �0�B�X�b��U�+��VDTՊ���U[c��"�VUPU�V��V�D���-�t\�Q c�hD�*A4
"����T�01l�*j6V�,,MkT��QQUD����`��QD�Z"�UD�!���:��hDU�XՈ�"�h�ZQQUc����Н�"��M�w  :�
��h� ���F����]��z��5�q_]�J��KşZ�Z�)��Yz4�o	r_��NǢ?1������EQ@�Z04+Қ�޾p�%�x黚�+?cE��X4��
ZDT�*�����]eu�*
b��VDъX�Ft�Ƣ��5�j�;G��~�`���ѭ��֒v���뱜lO�r{K
^*D��2�JQ v �   �}�S�9�t4�s�@���Q*G3U*11&�� �  @D)WPX��
K�H��(�
s.@��16���*�5+֬��bźK�RL1հ�RK��U L[��ժ�QP�:DQ�N[�hQT�
j�V�T�Ԋ������K�*j�Q��F��@��j���E��V�*�h�(Zk,(� bl[���`[�*�ѡ �j��j�bQ5���PU�U���FE�B��.�X�Ec[�VA�E�"�5֊��
c�CDA1�`�AkD�bQ��EE���h,�Hvry/�nζ��O�e�5�"VE,yE��+��Ċ��';#���s�_��hT#b����DA�[ӑs��Ҋ�"��Q5�"b�j������V]W�h۠X�QAP5EՊ
�:E��Q0��R�W��bc�+v-v���?��M��|�� �t�	iD�J�~cjfJ�
��153�   ���6�sΙ�����ؑ�tp��@��$��" $  §|I)V���@��'R�JM�V���ula�iZ����Q�*�0miaX(�Z����@U�:A����wST��XA#�i*�jXWUD�E�j�VT��:�UT���A�jU��UkUQ�UQU4�
��
Et�E@�*#:E+�U����U���FlU���hm�V,�֪�X �N#VPD'� `4Z���*Fc�*Z�PQ�1���h-���*�  ��2�ZLԬ�w5zS�hՙC�c���!�&�LUZn���'Ŗŝ������ ��la0k�Y�+%B�P��CFc��4b�br!��t�Z�����*YTA��2�˵�A���������W�	�D0���{�a�P;i�n�sc�#���M}�a�   ���=��s��f�) ��!���t4S9�bP��� v�b������TD���!�4%`�񤄄�A�q�0�&�0�B1��V-0lT�A���R-Lk*�T-L�(�"�(
�5��X(j��j��U,,CE�aEEQt("��EQ@�V���ZP��h�4��hD��(: @��X�ZA��0�(�ѩQU��F��
EA�b���*U@DT��5��1Ԛb"(b����F�F�AkD1"����*��
��}�AŢAAE5�aEE��:��"XR�)��T���"���Y�{��"�������e�_U��V� ڎ�o���ZAĈE+������iNM^.&������_����ň`� Z���hEkp�W��Y�UVU���j���m֩� �VD �������>+}7�Z�A5�EŦ�>�EM)~jM���k\��;�&Xi��5.P��  xE�Jy&��s��t4��T�R9rppK�"@�K � *���E�5jD��j'���`c`b+��XM 8�#$ �c��|BE�	���Mba��ibM�R�
�5����0-�j՚UQ�(�UAQu�N�����-Z�F��U1SM�[E��h�����**j�6�b�U#:lUAՈ`��DAU�ւ ZD�hk+bE�(��U�/�]W�hlEEQE�آ*��U@��,�b-��UŊk�U�E�*�V��|uՂ(`����**(`1��q�z��=H�9�\^�Ɗ#�B�U�o��|�+�e���2�s�Z��=��9����--����jQV("X�p{���U�&9��``U��;r}h�n���2����Z��i/Ǜo�����:��{�h-`��"Bu�jU�����`�	���Z����2&�m�V��k��   �W� dZs����s�J�ؑ#G��R#	�� @��*VPA�S�SU�a 	q��9,�
�����sXBQU�R��hE�ba�T��iX��i�iͺ%bbUU�AUm[�)
X��(U4����
�ku��Q�FP���*�QTŶ��`�X@+��5�U#����ր*���PT�X�`g����E�bA��(ZDT��EQ�QD, Z+��jQ ��E5�bQ���NU�bT�"V@QQ���5��hU�hE � #�������#F�"��_$R`ŀ*���
M�8 ���"6 (����8k������؊�G��
F��+�����"Gp��v�Ot�n���"kɹJ��4ZAU@l�/�k�{<q�`'ȻY-P*D�Շ�ۇF @� >�14OggS  @�             `nJ�������������������>;�M������ΦQ�k��   ���	e�����N! �@�m�s:�s�99J�j:J50	B�E@� �"j�`�P"6��V;�V�+F����E0�5E�  � #�c�X|0�#"M�a�p_�"�F��h-bU�"����P���*h��>�{e�a�`�"*�
V�
���)�����ZX� V�jQ,:�*P�XQT4�bUkA�X������XT#`,��Q�kD����[Eը**:�RR�U�"�hPDkŢX�XA�U����UT�`EQPU��T0֩�*FcAQ������F#؈��P�ZA�"h��AD�"�E�ZA��bA��b� ��֢@�ƈ]��j7A�
��(њ!��
,��Qm,�"����iUe�+���B�E��X^�]/�ZDUA,`@A�E��L� ��@� ��E��X����� X�
�N��"�5ǈ��G2�
���"�j��1 �:i�# ��ӑVP>��   ��f���-O�9���L�ʑC*G��L�*E�4	 ��ikooZ��i�`a�B�����O*("*�'�!B0�Z�@M[XZ����ii�,Ŵ�)�����S'kѠVUS�[l�0,,L�@� Z�kUS�P�CM��T,�Ƣ�:��*������D5�):�� Z16�X1�`i`(��֬(��
�@�J����S@İC�Tc�F����:�X�P� :�UQ�4Z�Z��� b�"�V�XEQH)=�ˡŶmQAPŊ���`�"���Z�*Z�`AED�=b�qc���ZQ1�;���B���*V�h�IJ���T�PAPAQ�1"��|�vma�
�QD�bp��rC8�C��%EΪ���l#:�h��A�Q��
�"�"b4F� �):\
(@а�Zc� �AL����	�;��3^����0�eP���dQ����k�qc�D߶Ϲ��ȑ��(��#�;ݑ���X�T���H����F�F��4m���XT+�=��jU�"�a
v��&bQ��6����i V,h�1�PÚ5Q�´���X`aSDł���Ulk��X�֪[1�EЊ��թ*"�E-TT0��:���E�"�D�"�E[E1`@TѢ �E��"F���
�i]WGQѩ("��bPD|��K�6b��Q�QZ�tekTAPE�XTkU�1F�h1"�b���bYUъ���b���V@�
7��U2�M����r�X���U,L@� �b��i�}��P+��_�h@ �O$l�ʷ���o�,��G�+�6�t�����2���%(Z��Ǖ�bt��y�[#b��[�X`�rH>��
����>K=�8�5�Y��!��	`�   >���DR��Q��L���J5�|���-��`�t�(����#&��l� DD#D�1F���U�bD�b�aoc/�UŰQ�b�"���� �i�
 |A�
�K	 0�\Q��(�P�Ӱ�F,1L��	�4SDQT��*�ET��!�b�*��U[��C1�Ķ+�"��X�P["�(X,�E���1Uj�N�(�hD�_����E��PU�V�"ZĢh-X�("�"�-LDU�B�PU0T�ETP5�k�(�XC-L��i]PU1�X+bU��`U�a�����(�6�XX�TQT#:�T4FѠ[P1FTEc+6�����u5T����E=шET���h���ZA@+X��`�Z��橲aDTDĈu
~g�PѨ�U� 
QPA�(�(���|w�}Ѻ,��߁��-	"j��`]TPQ�n*�铖mAk˷�w�E@4 � �	 ~[ݺ�5E��A���u}k��݃"�   � @d�	�:��2g����js����T�R	8ZX,,�0���f1�M �	 ( k,V����ڊ؋i�
��a��X���	V0������b*b"�����2<1q1  aYA1qIBYK8\!
�S
�0�PB�b�
`���b�4L0EA�!|r�U�E��`�b ":#VU1bU�e.�6�������
 �F��T����,n[�ՔG^w�?܆k�(�4PCTlT0U+��ֱ`Ŋb�[t*�AĊ]C#ق�VT��q����h,h1b���XM:��آSDEU	��cQ��Tt�a���X�XU lE���EɽH��p(ɖQ�(%b�Q���
F�X0bAW��x��6G8�%B�A�"�F1��Ub%Ն'��.���Q0J Ġ [��(~�pc�[=�o� �   �Y5��!  .<	�"�t`�؄�9 3-�9�m�k.\XX���K%���A ��m@6"���U�FT@ Y�ZQ�bUP�Q����*��i��հP��"�`XM{�0+(*�U1[�(VSU@DS�m, .#)MT�(�i��| �JVH��P
*�r�b�P�PS�ѡQ@lE��Tl�"�-�*Fc,��D�[�[�����`���Qu�@+�X1b��b�:1":,�UT,��QD�jA+�"��V��P��ubU�V0b@ԴI1 #*1X�0��Ū�����"��bDF�U �Aъ��F�K�Ȧ��5�@c�X�4:,� (Z�����;�T�0 k�����ZW�[�  �P@TA�&��6�#p.pX���5�����c�+�A�:�������@�r$A>rXWx�C�̠ @�  0 ^k��i)h= �Z�5NKA���   >�d	�"@�J�"�ET�	pl�ja�	���9=���h�Z� jawp��0�$PK�h)3�b��jQ��Ĩ����"�&�1j�QQ��ٚ�"�
D� 5,
`Z����!���� ������! @!BY�ʀ.ߪ�MVU0��Z7TE@c�����SlQ +�����h�)ba��(6�V��V���b�) ����LKTUU��F�3֊�DD�*�`�աA "�X�M&b� �5 � �bӊ�	�u��d4*bthl��4P�� j���� �)�V���5 ��\�i���@,+b�z�Z۪��V#�A�j�(`MDD@��F0�� ��SO!�[�d+]�a�FCQ,�&�ʓ�c9�Yh\r�El[A�Z�"F0  OA@*���i7~�0 ^���y�N>F���̵�K����cT�����   � @���S�i��� ��� �
 �@	����j.X)-�4Xf�m�K`���1@���7�)��$��V���( �4 T�ZT�`Q�G  ��j�`�b�Tm�B@Q� �XC�Z��`�a( XUP[[ELSM;Q5��� �XP�����"& � (��ZP �4�0�  ���8�   �+)�#

 �  �	�f�b(�*�"ba��6`� Z�6� `M��FUE��"��"(���ZЊ(���*Vu`��ЊX�b@� ���D0`��Z�#*�ՀbET� ,�*�C5�`@�N��
�a����ΫC +���j��Q	�U[#"*FDc[U1�BeT�nȲ�v�F�сi� " ��"��Dŀ�2�`9q���
��  A@�Bd��E�A/�p � ^���qE�kd�� ��b�e\Q�� 9.H�   �?   �����^	�7 �����6G3U�99Z�pK� 6��0� �dЖZ�V  [P@���`P@-	 �bZU0���a���ESD-�������Ģ6�&X QL�� ��&,(�R  D�0��p)0��O�PP ,�!�,(�B����6���a�͂��( .�"�UD lQ1d�9�� AA�� (hKӊ�h� �CAk�$��h�D��"�AT Aъ� �b��U�. :V@�8X X�Ă����"��� 1��0t(6:��OBUE@46��;�4   �SD�,,0 ���Dȫ!U���8ѩ�E���FD�1A��)$׆; @��� �xp�M	(A� OggS  �         !   <�5Q�������j��ώ~�ޔ�z]��j��ώ~�ޔ�z]��   � @UPO=���	�Dd�� 0�7 � K �&D�_m0�� -������<F� XX�)pȉŕB, F-5��f#
 �� PQA1��Ŵ� ��ڨ�i� XD��k@1�(�
��&	 �0�bb*�" F����UUA[�Q�a��(
�)&��(
""&V�1D�ZcQc@AL�A  |iB\�  �����Cy�  �&�P�a	@��&�
֭�"��a]Ӫ � ja�U�RAŴQ���@AAm2 1�)�b�UC�0T��
�lV�n]9@[b��( �CUl���hU�6:5XPT�QQ*��uCADĴP�f� �X A�UA'�j� ��h@ +`�x?:��Xr��**�XXP4{�� �b�>>Z/O!D��� lk
**������Z>�ȣ`��5  #��*����2 !$A� � @�~����\E>�j3׬Yo��:����Xm��5�   � �P�[)�,����@~ 8$�خ \0�����)0.���9Ov��LDi[�l)T �, �
*�"���*��`k( ��b��" ��j�*b�i�"b��) �i5[�*��XTA ��4�`łi������ *b��  IF�  BK  �r	WT�  Dl�@ ��CA PP����VT���%��aQ��T� T0V��
��iM@��X���AЩ� ����5D,Q�5�D��&�3Z ��
 �`�!���SE��*b�0 ��" T�jЁ�����V ��XQ#- Z�AT5i�K �&�CJ �b*��������oV�����F�V5 " ��&Sw'b���N ��@`�� ^�����2YYn�s�W���XLde�o���NUd���E����.���N�N��N[0-|�����01�� �jEĈ
bogk��6ÊE���V���"���ak�)�Z[5-jk6bQ�P�15-jo�S�������T�4MC�!&�i�:�1��FEl� ֭�
(��i3V�b�
�`Z�  Z�#XQEUT����X�h����(`Z�ʧ�z芢���jlAU0���(Z��B���6XQQA��V�U��1bAT�*b�(�
��X�`�5]k������d����bX�fi|ؠ�V�V@ը�ATEUT�V �8��/� �5:uhwav'# X�h�M������Ukj�&KSc `EU +Z�ъ�n�\R7�\�՜Q:2QR%ç��:�F��UQ��N�/6��1�U  0bktj ��%�u���4�ւD~"d���	          RSRC     [remap]

importer="ogg_vorbis"
type="AudioStreamOGGVorbis"
path="res://.import/paint_it_bgm.ogg-2455281902dd547e251bb619a1bfa679.oggstr"

[params]

loop=true
  ECFG      application/config/name         Paint It   application/run/main_scene         res://World.tscn   application/config/icon         res://icon.png     autoload/Global         *res://Global.gd   display/window/size/width     �         display/window/size/height     �         display/window/stretch/mode         2d�   display/window/stretch/aspect      
   keep_width     gdnative/singletons             input/red_right               input/red_left               input/red_up               input/red_down               input/green_right             input/green_left             input/green_up             input/green_down             input/purple_right             input/purple_left             input/purple_up             input/purple_down          #   rendering/quality/2d/use_pixel_snap         )   rendering/environment/default_clear_color      �f3?��e? s?  �?)   rendering/environment/default_environment          res://default_env.tres   GDPC