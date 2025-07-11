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
		newControl('Gameplay Move Up (Alt)', 'gameplay_move_up_alt');

		newControl('Gameplay Move Down', 'gameplay_move_down');
		newControl('Gameplay Move Down (Alt)', 'gameplay_move_down_alt');

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

		popupText = new FlxText(0, 0, popup.width, '', 16);
		popupText.alignment = CENTER;

		popup.screenCenter();
	}

	override public function create()
	{
		#if (discord_rpc && !hl)
		Discord.changePresence('In the control menu', 'Probably trying to adjust their controls');
		#end

		super.create();

		add(popup);
		add(popupText);
	}

	public var popup:FlxSprite = new FlxSprite().loadGraphic(FileManager.getImageFile('menus/Yellowpopup'));
	public var popupText:FlxText;
	public var buttonRemapping:Bool = false;

	override function update(elapsed:Float)
	{
		popup.visible = buttonRemapping;
		popupText.visible = popup.visible;

		popupText.text = 'Change the keybind for "${texts[CURRENT_SELECTION]}"'
			+ '\n(Current: ${Controls.getKey(control_id.get(texts[CURRENT_SELECTION]))})'
			+ '\n\nPress ${Controls.getKey('ui_leave')} to leave';
		popupText.screenCenter();

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
			if (Controls.UI_LEAVE)
			{
				buttonRemapping = false;
			}
			else
			{
				var key:FlxKey = FlxG.keys.firstJustReleased();

				if (key != NONE)
				{
					if (key != Controls.ui_leave_keybind)
						Controls.setKey(control_id.get(texts[CURRENT_SELECTION]), key);
				}
			}
		}
	}
}
