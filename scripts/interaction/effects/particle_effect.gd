extends Effect

class_name  ParticleEffect

@export var particles : CPUParticles2D

func trigger():
	super()
	particles.restart()
