package;

class Global
{
	public static var HIGHSCORE:Int = 0;
	public static function set_HIGHSCORE()
	{
		HIGHSCORE = (HIGHSCORE < PlayState.SCORE) ? PlayState.SCORE : HIGHSCORE;
	}
}