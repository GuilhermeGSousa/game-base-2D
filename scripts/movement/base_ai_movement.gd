@tool
class_name TopDownFollowAI extends CharacterBody2D

@export_category("Movement")
@export var speed : float = 300
@export var knockback_time = 0.5
@export var knockback_speed = 1000.0

@export_category("AI Settings")
@export var follow_point : Node2D

@onready var _nav_agent : NavigationAgent2D = ScriptUtilities.find_child(self, "NavigationAgent2D")

var _avoidance_enabled : bool

var _kb_direction = Vector2.ZERO
var _kb_timer = 0.0

func _ready():
	if Engine.is_editor_hint():
		return

	_avoidance_enabled = _nav_agent.avoidance_enabled
	
	if _avoidance_enabled:
		_nav_agent.velocity_computed.connect(_on_velocity_computed)

func _process(delta):
	if _kb_timer > 0:
		_kb_timer -= delta

func _physics_process(delta):
	if Engine.is_editor_hint():
		return

	if not follow_point:
		return

	if _kb_timer > 0:
		velocity = knockback_speed * _kb_direction
		move_and_slide()
		return

	var dir = Vector2()
	var target_point = follow_point.global_position
	_nav_agent.target_position = target_point
	dir = _nav_agent.get_next_path_position() - global_position
	dir = dir.normalized()
	if not _avoidance_enabled:
		velocity = dir * speed
		move_and_slide()
	else:
		_nav_agent.velocity = dir * speed

func _get_configuration_warnings():
	var warnings : PackedStringArray = _get_configuration_warnings()
	
	# Check hand for mesh instance
	if not ScriptUtilities.find_child(self, "NavigationAgent2D"):
		warnings.append("Node does not have a NavigationAgent2D")
	
	return warnings

func _notification(what):
	if what == NOTIFICATION_EDITOR_POST_SAVE:
		update_configuration_warnings()

func _on_velocity_computed(vel : Vector2):	
	self.velocity = vel
	move_and_slide()
