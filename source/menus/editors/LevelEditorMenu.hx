package menus.editors;

import flixel.addons.ui.FlxUITabMenu;

class LevelEditorMenu extends FlxState
{
	public var UI_BOX:FlxUITabMenu;

	override function create()
	{
		super.create();

		trace('Level Editor');

		var tabs = [
			{name: "Misc", label: 'Misc'},
			{name: "Assets", label: 'Assets'},
			{name: "Settings", label: 'Settings'}
		];

		UI_BOX = new FlxUITabMenu(null, tabs, true);

		UI_BOX.resize(FlxG.width, FlxG.height - 128);
		UI_BOX.screenCenter();
		add(UI_BOX);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
