extends Spatial

export(PackedScene) var WEAPON

func is_on_screen():
	return $VisibilityNotifier.is_on_screen()
