package;

class Global
{
	public static var HIGHSCORE:Int = 0;
	public static var NEW_HIGHSCORE:Bool = false;
	public static function set_HIGHSCORE()
	{
		NEW_HIGHSCORE = HIGHSCORE < PlayState.SCORE;
		HIGHSCORE = (NEW_HIGHSCORE) ? PlayState.SCORE : (HIGHSCORE < Save.savedata.highscore) ? Save.savedata.highscore : HIGHSCORE;
		Save.savedata.highscore = HIGHSCORE;
	}
	public static var APP_VERSION(get, never):String;

	static function get_APP_VERSION():String
	{
		return Application.current.meta.get('version');
	}
}