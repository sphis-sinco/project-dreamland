package menus.editors;

import flixel.addons.ui.FlxUITabMenu;

class LevelEditorMenu extends FlxState
{
	public var UI_BOX:FlxUITabMenu;

	override function create()
	{
		super.create();

		var tabs = [
			{name: "Misc", label: 'Misc'},
			{name: "Assets", label: 'Assets'},
			{name: "Settings", label: 'Settings'}
		];

		UI_BOX = new FlxUITabMenu(null, tabs, true);

		UI_BOX.resize(FlxG.width, FlxG.height - 128);
		UI_BOX.screenCenter();

		UI_BOX.selected_tab = 0;
		add(UI_BOX);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
