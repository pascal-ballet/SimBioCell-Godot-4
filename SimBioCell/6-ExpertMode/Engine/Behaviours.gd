extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for behav in get_children():
		for agt in get_parent().get_child(0).get_children(): #ou bien for agt in get_all_from_group("Virus"):
			behav.Start(agt) #on applique le comportement behav sur l'agent agt
