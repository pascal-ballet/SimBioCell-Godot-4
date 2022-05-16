@tool
extends VisualScriptCustomNode

func _get_caption():
	return "Reaction"

func _get_category():
	return "SimCells"

# *************
# *   STEP    *
# *************
func _step(inputs, outputs, start_mode, working_mem):
	var made:bool = false
	var R1 = inputs[0]
	if R1.is_queued_for_deletion() == false and R1.is_in_group(inputs[1]):
		#print("R1 is in gp")
		var bodies = inputs[0].get_colliding_bodies()
		if bodies.size() > 0:
			#print("R1 is colliding")
			var R2 = bodies[0]
			if R2.is_queued_for_deletion() == false and R2.is_in_group(inputs[2]):
				#print("with another")
				if inputs[3] != "0" and inputs[3] != "R1": # si R1 n'est ni enlevé, ni prolongé, il est donc remplacé par P1
					var P1 = load(str("res://SimCells/PreFabAgents/",inputs[3],".tscn")).instance()
					R1.get_parent().add_child(P1)
				if inputs[4] != "0" and inputs[4] != "R2": # si R2 n'est ni enlevé, ni prolongé, il est donc remplacé par P2
					var P2 = load(str("res://SimCells/PreFabAgents/",inputs[4],".tscn")).instance()
					R1.get_parent().add_child(P2)

				if inputs[3] != "R1": # si R1 n'est pas prolongé, il est enlevé (càd soit enlevé soit remplacé)
					R1.queue_free()
				if inputs[4] != "R2": # si R2 n'est pas prolongé, il est enlevé (càd soit enlevé soit remplacé)
					R2.queue_free()

				made = true
	outputs[0] = made # in the box, return true if the reaction has been made, else it returns false
	return 0

# **************
# *  SEQUENCE  *
# **************
func _has_input_sequence_port():
	return true
func _get_output_sequence_port_count():
	return 1

# *************
# *  INPUT   *
# *************
func _get_input_value_port_count():
	return 5
func _get_input_value_port_name(idx):
	if idx == 0:
		return "Agent"
	elif idx == 1:
		return "Reactive Gp R1"
	elif idx == 2:
		return "Reactive Gp R2"
	elif idx == 3:
		return "Product PreFab/0/R1"
	elif idx == 4:
		return "Product PreFab/0/R2"
	return "default"
func _get_input_value_port_type(idx):
	if idx == 0:
		return RigidDynamicBody3D
	elif idx == 1:
		return TYPE_STRING
	elif idx == 2:
		return TYPE_STRING
	elif idx == 3:
		return TYPE_STRING
	elif idx == 4:
		return TYPE_STRING
	return TYPE_OBJECT
# *************
# *  OUTPUT   *
# *************
func _get_output_value_port_count():
	return 1
func _get_output_value_port_name(idx):
	if idx == 0:
		return "Made"
	return "default"	
func _get_output_value_port_type(idx):
	if idx == 0:
		return TYPE_BOOL
	return TYPE_OBJECT
