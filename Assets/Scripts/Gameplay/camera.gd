extends Camera2D

@onready var screen_size: Vector2= get_viewport_rect().size
var player_node: CharacterBody2D = null

var x_restricted: bool = false
var x_marker1:Marker2D = null
var x_marker2:Marker2D = null
var y_restricted: bool = true
var y_marker1:Marker2D = null
var y_marker2:Marker2D = null

func _init() -> void:
	EventBus.transition_camera_x_unrestricted.connect(_on_transition_camera_x_unrestricted)
	EventBus.transition_camera_x_restricted.connect(_on_transition_camera_x_restricted)
	EventBus.transition_camera_y_unrestricted.connect(_on_transition_camera_y_unrestricted)
	EventBus.transition_camera_y_restricted.connect(_on_transition_camera_y_restricted)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_screen_position()
	await get_tree().process_frame
	position_smoothing_enabled = true
	position_smoothing_speed = 7.0
	zoom=Vector2(2,2)
	screen_size.x=screen_size.x/2
	screen_size.y=screen_size.y/2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#Voir a quoi ca sert. Il l'explique dans la vidéo mais je ne suis pas sur d'avoir tout bien compris
	set_screen_position()

func set_screen_position():
	var player_pos= player_node.global_position
	var x
	var y
	if x_marker1==null:
		x = player_pos.x
	else:
		if !x_restricted:
			x = clamp(player_pos.x, x_marker1.global_position.x, x_marker2.global_position.x)
		else:
			x = x_marker1.global_position.x
	if y_marker1==null:
		y = player_pos.y
	else:
		if !y_restricted:
			y = clamp(floor(player_pos.y / screen_size.y) * screen_size.y + screen_size.y/2, y_marker1.global_position.y, y_marker2.global_position.y)
		else:
			y = y_marker1.global_position.y
	global_position = Vector2(x,y)

func _on_transition_camera_x_unrestricted(x_marker_1:Marker2D, x_marker_2:Marker2D):
	x_restricted=false
	self.x_marker1=x_marker_1
	self.x_marker2=x_marker_2
	#print("Test Becomes Unrestricted: x_restricted = "+str(x_restricted)+", marker1 ="+str(self.x_marker1)+", x_marker2 = "+str(self.x_marker2))

func _on_transition_camera_x_restricted(x_marker:Marker2D):
	x_restricted=true
	self.x_marker1=x_marker
	self.x_marker2=null
	#print("Test: Becomes Restricted: x_restricted = "+str(x_restricted)+", x_marker1 ="+str(self.x_marker1)+", x_marker2 = "+str(self.x_marker2))

func _on_transition_camera_y_unrestricted(y_marker_1:Marker2D, y_marker_2:Marker2D): #Pas fini
	y_restricted=false
	self.y_marker1=y_marker_1
	self.y_marker2=y_marker_2
	#print("Test Becomes Unrestricted: y_restricted = "+str(y_restricted)+", y_marker1 ="+str(self.y_marker1)+", y_marker2 = "+str(self.y_marker2))

func _on_transition_camera_y_restricted(y_marker:Marker2D):
	y_restricted=true
	self.y_marker1=y_marker
	self.y_marker2=null
	#print("Test: Becomes Restricted: y_restricted = "+str(y_restricted)+", y_marker1 = "+str(self.y_marker1)+", y_marker2 = "+str(self.y_marker2))

func set_megaman(player_instance : SuperMainCharacter):
	player_node=player_instance
