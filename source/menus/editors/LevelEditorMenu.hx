package menus.editors;

import data.LevelData;
import flixel.addons.ui.*;
import flixel.ui.FlxButton;

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

		ASSETS_DIRECTORY_TEXT.text = SONG_JSON.assets.directory;
		ASSETS_PLAYER_TEXT.text = SONG_JSON.assets.player;
	}

	function addSettingsTab()
	{
		var tab_group = new FlxUI(null, UI_BOX);
		tab_group.name = '_Setting';

		UI_BOX.addGroup(tab_group);
	}

	public var ASSETS_DIRECTORY_TEXT:FlxInputText;
	public var ASSETS_PLAYER_TEXT:FlxInputText;

	function addAssetsTab()
	{
		var tab_group = new FlxUI(null, UI_BOX);
		tab_group.name = '_Assets';

		ASSETS_DIRECTORY_TEXT = new FlxInputText(10, 10, 200, 'Directory', 16);
		ASSETS_PLAYER_TEXT = new FlxInputText(10, ASSETS_DIRECTORY_TEXT.y + ASSETS_DIRECTORY_TEXT.height + 10, 200, 'player', 16);

		tab_group.add(ASSETS_DIRECTORY_TEXT);
		tab_group.add(new FlxText(ASSETS_DIRECTORY_TEXT.x + ASSETS_DIRECTORY_TEXT.width + 10, ASSETS_DIRECTORY_TEXT.y, 0,
			'Art directory (ex: "earth-overdrive/")\nINCLUDE THE "/" AT THE END', 12));
		tab_group.add(ASSETS_PLAYER_TEXT);
		tab_group.add(new FlxText(ASSETS_PLAYER_TEXT.x + ASSETS_PLAYER_TEXT.width + 10, ASSETS_PLAYER_TEXT.y, 0,
			'Player filename (ex: "player-hiku")', 16));

		UI_BOX.addGroup(tab_group);
	}

	public var AUTHOR_TEXT:FlxInputText;

	function addMiscTab()
	{
		var tab_group = new FlxUI(null, UI_BOX);
		tab_group.name = 'Misc';

		AUTHOR_TEXT = new FlxInputText(10, 10, 200, 'Person', 16);

		tab_group.add(AUTHOR_TEXT);
		tab_group.add(new FlxText(AUTHOR_TEXT.x + AUTHOR_TEXT.width + 10, AUTHOR_TEXT.y, 0, 'Author Name', 16));

		tab_group.add(new FlxButton(10, UI_BOX.height - 60, 'Play', () ->
		{
			SONG_JSON.author = AUTHOR_TEXT.text;
			SONG_JSON.assets.directory = ASSETS_DIRECTORY_TEXT.text;
			SONG_JSON.assets.player = ASSETS_PLAYER_TEXT.text;

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
