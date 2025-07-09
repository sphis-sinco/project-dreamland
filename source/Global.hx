package;

import save.Save.HighScoresArrayEntry;

class Global
{
	public static var HIGHSCORES:Array<HighScoresArrayEntry> = [];

	public static function addHighscoreEntry(level:String, score:Int)
	{
		HIGHSCORES = Save.getSavedataInfo(highscores);
		HIGHSCORES.push({
			level: level,
			score: score
		});

		Save.setSavedataInfo(highscores, HIGHSCORES);
	}

	public static function getHighScoreArray(level:String)
	{
		HIGHSCORES = Save.getSavedataInfo(highscores);
		if (HIGHSCORES == null)
			return null;

		for (entry in HIGHSCORES)
		{
			if (entry.level == level)
			{
				return entry;
			}
		}

		return null;
	}

	public static var APP_VERSION(get, never):String;

	static function get_APP_VERSION():String
	{
		return Application.current.meta.get('version');
	}
}
