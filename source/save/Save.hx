package save;

import flixel.util.FlxSave;

class Save extends FlxSave
{
	public var savedata:SaveData;

	override public function new()
	{
		super();

		bind('dreamland', Application.current.meta.get('company'));
		if (this.data.savedata != null)
		{
			savedata = this.data.savedata;
		}
		else
		{
			trace('SAVEDATA IS NULL. SETTING TO A COMPLETELY NEW SAVE.');
			savedata = {
				firstTime: true,
				highscore: 0
			};
			this.data.savedata = savedata;
		}

		this.flush();
	}
}

typedef SaveData =
{
	var firstTime:Bool;
	var highscore:Int;
}