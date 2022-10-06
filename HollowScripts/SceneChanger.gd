#================ Código de Game Endeavor ================
# - https://www.youtube.com/watch?v=_4_DVbZwmYc -
extends CanvasLayer


signal SceneChanged()

onready var MyAnimationPlayer = $AnimationPlayer

func ChangeScene(ScenePath, ChangeDelay = 0.1):
	yield(get_tree().create_timer(ChangeDelay), "timeout")
	MyAnimationPlayer.play("SceneTransition")
	yield(MyAnimationPlayer, "animation_finished")
	assert(get_tree().change_scene(ScenePath) == OK)
	MyAnimationPlayer.play_backwards("SceneTransition")
	yield(MyAnimationPlayer, "animation_finished")
	emit_signal("SceneChanged")

func PlaySceneTransitionAnimation():
	MyAnimationPlayer.play("SceneTransition")
