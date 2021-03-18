extends Node2D
var game=preload("res://Scenes/Root.tscn")
var hardness = 2
var music=true
var tips=true
func _ready():
	$CanvasLayer/HowToPlay.visible=true
	$CanvasLayer/HowToPlay.modulate.a=0


func _physics_process(delta):
	if $CanvasLayer/HowToPlay.visible and $CanvasLayer/HowToPlay.modulate.a<1:
		$CanvasLayer/HowToPlay.modulate.a+=2*delta
	if $Menu/VBoxContainer/PlayButton/Label.visible_characters<40:
		$Menu/VBoxContainer/PlayButton/Label.visible_characters+=1
	if $Menu/VBoxContainer/HowToButton/Label.visible_characters<40:
		$Menu/VBoxContainer/HowToButton/Label.visible_characters+=1


func _on_PlayButton_pressed():
	$Menu/VBoxContainer/HowToButton/Label.visible_characters=0
	$Menu/VBoxContainer/PlayButton/Label.visible_characters=0
	$SoundManager/select.playing=true
	if $Menu/VBoxContainer/PlayButton/Label.text=="PLAY":
		$Menu/VBoxContainer/PlayButton/Label.text="EASY"
		$Menu/VBoxContainer/HowToButton/Label.text="HARD"
	elif $Menu/VBoxContainer/PlayButton/Label.text=="EASY":
		$Menu/VBoxContainer/PlayButton/Label.text="PLAY"
		$Menu/VBoxContainer/HowToButton/Label.text="SETTINGS"
		var x = game.instance()
		x.get_node("CanvasLayer").hardness=1
		$Menu.visible=false
		add_child(x)
		print(x.get_node("CanvasLayer").hardness)
		$CanvasLayer/HowToPlay.visible=false
		$Menu/VBoxContainer/PlayButton/Label.text="PLAY"
		$Menu/VBoxContainer/HowToButton/Label.text="SETTINGS"
	elif music:
		$CanvasLayer/MusicButton.emit_signal("toggled",music)
		music=false
		$Menu/VBoxContainer/PlayButton/Label.text="PLAY"
		$Menu/VBoxContainer/HowToButton/Label.text="SETTINGS"
	else:
		$CanvasLayer/MusicButton.emit_signal("toggled",music)
		music=true
		$Menu/VBoxContainer/PlayButton/Label.text="PLAY"
		$Menu/VBoxContainer/HowToButton/Label.text="SETTINGS"

func _on_HowToButton_pressed():
	$Menu/VBoxContainer/HowToButton/Label.visible_characters=0
	$Menu/VBoxContainer/PlayButton/Label.visible_characters=0
	if $Menu/VBoxContainer/HowToButton/Label.text=="SETTINGS":
		if music:
			$Menu/VBoxContainer/PlayButton/Label.text="MUSIC OFF"
		else:
			$Menu/VBoxContainer/PlayButton/Label.text="MUSIC ON"
		if tips:
			$Menu/VBoxContainer/HowToButton/Label.text="HIDE TIPS"
		else:
			$Menu/VBoxContainer/HowToButton/Label.text="SHOW TIPS"
	elif $Menu/VBoxContainer/HowToButton/Label.text=="HARD":
		var x = game.instance()
		x.get_node("CanvasLayer").hardness=2
		$Menu.visible=false
		add_child(x)
		print(x.get_node("CanvasLayer").hardness)
		$CanvasLayer/HowToPlay.visible=false
		$Menu/VBoxContainer/PlayButton/Label.text="PLAY"
		$Menu/VBoxContainer/HowToButton/Label.text="SETTINGS"
	elif $Menu/VBoxContainer/HowToButton/Label.text=="SHOW TIPS":
		tips=true
		$CanvasLayer/HowToPlay.visible=true
		$CanvasLayer/HowToPlay.modulate.a=0
		$Menu/VBoxContainer/PlayButton/Label.text="PLAY"
		$Menu/VBoxContainer/HowToButton/Label.text="SETTINGS"
	elif $Menu/VBoxContainer/HowToButton/Label.text=="HIDE TIPS":
		
		$CanvasLayer/HowToPlay.visible=false
		tips=false

		$Menu/VBoxContainer/PlayButton/Label.text="PLAY"
		$Menu/VBoxContainer/HowToButton/Label.text="SETTINGS"
	$SoundManager/select.playing=true	




