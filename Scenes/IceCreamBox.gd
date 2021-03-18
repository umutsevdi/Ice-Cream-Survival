extends Area2D
var inside=0
signal on_changed(open)
var closed=false
var played=false


func _physics_process(delta):
	if inside and not closed:
		get_node("../../CanvasLayer").emit_signal("inside",delta)
	elif inside and closed:
		get_node("../../CanvasLayer").safe=false
	if closed and not played:
		if $AnimatedSprite.modulate.a>1:
			played=true
			$AnimatedSprite.position.y=0
		else:
			$AnimatedSprite.modulate.a+=delta*5
			$AnimatedSprite.position.y+=100*delta
	if closed==false and not played:
		if $AnimatedSprite.modulate.a>0:
			$AnimatedSprite.modulate.a-=delta*5
			$AnimatedSprite.position.y-=100*delta
		else:
			$AnimatedSprite.position.y=0
			played=true
	

func _on_IceCreamBox_body_entered(body):
	if body.name=="Player":
		inside+=1
func _on_IceCreamBox_body_exited(body):
	if body.name=="Player":
		inside-=1


func _on_IceCreamBox_on_changed(open):
	if open and closed:
		closed=false
		$AnimatedSprite.position.y=0
		$AnimatedSprite.modulate.a=1
		played=false
	elif open==false and not closed:
		closed=true
		$AnimatedSprite.position.y=-20
		$AnimatedSprite.modulate.a=0
		played=false
