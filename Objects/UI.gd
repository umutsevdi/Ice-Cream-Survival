extends CanvasLayer
signal inside(delta)
var hand= preload("res://Objects/Hand.tscn")
var timer=0
var life=100
var closenum=0
var counter = 0
var period=4
var tick
var randomnum=[0,0,0,0,0,0,0,0]
var tmp=0
var hardness=0
var warning_timer=0

var safe=0

var handwaiter=0
func _ready():
	get_node("EndGameScreen").modulate.a=0
	$EndGameScreen/Score.visible_characters=0
	get_node("EndGameScreen").visible=false
	tick=period
	for i in get_node("../Boxes").get_children():
		i.emit_signal("on_changed",true)
	closenum=hardness+1

func _physics_process(delta):
	safe = 0
	for i in get_node("../Boxes").get_children():
		if i.inside and not i.closed:	safe+=1
	if life>0:
		if life<=50 and safe==0:
			warning_timer+=delta
			if warning_timer>(life)/100+0.1:
				warning_timer=0
				get_node("../../SoundManager/warning").playing=true
		life-=delta*8
		if life>100:
			life=100
		timer+=delta
		if handwaiter>0:	handwaiter-=delta
		if timer>tick:
			counter+=1
			tick=timer+period
			if period>(2.5-0.5*hardness):
				period-=0.25+0.25*hardness
			if counter>2:
				if handwaiter<=0:
					var h = hand.instance()
					randomize()
					tmp=randi()%4
					if tmp==0:
						h.direction=1
						h.front=true
					elif tmp==1:
						h.direction=-1
						h.front=true
					elif tmp==2:
						h.direction=1
						h.front=false
					else:
						h.direction=-1
						h.front=true
					h.travel_time=4+2*(2-hardness)+2.5*period
					handwaiter=4+2*(2-hardness)+2.5*period+4
					get_node("..").add_child(h)
				if closenum<6:
					closenum+=1
					get_node("../../SoundManager/board_new_added").playing=true
				else:
					get_node("../../SoundManager/board_changed").playing=true
				counter=0
				
			else:
				get_node("../../SoundManager/board_changed").playing=true
			print("tick=",tick,"/",period,"/",counter,"/",closenum)
			for i in range(8):
				randomnum[i]=0
			for i in range(closenum):
				randomize()
				tmp = randi()%8
				while(randomnum[tmp]==1):
					tmp = randi()%8
				randomnum[tmp]=1
			print(randomnum)	
			for i in get_node("../Boxes").get_children():
				if randomnum[(int(i.name.right(3)))-1]==1:
					i.emit_signal("on_changed",false)
				else:
					i.emit_signal("on_changed",true)
						
			
			
		$TextureRect/Label.text=str(float(int(timer*100))/100)
		$TextureProgress.value=life
		$TextureProgress.tint_progress.r=(157*(100-life)/100+76)/256
		$TextureProgress.tint_progress.g=(254*(life)/100)/256
		$TextureProgress.tint_progress.b=(250*(life)/100)/256
	elif get_node("../Player").avaliable:
		get_node("../Player").avaliable=false
		if get_node("../Player").reason=="fall":
			get_node("../../SoundManager/fall").playing=true
			get_node("../Player/AnimatedSprite").animation="fall"
		else:
			get_node("../Player").reason="melt"
			get_node("../Player/AnimatedSprite").animation="melt"
			get_node("../../SoundManager/melt").playing=true
		get_node("EndGameScreen").visible=true
		if hardness==1:
			get_node("EndGameScreen/Score").text="YOU SURVIVED AT EASY MODE\n FOR "+str(float(int(timer*100))/100)+" SECONDS!"
		elif hardness==2:
			get_node("EndGameScreen/Score").text="YOU SURVIVED AT HARD MODE\n FOR "+str(float(int(timer*100))/100)+" SECONDS!"
		
	else:	
		if get_node("EndGameScreen").modulate.a<1:
			get_node("EndGameScreen").modulate.a+=delta
		elif $EndGameScreen/Score.visible_characters<100:
			$EndGameScreen/Score.visible_characters+=1


func _on_CanvasLayer_inside(delta):
	if life<100:	life+=12*delta


func _on_ReplayButton_pressed():
	get_node("../../Menu").visible=true
	get_node("../../Menu/VBoxContainer/PlayButton").emit_signal("pressed")
	get_node("..").queue_free()


func _on_MainMenu_pressed():
	get_node("../../Menu").visible=true
	get_node("..").queue_free()
