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
	var bodies = inputs[0].get_colliding_bodies()
	if inputs[0].is_in_group(inputs[2]):
		for b in bodies:
			if b.is_in_group(inputs[1]):
				print("TRANSFORMATION")
				var newCell
				if inputs[2] == "virus" :
					newCell = load("res://testVIsualScriptScene/Virus.tscn").instance()
				elif inputs[2] == "bloodCell" :
					newCell = load("res://testVIsualScriptScene/BloodCell.tscn").instance()
				elif inputs[2] == "anti" :
					newCell = load("res://testVIsualScriptScene/Anticorps.tscn").instance()
				b.queue_free()
				b.get_parent().add_child(newCell)
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
	return 3
func _get_input_value_port_name(idx):
	if idx == 0:
		return "Agent"
	elif idx == 1:
		return "transformé"
	elif idx == 2:
		return "transformeur"
	return "default"
func _get_input_value_port_type(idx):
	if idx == 0:
		return RigidDynamicBody3D
	elif idx == 1:
		return TYPE_STRING
	elif idx == 2:
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
