package;

import lime.system.System;

class Global
{
	public static var HIGHSCORE:Int = 0;
	public static var NEW_HIGHSCORE:Bool = false;

	public static function set_HIGHSCORE()
	{
		var savedHighscore:Int = Save.getSavedataInfo(SaveKeys.highscore);
		var currentScore:Int = PlayState.SCORE;

		var newHighscore:Int = 0; // vsc was bitching
		newHighscore = Std.int(Math.max(savedHighscore, currentScore));

		NEW_HIGHSCORE = newHighscore > HIGHSCORE;
		HIGHSCORE = newHighscore;

		Save.setSavedataInfo(SaveKeys.highscore, HIGHSCORE);
		Save.flushData();

		trace("Highscore updated to: " + HIGHSCORE);
	}

	public static var APP_VERSION(get, never):String;

	static function get_APP_VERSION():String
	{
		return Application.current.meta.get('version');
	}

	public static function playSound(soundname:String)
	{
		FlxG.sound.play(FileManager.getSoundFile('sounds/$soundname'));
	}

	public static var CurrentState(get, never):String;

	static function get_CurrentState():String
	{
		return Type.getClassName(Type.getClass(FlxG.state)).split(".").pop();
	}

	public static var CurrentSubState(get, never):String;

	static function get_CurrentSubState():String
	{
		return Type.getClassName(Type.getClass(FlxG.state.subState)).split(".").pop();
	}

	public static function goToUrl(url:String)
	{
		System.openURL(url);
	}
}
