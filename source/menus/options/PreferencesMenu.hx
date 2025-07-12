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
		newPref('save-clear', 'Save clear', null);

		enterKey = function()
		{
			var valid = false;

			switch (ids[CURRENT_SELECTION].toLowerCase())
			{
				case 'shaders':
					valid = true;
					Save.setSavedataInfo(shaders, !Save.getSavedataInfo(shaders));
				case 'save-clear':
					valid = true;

					lastSelection = 0;
					previousCameraPosition = null;

					Global.NEW_HIGHSCORE = false;
					Global.HIGHSCORE = 0;
					PlayState.HIGHSCORE = false;
					PlayState.SCORE = 0;
					FlxG.save.erase();
					FlxG.save.bind('dreamland', Application.current.meta.get('company'));
					FlxG.resetGame();
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
		texts.push('$name${value != null ? ' : $value' : ''}');
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
