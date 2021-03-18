extends Area2D

var front=true
var direction=0
var travel_time=4
var dist=0
var max_dist=0
var avaliable=false
var show_timer=4
var catch=false
func _ready():
	
	if direction ==1:
		$AnimatedSprite.flip_h=true
		$AnimatedSprite.rotation_degrees=40
		$CollisionShape2D.position.x=-3
		$nextwave.flip_h=false
	else:
		$AnimatedSprite.flip_h=false
		$AnimatedSprite.rotation_degrees=-40
		$CollisionShape2D.position.x=3
		$nextwave.flip_h=true
	if front:
		self.position.y=248
		if direction==1:
			self.position.x=48
		else:
			self.position.x=464
		dist=464-48

	else:
		self.position.y=205
		if direction==1:
			self.position.x=85
		else:
			self.position.x=424
		dist=424-85
	max_dist=dist
	

func _physics_process(delta):
	self.scale.x=1.75-(get_node("../Border/Position2D").position.y-self.position.y+50)/100
	self.scale.y=1.75-(get_node("../Border/Position2D").position.y-self.position.y+50)/100
	if avaliable:
		if dist>0:
			self.position.x+=max_dist/travel_time*direction*delta
			dist-=max_dist/travel_time*delta
		else:
			queue_free()
	elif show_timer>0:
			show_timer-=delta
			$nextwave.visible=true
			$AnimatedSprite.visible=false
	elif catch:
		self.position.y+=10
	elif show_timer<=0:
			$nextwave.visible=false
			$AnimatedSprite.visible=true
			avaliable=true
			get_node("../../SoundManager/hand").playing=true



func _on_Hand_body_entered(body):
	
	if body.name=="Player":
		catch=true
		avaliable=false
		body.get_node("../CanvasLayer").life=0
		body.reason="fall"
		body.get_node("AnimatedSprite").animation="fall"
