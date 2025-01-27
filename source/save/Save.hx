package save;

import flixel.util.FlxSave;

class Save
{
	public static var save:FlxSave;

	public static final SAVEDATA_VERSION:Int = 3;

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
	public static function getSavedataInfo(field:String):Dynamic
	{
		var targetField:String = field.toLowerCase();
		var saveD:SaveData = save.data.savedata;

		switch (targetField)
		{
			case 'savever':
				return saveD.saveVer;
			case 'firsttime':
				return saveD.firstTime;
			case 'highscore':
				return saveD.highscore;
		}

		return null;
	}

	public static function setSavedataInfo(field:String, newval:Dynamic)
	{
		var targetField:String = field.toLowerCase();

		switch (targetField)
		{
			case 'savever':
				save.data.savedata.saveVer = newval;
			case 'firsttime':
				save.data.savedata.firstTime = newval;
			case 'highscore':
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