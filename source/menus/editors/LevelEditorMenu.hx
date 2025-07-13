package menus.editors;

import data.LevelData;
import flixel.addons.ui.*;
import flixel.ui.FlxButton;
import menus.options.ControlsMenu;

class LevelEditorMenu extends FlxState
{
	public var SONG_JSON:LevelData = LevelDataManager.defaultJSON;

	public var UI_BOX:FlxUITabMenu;

	override function create()
	{
		super.create();

		var tabs = [
			{name: 'Misc', label: 'Misc'},
			{name: '_Assets', label: 'Assets'},
			{name: '_Settings', label: 'Settings'}
		];

		UI_BOX = new FlxUITabMenu(null, tabs, true);

		UI_BOX.resize(FlxG.width, FlxG.height - 128);
		UI_BOX.screenCenter();

		UI_BOX.selected_tab = 0;
		add(UI_BOX);

		addMiscTab();
		addAssetsTab();
		addSettingsTab();
	}

	function addSettingsTab()
	{
		var tab_group = new FlxUI(null, UI_BOX);
		tab_group.name = '_Setting';

		UI_BOX.addGroup(tab_group);
	}

	function addAssetsTab()
	{
		var tab_group = new FlxUI(null, UI_BOX);
		tab_group.name = '_Assets';

		UI_BOX.addGroup(tab_group);
	}

	public var AUTHOR_NAME_TEXT:FlxInputText;

	function addMiscTab()
	{
		var tab_group = new FlxUI(null, UI_BOX);
		tab_group.name = 'Misc';

		AUTHOR_NAME_TEXT = new FlxInputText(10, 10, 200, 'Person', 16);

		tab_group.add(AUTHOR_NAME_TEXT);
		tab_group.add(new FlxText(AUTHOR_NAME_TEXT.x + AUTHOR_NAME_TEXT.width + 10, AUTHOR_NAME_TEXT.y, 0, 'Author Name', 16));

		tab_group.add(new FlxButton(10, UI_BOX.height - 60, 'Play', () ->
		{
			SONG_JSON.author = AUTHOR_NAME_TEXT.text;

			PlayState.GOTO_LEVEL_EDITOR = true;
			FlxG.switchState(() -> new PlayState(SONG_JSON));
		}));

		UI_BOX.addGroup(tab_group);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (Controls.UI_LEAVE)
		{
			FlxG.switchState(EditorMenu.new);
		}
	}
}
