extends Node

func _ready():
	var mesh = get_parent().get_node_or_null("MeshInstance3D")
	if mesh:
		var mat = mesh.get_active_material(0)
		if mat and mat is ShaderMaterial:
			mat.set("shader_parameter/emission_strength", 2.5)
			mat.set("shader_parameter/emission_color", Color(1.0, 0.8, 0.5))
