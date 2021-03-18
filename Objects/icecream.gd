extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var distance=45

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	self.scale.x=1.75-(get_node("../Border/Position2D").position.y-self.position.y+50)/100
	self.scale.y=1.75-(get_node("../Border/Position2D").position.y-self.position.y+50)/100
	

	distance-=120*delta
	if distance>0:	self.position.y+=90*delta
	else: 	queue_free()
