package menus.options;

import base.TextSelecting;
import flixel.math.FlxPoint;

class PreferencesMenu extends TextSelecting
{
	public static var instance:PreferencesMenu = null;

	public var ids:Array<String> = [];

	public static var lastSelection:Int = 0;
	public static var previousCameraPosition:FlxPoint = null;

	override public function new()
	{
		customCamEnabled = true;

		super();

		CURRENT_SELECTION = lastSelection;

		instance = this;

		texts = [];

		newPref('shaders', 'Shaders', Save.getSavedataInfo(shaders));

		enterKey = function()
		{
			var valid = false;

			switch (ids[CURRENT_SELECTION].toLowerCase())
			{
				case 'shaders':
					valid = true;
					Save.setSavedataInfo(shaders, !Save.getSavedataInfo(shaders));
			}

			if (valid)
			{
				instance = null;
				FlxG.resetState();
			}
		}

		backKey = function()
		{
			instance = null;
			FlxG.switchState(OptionsMenuMain.new);
		}
	}

	public function newPref(id:String, name:String, value:Dynamic)
	{
		texts.push('$name : $value');
		ids.push(id);
	}

	override function controls()
	{
		super.controls();
		lastSelection = CURRENT_SELECTION;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		previousCameraPosition = customCam.getPosition();
	}

	override function create()
	{
		super.create();

		if (previousCameraPosition == null)
		{
			previousCameraPosition = new FlxPoint();
			previousCameraPosition.x = getCamPos(text_group.members[CURRENT_SELECTION]).x;
			previousCameraPosition.y = getCamPos(text_group.members[CURRENT_SELECTION]).y;
		}
		customCam.setPosition(previousCameraPosition.x, previousCameraPosition.y);
	}
}
