package;

import haxe.Json;

class Global
{
	public static var HIGHSCORE:Int = 0;
	public static var NEW_HIGHSCORE:Bool = false;
	public static function set_HIGHSCORE()
	{
		try
		{
			PlayState.SCORE = Json.parse(FileManager.readFile(FileManager.getAssetFile('highscore.json'))).highscore;
		}
		catch (e) {}
		NEW_HIGHSCORE = HIGHSCORE < PlayState.SCORE;
		HIGHSCORE = (NEW_HIGHSCORE) ? PlayState.SCORE : HIGHSCORE;
		FileManager.writeToPath('assets/highscore.json', '{"highscore":$HIGHSCORE}');
	}
}