package save;

import flixel.util.FlxSave;

class Save extends FlxSave
{
	public var savedata:SaveData;

	override public function new()
	{
		super();
		bind('dreamland', Application.current.meta.get('company'));
	}
}

typedef SaveData =
{
	var firstTime:Bool;
	var highscore:Int;
}