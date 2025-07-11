package menus.options;

import base.TextSelecting;

class ControlsMenu extends TextSelecting
{
	public var control_id:Map<String, String> = [];

	public function newControl(name:String, controlId:String)
	{
		texts.push(name);
		control_id.set(name, controlId);
	}

	override public function new()
	{
		super();

		texts = [];
		newControl('Gameplay Shoot', 'gameplay_shoot');
		newControl('Gameplay Move Up', 'gameplay_move_up');
		newControl('Gameplay Move Down', 'gameplay_move_down');
	}

	override public function create()
	{
		#if (discord_rpc && !hl)
		Discord.changePresence('In the control menu', 'Probably trying to adjust their controls');
		#end

		super.create();
	}

	override function backKey()
	{
		FlxG.switchState(OptionsMenuMain.new);
	}

	override function enterKey() {}
}
