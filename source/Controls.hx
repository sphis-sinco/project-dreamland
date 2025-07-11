import flixel.input.keyboard.FlxKey;

class Controls
{
	public static var gameplay_shoot_keybind:FlxKey = SPACE;

	public static var gameplay_move_up_keybind:FlxKey = UP;
	public static var gameplay_move_up_keybind_alt:FlxKey = W;

	public static var gameplay_move_down_keybind:FlxKey = DOWN;
	public static var gameplay_move_down_keybind_alt:FlxKey = S;

	static function keyTranslate(key:String):String
		return key.toLowerCase().replace('-', '_').replace(' ', '_').replace('_keybind', '');

	public static function setKey(key_id:String, newKey:FlxKey)
	{
		switch (keyTranslate(key_id))
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

	public static function getKey(key_id:String):String
	{
		switch (keyTranslate(key_id))
		{
			case 'gameplay_shoot':
				return gameplay_shoot_keybind.toString();

			case 'gameplay_move_down':
				return gameplay_move_down_keybind.toString();
			case 'gameplay_move_down_alt':
				return gameplay_move_down_keybind_alt.toString();

			case 'gameplay_move_up':
				return gameplay_move_up_keybind.toString();
			case 'gameplay_move_up_alt':
				return gameplay_move_up_keybind_alt.toString();
		}

		return 'Unknown';
	}

	public static var GAMEPLAY_SHOOT(get, never):Bool;

	static function get_GAMEPLAY_SHOOT():Bool
		return FlxG.keys.anyJustReleased([gameplay_shoot_keybind]);

	public static var GAMEPLAY_MOVE_UP(get, never):Bool;

	static function get_GAMEPLAY_MOVE_UP():Bool
		return FlxG.keys.anyPressed([gameplay_move_up_keybind, gameplay_move_up_keybind_alt]);

	public static var GAMEPLAY_MOVE_DOWN(get, never):Bool;

	static function get_GAMEPLAY_MOVE_DOWN():Bool
		return FlxG.keys.anyPressed([gameplay_move_down_keybind, gameplay_move_down_keybind_alt]);
}
