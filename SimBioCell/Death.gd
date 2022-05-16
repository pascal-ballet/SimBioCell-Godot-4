@tool
extends VisualScriptCustomNode

func _get_caption():
	return "Death"

func _get_category():
	return "SimCells"

# *************
# *   STEP    *
# *************
func _step(inputs, outputs, start_mode, working_mem):
	print("Entering DEATH...")
	var made:bool = false
	if inputs[0].is_in_group(inputs[1]):
		var proba:float = inputs[2]
		if randf_range(0,100) < proba:
			print("DEAD")
			inputs[0].queue_free()
			made = true
	outputs[0] = made # in the box, return true if the death has been made, else it returns false
	return 0

# **************
# *  SEQUENCE  *
# **************
func _has_input_sequence_port():
	return true
func _get_output_sequence_port_count():
	return 1

# ************
# *  INPUT   *
# ************
func _get_input_value_port_count():
	return 3
func _get_input_value_port_name(idx):
	if idx == 0:
		return "Agent"
	elif idx == 1:
		return "Group"
	elif idx == 2:
		return "Proba %"
	return "default"
func _get_input_value_port_type(idx):
	if idx == 0:
		return TYPE_OBJECT
	elif idx == 1:
		return TYPE_STRING
	elif idx == 2:
		return TYPE_FLOAT
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
