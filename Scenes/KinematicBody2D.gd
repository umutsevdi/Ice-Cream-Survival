extends KinematicBody2D
var ice_drop=preload("res://Objects/icecream_drop.tscn")
var drop_amount=0
var drop_current=0
const SPEED= 80
var speed_buffer=0
var distance=0
var vector=Vector2.ZERO
var old_position=Vector2.ZERO
var timer=0
var avaliable=true
var reason="melt"
func _ready():
	old_position=self.position

func _physics_process(delta):
	if avaliable:
		if timer>0.5:
			drop_current=0
			timer=0
		else:	timer+=delta
		if drop_current<drop_amount/2:
			drop_current+=1
			var i=ice_drop.instance()
			i.position=$Position2D.global_position
			i.position.x=randi()%15-7+i.position.x
			randomize()
			i.position.y=randi()%15-7+i.position.y
			get_parent().add_child(i)
		distance=self.position.distance_to(get_global_mouse_position())
		
		if distance>150:	distance=150
		elif distance<5:	distance=0
		speed_buffer=SPEED*distance/300
		vector=self.position.direction_to(get_global_mouse_position())
		vector.y*=0.8
		if distance>0:
			old_position=self.position	
			move_and_slide(vector*(SPEED+speed_buffer))
			if old_position!=self.position:
				$AnimatedSprite.animation="run"	
		else:
			$AnimatedSprite.animation="idle"
		
		if (self.position-get_global_mouse_position()).x>=0:
			$AnimatedSprite.flip_h=true
			$Position2D.position.x=8
		else:
			$AnimatedSprite.flip_h=false
			$Position2D.position.x=-8
		drop_amount=int((100-get_node("../CanvasLayer").life)/3+1)
	
		self.scale.x=1.75-(get_node("../Border/Position2D").position.y-self.position.y+50)/100
		self.scale.y=1.75-(get_node("../Border/Position2D").position.y-self.position.y+50)/100
	elif $AnimatedSprite.animation=="fall":
		self.position.y+=10
	


	


func _on_GameField_body_exited(body):
	if body.name=="Player":
		get_node("../CanvasLayer").life=0
		reason="fall"
		body.get_node("AnimatedSprite").animation="fall"
		
