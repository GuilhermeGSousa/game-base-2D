class_name  ParticleEffect extends EmptyEffect

@export var particles_path : NodePath

func trigger(node : Node):
	super(node)
	var particles = node.get_node(particles_path)
	
	if particles == null or not particles is CPUParticles2D:
		return
	
	particles.restart()
