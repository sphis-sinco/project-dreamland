package save;

import flixel.util.FlxSave;

class Save extends FlxSave
{
	public static var savedata:SaveData;

	public var SAVEDATA_VERSION:Int = 2;

	override public function new()
	{
		super();

		bind('dreamland', Application.current.meta.get('company'));
		if (this.data.savedata != null)
		{
			savedata = this.data.savedata;
			savedata.saveVer = SAVEDATA_VERSION;
			savedata.firstTime ??= true;
			savedata.highscore ??= 0;
		}
		else
		{
			trace('SAVEDATA IS NULL. SETTING TO A COMPLETELY NEW SAVE.');
			savedata = {
				saveVer: SAVEDATA_VERSION,
				firstTime: true,
				highscore: 0
			};
		}

		this.data.savedata = savedata;
		this.flush();
	}
}

typedef SaveData =
{
	var saveVer:Int;

	var firstTime:Bool;
	var highscore:Int;
}