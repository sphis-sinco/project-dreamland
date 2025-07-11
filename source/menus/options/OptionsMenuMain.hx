package menus.options;

import flixel.util.typeLimit.NextState;

class OptionsMenuMain extends FlxState
{
	public static var optionMenuNames:Array<String> = [];
	public static var optionMenuDestinations:Map<String, NextState> = [];

	public static function newOptionMenu(name:String, destination:NextState)
	{
		optionMenuNames.push(name);
		optionMenuDestinations.set(name, destination);
	}

	override public function new()
	{
		super();
		newOptionMenu('Controls Menu', () -> new ControlsMenu());
	}

	override function create()
	{
		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
