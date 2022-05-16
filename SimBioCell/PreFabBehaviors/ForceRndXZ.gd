@tool
extends VisualScriptCustomNode

func _get_caption():
	return "ForceRndXZ"

func _get_category():
	return "SimCells"

# *****************************************************
# *   STEP    *
# *************
func _step(inputs, outputs, start_mode, working_mem):
	#print("Entering ForceRndXZ...")
	if inputs[0].is_in_group(inputs[1]):
		var intensity:float = randf()*inputs[2]
		var angle:float = randf()*6.28
		inputs[0].apply_central_impulse(Vector3(intensity*cos(angle),0,intensity*sin(angle)))
	return 0

# *****************************************************
# *  SEQUENCE  *
# **************
func _has_input_sequence_port():
	return true
func _get_output_sequence_port_count():
	return 1

# *****************************************************
# *  INPUT   *
# *************
func _get_input_value_port_count():
	return 3
func _get_input_value_port_name(idx):
	if idx == 0:
		return "Agent"
	elif idx == 1:
		return "Group"
	elif idx == 2:
		return "Intensity"
	return "default"
func _get_input_value_port_type(idx):
	if idx == 0:
		return TYPE_OBJECT
	elif idx == 1:
		return TYPE_STRING
	elif idx == 2:
		return TYPE_FLOAT
	return TYPE_OBJECT

# *****************************************************
# *  OUTPUT   *
# *************
func _get_output_value_port_count():
	return 1
func _get_output_value_port_name(idx):
	if idx == 0:
		return "pass"
	return "default"	
func _get_output_value_port_type(idx):
	if idx == 0:
		return TYPE_OBJECT
	return TYPE_OBJECT
