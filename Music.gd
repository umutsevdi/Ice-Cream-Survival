extends Node2D

signal status(playing)
var timer=0
# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("status",true)

func _physics_process(delta):
	if $Sound1.playing and timer <17.44:
		timer+=delta
	elif $Sound1.playing:
		$Sound1.playing=false
		
func _on_Sound1_finished():
	$Sound2.playing=true
	print("Music 2 has started.")


func _on_Sound2_finished():
	$Sound2.playing=false
	$Sound2.playing=true
	print("Music 2 is on loop.")





func _on_Music_status(playing):
	if playing:
		$Sound2.playing=false
		$Sound1.playing=true
		print("Music 1 has started.")
	else:
		$Sound1.playing=false
		$Sound2.playing=false
		print("Music has stopped.")


func _on_MusicButton_toggled(button_pressed):
	get_node("../../../SoundManager/select").playing=true
	if button_pressed:
		$Sound1.stream_paused=true
		$Sound2.stream_paused=true
	else:
		$Sound1.stream_paused=false
		$Sound2.stream_paused=false
