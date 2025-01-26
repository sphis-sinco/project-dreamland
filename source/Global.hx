package;

import flixel.FlxG;
import haxe.Json;

class Global
{
	public static var HIGHSCORE:Int = 0;
	public static var NEW_HIGHSCORE:Bool = false;
	public static function set_HIGHSCORE()
	{

		NEW_HIGHSCORE = HIGHSCORE < PlayState.SCORE;
		HIGHSCORE = (NEW_HIGHSCORE) ? PlayState.SCORE : (HIGHSCORE < FlxG.save.data.highscore) ? FlxG.save.data.highscore : HIGHSCORE;
		FlxG.save.data.highscore = HIGHSCORE;
	}
}