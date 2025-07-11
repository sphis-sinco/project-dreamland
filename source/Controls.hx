import flixel.input.keyboard.FlxKey;

class Controls
{
	static var gameplay_shoot_keybind:FlxKey = SPACE;

	static var gameplay_move_up_keybind:FlxKey = UP;
	static var gameplay_move_up_keybind_alt:FlxKey = W;

	static var gameplay_move_down_keybind:FlxKey = DOWN;
	static var gameplay_move_down_keybind_alt:FlxKey = S;

	public static function setKey(key_id:String, newKey:FlxKey)
	{
		switch (key_id.toLowerCase().replace('-', '_').replace(' ', '_').replace('_keybind', ''))
		{
			case 'gameplay_shoot':
				gameplay_shoot_keybind = newKey;

			case 'gameplay_move_down':
				gameplay_move_down_keybind = newKey;
			case 'gameplay_move_down_alt':
				gameplay_move_down_keybind_alt = newKey;

			case 'gameplay_move_up':
				gameplay_move_up_keybind = newKey;
			case 'gameplay_move_up_alt':
				gameplay_move_up_keybind_alt = newKey;
		}
	}

	public static var GAMEPLAY_SHOOT(get, never):Bool;

	static function get_GAMEPLAY_SHOOT():Bool
		return FlxG.keys.anyJustReleased([gameplay_shoot_keybind]);

	public static var GAMEPLAY_MOVE_UP(get, never):Bool;

	static function get_GAMEPLAY_MOVE_UP():Bool
		return FlxG.keys.anyJustReleased([gameplay_move_up_keybind, gameplay_move_up_keybind_alt]);

	public static var GAMEPLAY_MOVE_DOWN(get, never):Bool;

	static function get_GAMEPLAY_MOVE_DOWN():Bool
		return FlxG.keys.anyJustReleased([gameplay_move_down_keybind, gameplay_move_down_keybind_alt]);
}
