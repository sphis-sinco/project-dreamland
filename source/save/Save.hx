package save;

class Save
{
	public static var save:FlxSave;

	public static final SAVEDATA_VERSION:Int = 4;

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
			case highscore:
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
			case highscore:
				save.data.savedata.highscore = newval;
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
}

enum SaveKeys
{
	savever;
	firsttime;
	firstTime;
	highscore;
}
