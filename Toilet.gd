extends ItemContainer

func hit():
	if not opened:
		$LidSprite.hide()
		var pos = $SpawnPositions.get_child(0).global_position
		open.emit(pos, current_direction)
		opened = true
