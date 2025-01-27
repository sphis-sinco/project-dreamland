package save;

import flixel.util.FlxSave;

class Save
{
	public static var save:FlxSave;

	public static final SAVEDATA_VERSION:Int = 3;

	public static function initalize()
	{
		save.bind('dreamland', Application.current.meta.get('company'));
		if (save.data.savedata == null)
		{
			save.data.savedata.saveVer = SAVEDATA_VERSION;
			save.data.savedata.firstTime ??= true;
			save.data.savedata.highscore ??= 0;
		}
		else
		{
			trace('SAVEDATA IS NULL. SETTING TO A COMPLETELY NEW SAVE.');
			save.data.savedata = {
				saveVer: SAVEDATA_VERSION,
				firstTime: true,
				highscore: 0
			};
		}

		save.flush();
	}
}

typedef SaveData =
{
	var saveVer:Int;

	var firstTime:Bool;
	var highscore:Int;
}