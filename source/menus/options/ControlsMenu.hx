package menus.options;

import base.TextSelecting;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;

class ControlsMenu extends TextSelecting
{
	public static var instance:ControlsMenu = null;

	public var control_id:Map<String, String> = [];

	public function newControl(name:String, controlId:String)
	{
		texts.push(name);
		control_id.set(name, controlId);
	}

	override public function new()
	{
		super();

		instance = this;

		texts = [];
		newControl('Gameplay Shoot', 'gameplay_shoot');
		newControl('Gameplay Move Up', 'gameplay_move_up');
		newControl('Gameplay Move Down', 'gameplay_move_down');

		backKey = function()
		{
			instance = null;
			FlxG.switchState(OptionsMenuMain.new);
		}

		enterKey = function()
		{
			trace('buttonBULLSHIT');
			buttonRemapping = true;
		}

		popup.screenCenter();
		add(popup);
	}

	override public function create()
	{
		#if (discord_rpc && !hl)
		Discord.changePresence('In the control menu', 'Probably trying to adjust their controls');
		#end

		super.create();
	}

	public var popup:FlxSprite = new FlxSprite().loadGraphic(FileManager.getImageFile('menus/Yellowpopup'));
	public var buttonRemapping:Bool = false;

	override function update(elapsed:Float)
	{
		popup.visible = buttonRemapping;
		super.update(elapsed);
	}

	override function controls()
	{
		if (!buttonRemapping)
		{
			super.controls();
		}
		else
		{
			if (FlxG.keys.justReleased.ESCAPE)
			{
				buttonRemapping = false;
			}
			else
			{
				var key:FlxKey = FlxG.keys.firstJustReleased();

				if (key != NONE)
				{
					if (key != BACKSPACE)
						Controls.setKey(control_id.get(texts[CURRENT_SELECTION]), key);
					buttonRemapping = false;
				}
			}
		}
	}
}
