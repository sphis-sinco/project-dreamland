package menus.options;

import base.TextSelecting;

class ControlsMenu extends TextSelecting
{
	override public function create()
	{
		texts = [];

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
