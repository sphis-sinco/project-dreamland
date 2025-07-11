import flixel.input.keyboard.FlxKey;

class Controls
{
	// GAMEPLAY \\
	public static var gameplay_shoot_keybind:FlxKey = SPACE;

	public static var gameplay_move_up_keybind:FlxKey = UP;
	public static var gameplay_move_up_keybind_alt:FlxKey = W;

	public static var gameplay_move_down_keybind:FlxKey = DOWN;
	public static var gameplay_move_down_keybind_alt:FlxKey = S;

	public static var GAMEPLAY_SHOOT(get, never):Bool;

	static function get_GAMEPLAY_SHOOT():Bool
		return FlxG.keys.anyJustReleased([gameplay_shoot_keybind]);

	public static var GAMEPLAY_MOVE_UP(get, never):Bool;

	static function get_GAMEPLAY_MOVE_UP():Bool
		return FlxG.keys.anyPressed([gameplay_move_up_keybind, gameplay_move_up_keybind_alt]);

	public static var GAMEPLAY_MOVE_DOWN(get, never):Bool;

	static function get_GAMEPLAY_MOVE_DOWN():Bool
		return FlxG.keys.anyPressed([gameplay_move_down_keybind, gameplay_move_down_keybind_alt]);

	// UI \\
	public static var ui_move_left_keybind:FlxKey = LEFT;
	public static var ui_move_left_keybind_alt:FlxKey = A;

	public static var ui_move_right_keybind:FlxKey = RIGHT;
	public static var ui_move_right_keybind_alt:FlxKey = D;

	public static var ui_move_up_keybind:FlxKey = UP;
	public static var ui_move_up_keybind_alt:FlxKey = W;

	public static var ui_move_down_keybind:FlxKey = DOWN;
	public static var ui_move_down_keybind_alt:FlxKey = S;

	public static var ui_select_keybind:FlxKey = ENTER;
	public static var ui_leave_keybind:FlxKey = ESCAPE;

	public static var UI_MOVE_LEFT(get, never):Bool;

	static function get_UI_MOVE_LEFT():Bool
		return FlxG.keys.anyJustReleased([ui_move_left_keybind, ui_move_left_keybind_alt]);

	public static var UI_MOVE_RIGHT(get, never):Bool;

	static function get_UI_MOVE_RIGHT():Bool
		return FlxG.keys.anyJustReleased([ui_move_right_keybind, ui_move_right_keybind_alt]);

	public static var UI_MOVE_UP(get, never):Bool;

	static function get_UI_MOVE_UP():Bool
		return FlxG.keys.anyJustReleased([ui_move_up_keybind, ui_move_up_keybind_alt]);

	public static var UI_MOVE_DOWN(get, never):Bool;

	static function get_UI_MOVE_DOWN():Bool
		return FlxG.keys.anyJustReleased([ui_move_down_keybind, ui_move_down_keybind_alt]);

	public static var UI_SELECT(get, never):Bool;

	static function get_UI_SELECT():Bool
		return FlxG.keys.anyJustReleased([ui_select_keybind]);

	public static var UI_LEAVE(get, never):Bool;

	static function get_UI_LEAVE():Bool
		return FlxG.keys.anyJustReleased([ui_leave_keybind]);

	// FUNCTIONS \\

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

			case 'ui_move_left':
				ui_move_left_keybind = newKey;
			case 'ui_move_left_alt':
				ui_move_left_keybind_alt = newKey;

			case 'ui_move_right':
				ui_move_right_keybind = newKey;
			case 'ui_move_right_alt':
				ui_move_right_keybind_alt = newKey;

			case 'ui_move_down':
				ui_move_down_keybind = newKey;
			case 'ui_move_down_alt':
				ui_move_down_keybind_alt = newKey;

			case 'ui_move_up':
				ui_move_up_keybind = newKey;
			case 'ui_move_up_alt':
				ui_move_up_keybind_alt = newKey;

			case 'ui_select':
				ui_select_keybind = newKey;
			case 'ui_leave':
				ui_leave_keybind = newKey;
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

			case 'ui_move_down':
				return ui_move_down_keybind.toString();
			case 'ui_move_down_alt':
				return ui_move_down_keybind_alt.toString();

			case 'ui_move_up':
				return ui_move_up_keybind.toString();
			case 'ui_move_up_alt':
				return ui_move_up_keybind_alt.toString();

			case 'ui_move_left':
				return ui_move_left_keybind.toString();
			case 'ui_move_left_alt':
				return ui_move_left_keybind_alt.toString();

			case 'ui_move_right':
				return ui_move_right_keybind.toString();
			case 'ui_move_right_alt':
				return ui_move_right_keybind_alt.toString();

			case 'ui_select':
				return ui_select_keybind.toString();
			case 'ui_leave':
				return ui_leave_keybind.toString();
		}

		return 'Unknown';
	}
}
