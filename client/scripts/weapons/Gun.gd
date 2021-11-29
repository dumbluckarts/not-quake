extends Spatial

func is_on_screen():
	return $VisibilityNotifier.is_on_screen()
