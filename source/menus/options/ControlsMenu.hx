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
		customCamEnabled = true;

		texts = [];

		newControl('// GAMEPLAY CONTROLS \\', null);
		CURRENT_SELECTION = 1;

		newControl('Gameplay Shoot', 'gameplay_shoot');

		newControl('Gameplay Move Up', 'gameplay_move_up');
		newControl('Gameplay Move Up (Alt)', 'gameplay_move_up_alt');

		newControl('Gameplay Move Down', 'gameplay_move_down');
		newControl('Gameplay Move Down (Alt)', 'gameplay_move_down_alt');

		newControl('// UI CONTROLS \\', null);

		newControl('UI Move Left', 'ui_move_left');
		newControl('UI Move Left (Alt)', 'ui_move_left_alt');

		newControl('UI Move Right', 'ui_move_right');
		newControl('UI Move Right (Alt)', 'ui_move_right_alt');

		newControl('UI Move Up', 'ui_move_up');
		newControl('UI Move Up (Alt)', 'ui_move_up_alt');

		newControl('UI Move Down', 'ui_move_down');
		newControl('UI Move Down (Alt)', 'ui_move_down_alt');

		newControl('UI Select', 'ui_select');
		newControl('UI Leave', 'ui_leave');

		backKey = function()
		{
			instance = null;
			FlxG.switchState(OptionsMenuMain.new);
		}

		enterKey = function()
		{
			if (control_id.get(texts[CURRENT_SELECTION]) != null)
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

		if (control_id.get(texts[CURRENT_SELECTION]) != null)
		{
			popupText.text = 'Change the keybind for "${texts[CURRENT_SELECTION]}"'
				+ '\n(Current: ${Controls.getKey(control_id.get(texts[CURRENT_SELECTION]))})'
				+ '\n\nPress ${Controls.getKey('ui_leave')} to leave';
		}
		popupText.screenCenter();

		super.update(elapsed);
	}

	override function controls()
	{
		if (!buttonRemapping)
		{
			super.controls();

			if (control_id.get(texts[CURRENT_SELECTION]) == null)
			{
				if (key_up)
					CURRENT_SELECTION--;
				if (key_down)
					CURRENT_SELECTION++;

				if (CURRENT_SELECTION < 0)
					CURRENT_SELECTION = 1;

				if (CURRENT_SELECTION > texts.length - 1)
					CURRENT_SELECTION -= 2;
			}
		}
		else
		{
			if (key_back)
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
