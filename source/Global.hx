package;

import lime.system.System;

class Global
{
	public static var HIGHSCORE:Int = 0;
	public static var NEW_HIGHSCORE:Bool = false;

	public static function set_HIGHSCORE()
	{
		NEW_HIGHSCORE = HIGHSCORE < PlayState.SCORE;
		HIGHSCORE = (NEW_HIGHSCORE) ? PlayState.SCORE : (HIGHSCORE < Save.getSavedataInfo(highscore)) ? Save.getSavedataInfo(highscore) : HIGHSCORE;
		Save.setSavedataInfo(highscore, HIGHSCORE);
		Save.flushData();
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

	public static function goToUrl(url:String)
	{
		System.openURL(url);
	}
}
