package save;

class Save
{
	public static var save:FlxSave;

	public static final SAVEDATA_VERSION:Int = 5;

	public static function initalize()
	{
		save = new FlxSave();
		save.bind('dreamland', Application.current.meta.get('company'));

		if (save.data.savedata == null)
		{
			trace('SAVEDATA IS NULL. SETTING TO A COMPLETELY NEW SAVE.');
			save.data.savedata = {
				saveVer: SAVEDATA_VERSION,
				firstTime: true,
				highscore: 0
			};
		}
		else
		{
			save.data.savedata.saveVer ??= SAVEDATA_VERSION;
			save.data.savedata.firstTime ??= true;
			save.data.savedata.highscore ??= 0;
		}

		save.flush();
	}

	public static function getSavedataInfo(field:SaveKeys):Dynamic
	{
		var saveD:SaveData = save.data.savedata;

		switch (field)
		{
			case savever:
				return saveD.saveVer;
			case firsttime, firstTime:
				return saveD.firstTime;
			case highscores:
				return saveD.highscores;
			case legacyUser, legacyuser:
				return saveD.legacyUser;
			case legacyHighScore:
				return saveD.highscore;
		}

		return null;
	}

	public static function setSavedataInfo(field:SaveKeys, newval:Dynamic)
	{
		switch (field)
		{
			case savever:
				save.data.savedata.saveVer = newval;
			case firsttime, firstTime:
				save.data.savedata.firstTime = newval;
			case highscores:
				save.data.savedata.highscores = newval;
			case legacyUser, legacyuser:
				save.data.savedata.legacyUser = newval;
			case legacyHighScore:
				trace('Why are you trying to change an outdated save data field?');
		}
	}

	public static function flushData()
		save.flush();
}

typedef SaveData =
{
	var saveVer:Int;

	var firstTime:Bool;

	var highscore:Int;
	var highscores:Array<HighScoresArrayEntry>;

	var legacyUser:Bool;
}

typedef HighScoresArrayEntry =
{
	var level:String;
	var score:Int;
}

enum SaveKeys
{
	savever;

	firsttime;
	firstTime;

	legacyHighScore;
	highscores;

	legacyuser;
	legacyUser;
}
