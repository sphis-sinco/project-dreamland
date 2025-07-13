package menus.editors;

import data.LevelData;
import flixel.addons.ui.*;
import flixel.math.FlxMath;
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
			{name: '_Settings1', label: 'Settings'},
		];

		UI_BOX = new FlxUITabMenu(null, tabs, true);

		UI_BOX.resize(FlxG.width, FlxG.height - 96);
		UI_BOX.screenCenter();

		UI_BOX.selected_tab = 0;
		add(UI_BOX);

		addMiscTab();
		addAssetsTab();
		addSettingsTab1();

		ASSETS_DIRECTORY_TEXT.text = SONG_JSON.assets.directory;
		ASSETS_PLAYER_TEXT.text = SONG_JSON.assets.player;

		ASSETS_ENEMY_COMMON_TEXT.text = SONG_JSON.assets.enemy_common;
		ASSETS_ENEMY_EASY_TEXT.text = SONG_JSON.assets.enemy_easy;
		ASSETS_ENEMY_RARE_TEXT.text = SONG_JSON.assets.enemy_rare;

		SETTINGS_AMMO_NUM.value = SONG_JSON.settings.ammo;

		SETTINGS_SCORE_ENEMY_COMMON_NUM.value = SONG_JSON.settings.scores.enemy_common;
		SETTINGS_SCORE_ENEMY_EASY_NUM.value = SONG_JSON.settings.scores.enemy_easy;
		SETTINGS_SCORE_ENEMY_RARE_NUM.value = SONG_JSON.settings.scores.enemy_rare;

		SETTINGS_CHANCES_ENEMY_EASY_NUM.value = SONG_JSON.settings.chances.enemy_easy;
		SETTINGS_CHANCES_ENEMY_RARE_NUM.value = SONG_JSON.settings.chances.enemy_rare;
	}

	function addSettingsTab2()
	{
		var tab_group = new FlxUI(null, UI_BOX);
		tab_group.name = '_Settings2';

		UI_BOX.addGroup(tab_group);
	}

	public var SETTINGS_AMMO_NUM:FlxUINumericStepper;

	public var SETTINGS_SCORE_ENEMY_RARE_NUM:FlxUINumericStepper;
	public var SETTINGS_SCORE_ENEMY_EASY_NUM:FlxUINumericStepper;
	public var SETTINGS_SCORE_ENEMY_COMMON_NUM:FlxUINumericStepper;

	public var SETTINGS_CHANCES_ENEMY_RARE_NUM:FlxUINumericStepper;
	public var SETTINGS_CHANCES_ENEMY_EASY_NUM:FlxUINumericStepper;

	function addSettingsTab1()
	{
		var tab_group = new FlxUI(null, UI_BOX);
		tab_group.name = '_Settings1';

		SETTINGS_AMMO_NUM = new FlxUINumericStepper(10, 10, 1, 2, 1, 10);
		SETTINGS_SCORE_ENEMY_RARE_NUM = new FlxUINumericStepper(10, SETTINGS_AMMO_NUM.y + SETTINGS_AMMO_NUM.height + 5, 5, 2, 0, FlxMath.MAX_VALUE_INT);
		SETTINGS_SCORE_ENEMY_EASY_NUM = new FlxUINumericStepper(10, SETTINGS_SCORE_ENEMY_RARE_NUM.y + SETTINGS_SCORE_ENEMY_RARE_NUM.height + 5, 5, 2,
			0, FlxMath.MAX_VALUE_INT);
		SETTINGS_SCORE_ENEMY_COMMON_NUM = new FlxUINumericStepper(10, SETTINGS_SCORE_ENEMY_EASY_NUM.y + SETTINGS_SCORE_ENEMY_EASY_NUM.height + 5, 5,
			2, 0, FlxMath.MAX_VALUE_INT);

		SETTINGS_CHANCES_ENEMY_RARE_NUM = new FlxUINumericStepper(10, SETTINGS_SCORE_ENEMY_COMMON_NUM.y + SETTINGS_SCORE_ENEMY_COMMON_NUM.height + 5,
			0.5, 2, 0, 100);
		SETTINGS_CHANCES_ENEMY_EASY_NUM = new FlxUINumericStepper(10, SETTINGS_CHANCES_ENEMY_RARE_NUM.y + SETTINGS_CHANCES_ENEMY_RARE_NUM.height + 5,
			0.5, 2, 0, 100);

		tab_group.add(SETTINGS_AMMO_NUM);
		tab_group.add(new FlxText(SETTINGS_AMMO_NUM.x + SETTINGS_AMMO_NUM.width + 10, SETTINGS_AMMO_NUM.y, 0,
			'Ammo amount, recommended for your player to have the right animations for this amount of ammo', 8));
		tab_group.add(SETTINGS_SCORE_ENEMY_RARE_NUM);
		tab_group.add(new FlxText(SETTINGS_SCORE_ENEMY_RARE_NUM.x + SETTINGS_SCORE_ENEMY_RARE_NUM.width + 10, SETTINGS_SCORE_ENEMY_RARE_NUM.y, 0,
			'Score from a rare enemy', 8));
		tab_group.add(SETTINGS_SCORE_ENEMY_EASY_NUM);
		tab_group.add(new FlxText(SETTINGS_SCORE_ENEMY_EASY_NUM.x + SETTINGS_SCORE_ENEMY_EASY_NUM.width + 10, SETTINGS_SCORE_ENEMY_EASY_NUM.y, 0,
			'Score from a easy enemy', 8));
		tab_group.add(SETTINGS_SCORE_ENEMY_COMMON_NUM);
		tab_group.add(new FlxText(SETTINGS_SCORE_ENEMY_COMMON_NUM.x + SETTINGS_SCORE_ENEMY_COMMON_NUM.width + 10, SETTINGS_SCORE_ENEMY_COMMON_NUM.y,
			0, 'Score from a common enemy', 8));

		tab_group.add(SETTINGS_CHANCES_ENEMY_RARE_NUM);
		tab_group.add(new FlxText(SETTINGS_CHANCES_ENEMY_RARE_NUM.x + SETTINGS_CHANCES_ENEMY_RARE_NUM.width + 10, SETTINGS_CHANCES_ENEMY_RARE_NUM.y,
			0, 'Chances for a rare enemy to appear', 8));
		tab_group.add(SETTINGS_CHANCES_ENEMY_EASY_NUM);
		tab_group.add(new FlxText(SETTINGS_CHANCES_ENEMY_EASY_NUM.x + SETTINGS_CHANCES_ENEMY_EASY_NUM.width + 10, SETTINGS_CHANCES_ENEMY_EASY_NUM.y,
			0, 'Chances for a easy enemy to appear', 8));

		UI_BOX.addGroup(tab_group);
	}

	public var ASSETS_DIRECTORY_TEXT:FlxInputText;
	public var ASSETS_PLAYER_TEXT:FlxInputText;

	public var ASSETS_ENEMY_RARE_TEXT:FlxInputText;
	public var ASSETS_ENEMY_EASY_TEXT:FlxInputText;
	public var ASSETS_ENEMY_COMMON_TEXT:FlxInputText;

	function addAssetsTab()
	{
		var tab_group = new FlxUI(null, UI_BOX);
		tab_group.name = '_Assets';

		ASSETS_DIRECTORY_TEXT = new FlxInputText(10, 10, 200, 'Directory', 16);
		ASSETS_PLAYER_TEXT = new FlxInputText(10, ASSETS_DIRECTORY_TEXT.y + ASSETS_DIRECTORY_TEXT.height + 10, 200, 'player', 16);

		ASSETS_ENEMY_RARE_TEXT = new FlxInputText(10, ASSETS_PLAYER_TEXT.y + ASSETS_PLAYER_TEXT.height + 40, 200, 'enemy-rare', 16);
		ASSETS_ENEMY_EASY_TEXT = new FlxInputText(10, ASSETS_ENEMY_RARE_TEXT.y + ASSETS_ENEMY_RARE_TEXT.height + 10, 200, 'enemy-easy', 16);
		ASSETS_ENEMY_COMMON_TEXT = new FlxInputText(10, ASSETS_ENEMY_EASY_TEXT.y + ASSETS_ENEMY_EASY_TEXT.height + 10, 200, 'enemy-common', 16);

		tab_group.add(ASSETS_DIRECTORY_TEXT);
		tab_group.add(new FlxText(ASSETS_DIRECTORY_TEXT.x + ASSETS_DIRECTORY_TEXT.width + 10, ASSETS_DIRECTORY_TEXT.y, 0,
			'Art directory (ex: "earth-overdrive/")\nINCLUDE THE "/" AT THE END', 12));
		tab_group.add(ASSETS_PLAYER_TEXT);
		tab_group.add(new FlxText(ASSETS_PLAYER_TEXT.x + ASSETS_PLAYER_TEXT.width + 10, ASSETS_PLAYER_TEXT.y, 0,
			'Player filename (ex: "player-hiku")', 16));

		tab_group.add(ASSETS_ENEMY_RARE_TEXT);
		tab_group.add(new FlxText(ASSETS_ENEMY_RARE_TEXT.x + ASSETS_ENEMY_RARE_TEXT.width + 10, ASSETS_ENEMY_RARE_TEXT.y, 0, 'Rare enemy art path',
			16));
		tab_group.add(new FlxText(ASSETS_ENEMY_RARE_TEXT.x, ASSETS_ENEMY_RARE_TEXT.y - ASSETS_ENEMY_RARE_TEXT.height - 10, 0,
			'(Relative to the art directory)', 16));

		tab_group.add(ASSETS_ENEMY_EASY_TEXT);
		tab_group.add(new FlxText(ASSETS_ENEMY_EASY_TEXT.x + ASSETS_ENEMY_EASY_TEXT.width + 10, ASSETS_ENEMY_EASY_TEXT.y, 0, 'Easy enemy art path',
			16));

		tab_group.add(ASSETS_ENEMY_COMMON_TEXT);
		tab_group.add(new FlxText(ASSETS_ENEMY_COMMON_TEXT.x + ASSETS_ENEMY_COMMON_TEXT.width + 10, ASSETS_ENEMY_COMMON_TEXT.y, 0,
			'Common enemy art path', 16));

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
			saveSongJson();

			PlayState.GOTO_LEVEL_EDITOR = true;
			FlxG.switchState(() -> new PlayState(SONG_JSON));
		}));

		UI_BOX.addGroup(tab_group);
	}

	public dynamic function saveSongJson()
	{
		SONG_JSON.author = AUTHOR_TEXT.text;

		SONG_JSON.assets.directory = ASSETS_DIRECTORY_TEXT.text;
		SONG_JSON.assets.player = ASSETS_PLAYER_TEXT.text;

		SONG_JSON.assets.enemy_common = ASSETS_ENEMY_COMMON_TEXT.text;
		SONG_JSON.assets.enemy_easy = ASSETS_ENEMY_EASY_TEXT.text;
		SONG_JSON.assets.enemy_rare = ASSETS_ENEMY_RARE_TEXT.text;

		SONG_JSON.settings.ammo = Std.int(SETTINGS_AMMO_NUM.value);

		SONG_JSON.settings.scores.enemy_common = Std.int(SETTINGS_SCORE_ENEMY_COMMON_NUM.value);
		SONG_JSON.settings.scores.enemy_easy = Std.int(SETTINGS_SCORE_ENEMY_EASY_NUM.value);
		SONG_JSON.settings.scores.enemy_rare = Std.int(SETTINGS_SCORE_ENEMY_RARE_NUM.value);

		SONG_JSON.settings.chances.enemy_easy = Std.int(SETTINGS_CHANCES_ENEMY_EASY_NUM.value);
		SONG_JSON.settings.chances.enemy_rare = Std.int(SETTINGS_CHANCES_ENEMY_RARE_NUM.value);
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
