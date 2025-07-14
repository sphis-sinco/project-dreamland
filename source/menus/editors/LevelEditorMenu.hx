package menus.editors;

import data.LevelData;
import flixel.addons.ui.*;
import flixel.math.FlxMath;
import flixel.text.FlxInputText;
import flixel.ui.FlxButton;
import openfl.events.Event;
import openfl.events.IOErrorEvent;
import openfl.net.FileFilter;
import openfl.net.FileReference;

class LevelEditorMenu extends FlxState
{
	public static var instance:LevelEditorMenu = null;

	public var _file:FileReference;

	public static var LEVEL_JSON:LevelData = null;

	public var UI_BOX:FlxUITabMenu;

	public var initalized:Bool = false;

	override function create()
	{
		instance = this;

		LEVEL_JSON = (LEVEL_JSON == null) ? LevelDataManager.defaultJSON : LEVEL_JSON;

		initalized = false;

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

		loadJSON();
		AUTHOR_TEXT.text = 'Person';

		initalized = true;
	}

	function loadJSON()
	{
		AUTHOR_TEXT.text = LEVEL_JSON.author;

		ASSETS_DIRECTORY_TEXT.text = LEVEL_JSON.assets.directory;
		ASSETS_PLAYER_TEXT.text = LEVEL_JSON.assets.player;

		ASSETS_ENEMY_COMMON_TEXT.text = LEVEL_JSON.assets.enemy_common;
		ASSETS_ENEMY_EASY_TEXT.text = LEVEL_JSON.assets.enemy_easy;
		ASSETS_ENEMY_RARE_TEXT.text = LEVEL_JSON.assets.enemy_rare;

		SETTINGS_AMMO_NUM.value = LEVEL_JSON.settings.ammo;

		SETTINGS_SCORE_ENEMY_COMMON_NUM.value = LEVEL_JSON.settings.scores.enemy_common;
		SETTINGS_SCORE_ENEMY_EASY_NUM.value = LEVEL_JSON.settings.scores.enemy_easy;
		SETTINGS_SCORE_ENEMY_RARE_NUM.value = LEVEL_JSON.settings.scores.enemy_rare;

		SETTINGS_CHANCES_ENEMY_EASY_NUM.value = LEVEL_JSON.settings.chances.enemy_easy;
		SETTINGS_CHANCES_ENEMY_RARE_NUM.value = LEVEL_JSON.settings.chances.enemy_rare;

		SETTINGS_SPEED_ENEMY_COMMON_NUM.value = LEVEL_JSON.settings.speed_additions.enemy_common;
		SETTINGS_SPEED_ENEMY_EASY_NUM.value = LEVEL_JSON.settings.speed_additions.enemy_easy;
		SETTINGS_SPEED_ENEMY_RARE_NUM.value = LEVEL_JSON.settings.speed_additions.enemy_rare;
	}

	function addSettingsTab2()
	{
		var tab_group = new FlxUI(null, UI_BOX);
		tab_group.name = '_Settings2';

		UI_BOX.addGroup(tab_group);
	}

	public var SETTINGS_AMMO_NUM:FlxUINumericStepper = new FlxUINumericStepper();

	public var SETTINGS_SCORE_ENEMY_RARE_NUM:FlxUINumericStepper = new FlxUINumericStepper();
	public var SETTINGS_SCORE_ENEMY_EASY_NUM:FlxUINumericStepper = new FlxUINumericStepper();
	public var SETTINGS_SCORE_ENEMY_COMMON_NUM:FlxUINumericStepper = new FlxUINumericStepper();

	public var SETTINGS_CHANCES_ENEMY_RARE_NUM:FlxUINumericStepper = new FlxUINumericStepper();
	public var SETTINGS_CHANCES_ENEMY_EASY_NUM:FlxUINumericStepper = new FlxUINumericStepper();

	public var SETTINGS_SPEED_ENEMY_RARE_NUM:FlxUINumericStepper = new FlxUINumericStepper();
	public var SETTINGS_SPEED_ENEMY_EASY_NUM:FlxUINumericStepper = new FlxUINumericStepper();
	public var SETTINGS_SPEED_ENEMY_COMMON_NUM:FlxUINumericStepper = new FlxUINumericStepper();

	function addSettingsTab1()
	{
		var tab_group = new FlxUI(null, UI_BOX);
		tab_group.name = '_Settings1';

		SETTINGS_AMMO_NUM = new FlxUINumericStepper(10, 10, 1, 2, 1, 10);

		SETTINGS_SCORE_ENEMY_RARE_NUM = new FlxUINumericStepper(10, SETTINGS_AMMO_NUM.y + SETTINGS_AMMO_NUM.height + 15, 5, 2, 0,
			FlxMath.MAX_VALUE_INT);
		SETTINGS_SCORE_ENEMY_EASY_NUM = new FlxUINumericStepper(10, SETTINGS_SCORE_ENEMY_RARE_NUM.y + SETTINGS_SCORE_ENEMY_RARE_NUM.height + 5, 5, 2,
			0, FlxMath.MAX_VALUE_INT);
		SETTINGS_SCORE_ENEMY_COMMON_NUM = new FlxUINumericStepper(10, SETTINGS_SCORE_ENEMY_EASY_NUM.y + SETTINGS_SCORE_ENEMY_EASY_NUM.height + 5, 5,
			2, 0, FlxMath.MAX_VALUE_INT);

		SETTINGS_CHANCES_ENEMY_RARE_NUM = new FlxUINumericStepper(10, SETTINGS_SCORE_ENEMY_COMMON_NUM.y + SETTINGS_SCORE_ENEMY_COMMON_NUM.height + 15,
			0.5, 2, 0, 100, 1);
		SETTINGS_CHANCES_ENEMY_EASY_NUM = new FlxUINumericStepper(10, SETTINGS_CHANCES_ENEMY_RARE_NUM.y + SETTINGS_CHANCES_ENEMY_RARE_NUM.height + 5,
			0.5, 2, 0, 100, 1);

		SETTINGS_SPEED_ENEMY_RARE_NUM = new FlxUINumericStepper(10, SETTINGS_CHANCES_ENEMY_EASY_NUM.y + SETTINGS_CHANCES_ENEMY_EASY_NUM.height + 15,
			0.1, 2, -7, 20, 1);
		SETTINGS_SPEED_ENEMY_EASY_NUM = new FlxUINumericStepper(10, SETTINGS_SPEED_ENEMY_RARE_NUM.y + SETTINGS_SPEED_ENEMY_RARE_NUM.height + 5, 5,
			0.1, -7, 20, 1);
		SETTINGS_SPEED_ENEMY_COMMON_NUM = new FlxUINumericStepper(10, SETTINGS_SPEED_ENEMY_EASY_NUM.y + SETTINGS_SPEED_ENEMY_EASY_NUM.height + 5, 0.1,
			2, -7, 20, 1);

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

		tab_group.add(SETTINGS_SPEED_ENEMY_RARE_NUM);
		tab_group.add(new FlxText(SETTINGS_SPEED_ENEMY_RARE_NUM.x + SETTINGS_SPEED_ENEMY_RARE_NUM.width + 10, SETTINGS_SPEED_ENEMY_RARE_NUM.y, 0,
			'Speed increase for rare enemies', 8));
		tab_group.add(SETTINGS_SPEED_ENEMY_EASY_NUM);
		tab_group.add(new FlxText(SETTINGS_SPEED_ENEMY_EASY_NUM.x + SETTINGS_SPEED_ENEMY_EASY_NUM.width + 10, SETTINGS_SPEED_ENEMY_EASY_NUM.y, 0,
			'Speed increase for easy enemies', 8));
		tab_group.add(SETTINGS_SPEED_ENEMY_COMMON_NUM);
		tab_group.add(new FlxText(SETTINGS_SPEED_ENEMY_COMMON_NUM.x + SETTINGS_SPEED_ENEMY_COMMON_NUM.width + 10, SETTINGS_SPEED_ENEMY_COMMON_NUM.y,
			0, 'Speed increase for common enemies', 8));

		UI_BOX.addGroup(tab_group);
	}

	public var ASSETS_DIRECTORY_TEXT:FlxInputText = new FlxInputText();
	public var ASSETS_PLAYER_TEXT:FlxInputText = new FlxInputText();

	public var ASSETS_ENEMY_RARE_TEXT:FlxInputText = new FlxInputText();
	public var ASSETS_ENEMY_EASY_TEXT:FlxInputText = new FlxInputText();
	public var ASSETS_ENEMY_COMMON_TEXT:FlxInputText = new FlxInputText();

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

	public var AUTHOR_TEXT:FlxInputText = new FlxInputText();
	public var INFO_TEXT:FlxText = new FlxText();

	function addMiscTab()
	{
		var tab_group = new FlxUI(null, UI_BOX);
		tab_group.name = 'Misc';

		AUTHOR_TEXT = new FlxInputText(10, 10, 200, 'Person', 16);

		INFO_TEXT = new FlxText(10, AUTHOR_TEXT.y + AUTHOR_TEXT.height + 40, 0, "", 16);

		tab_group.add(AUTHOR_TEXT);
		tab_group.add(new FlxText(AUTHOR_TEXT.x + AUTHOR_TEXT.width + 10, AUTHOR_TEXT.y, 0, 'Author Name', 16));
		tab_group.add(INFO_TEXT);
		tab_group.add(new FlxText(INFO_TEXT.x, INFO_TEXT.y + INFO_TEXT.height - 40, 0, 'Information about this level:', 16));

		tab_group.add(new FlxButton(10, UI_BOX.height - 60, 'Play', () ->
		{
			saveLevelJson();

			PlayState.GOTO_LEVEL_EDITOR = true;
			FlxG.switchState(() -> new PlayState(LEVEL_JSON));
		}));
		tab_group.add(new FlxButton(100, UI_BOX.height - 60, 'Save level', () ->
		{
			saveLevel();
		}));
		tab_group.add(new FlxButton(190, UI_BOX.height - 60, 'Load level', () ->
		{
			loadLevel();
		}));

		UI_BOX.addGroup(tab_group);
	}

	public dynamic function saveLevelJson()
	{
		LEVEL_JSON = getAssembledLevelJson();
	}

	public function getAssembledLevelJson():LevelData
	{
		var returnJson:LevelData = LevelDataManager.defaultJSON;

		if (!initalized)
			return returnJson;

		returnJson.author = AUTHOR_TEXT.text;

		returnJson.assets.directory = ASSETS_DIRECTORY_TEXT.text;
		returnJson.assets.player = ASSETS_PLAYER_TEXT.text;

		returnJson.assets.enemy_common = ASSETS_ENEMY_COMMON_TEXT.text;
		returnJson.assets.enemy_easy = ASSETS_ENEMY_EASY_TEXT.text;
		returnJson.assets.enemy_rare = ASSETS_ENEMY_RARE_TEXT.text;

		returnJson.settings.ammo = Std.int(SETTINGS_AMMO_NUM.value);

		returnJson.settings.scores.enemy_common = Std.int(SETTINGS_SCORE_ENEMY_COMMON_NUM.value);
		returnJson.settings.scores.enemy_easy = Std.int(SETTINGS_SCORE_ENEMY_EASY_NUM.value);
		returnJson.settings.scores.enemy_rare = Std.int(SETTINGS_SCORE_ENEMY_RARE_NUM.value);

		returnJson.settings.chances.enemy_easy = Std.int(SETTINGS_CHANCES_ENEMY_EASY_NUM.value);
		returnJson.settings.chances.enemy_rare = Std.int(SETTINGS_CHANCES_ENEMY_RARE_NUM.value);

		returnJson.settings.speed_additions.enemy_common = Std.int(SETTINGS_SPEED_ENEMY_COMMON_NUM.value);
		returnJson.settings.speed_additions.enemy_easy = Std.int(SETTINGS_SPEED_ENEMY_EASY_NUM.value);
		returnJson.settings.speed_additions.enemy_rare = Std.int(SETTINGS_SPEED_ENEMY_RARE_NUM.value);

		return returnJson;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		INFO_TEXT.text = '';
		if (initalized)
		{
			saveLevelJson();

			infoTextFileCheck('background image', 'images/${LEVEL_JSON.assets.directory}background.png');
			infoTextFileCheck('player data file', 'data/players/${LEVEL_JSON.assets.player}.json');

			infoTextFileCheck('enemy (common) image', 'images/${LEVEL_JSON.assets.directory}${LEVEL_JSON.assets.enemy_common}.png');
			infoTextFileCheck('enemy (easy) image', 'images/${LEVEL_JSON.assets.directory}${LEVEL_JSON.assets.enemy_easy}.png');
			infoTextFileCheck('enemy (rare) image', 'images/${LEVEL_JSON.assets.directory}${LEVEL_JSON.assets.enemy_rare}.png');
		}

		if (Controls.UI_LEAVE)
		{
			instance = null;
			FlxG.switchState(EditorMenu.new);
		}
	}

	public function infoTextFileCheck(name:String = 'file', path:String, indent:Bool = true)
	{
		INFO_TEXT.text += '${indent ? '\n' : ''}* $name exists: ${FileManager.exists(FileManager.getAssetFile(path))}';
	}

	private function saveLevel()
	{
		var json = LEVEL_JSON;

		var data:String = Json.stringify(json);

		if ((data != null) && (data.length > 0))
		{
			_file = new FileReference();
			_file.addEventListener(Event.COMPLETE, onSaveComplete);
			_file.addEventListener(Event.CANCEL, onSaveCancel);
			_file.addEventListener(IOErrorEvent.IO_ERROR, onSaveError);
			_file.save(data.trim(), '${LEVEL_JSON.author}s-level.dream');
		}
	}

	function onSaveComplete(_):Void
	{
		_file.removeEventListener(Event.COMPLETE, onSaveComplete);
		_file.removeEventListener(Event.CANCEL, onSaveCancel);
		_file.removeEventListener(IOErrorEvent.IO_ERROR, onSaveError);
		_file = null;
		FlxG.log.notice("Successfully saved LEVEL DATA.");
	}

	/**
	 * Called when the save file dialog is cancelled.
	 */
	function onSaveCancel(_):Void
	{
		_file.removeEventListener(Event.COMPLETE, onSaveComplete);
		_file.removeEventListener(Event.CANCEL, onSaveCancel);
		_file.removeEventListener(IOErrorEvent.IO_ERROR, onSaveError);
		_file = null;
	}

	/**
	 * Called if there is an error while saving the gameplay recording.
	 */
	function onSaveError(_):Void
	{
		_file.removeEventListener(Event.COMPLETE, onSaveComplete);
		_file.removeEventListener(Event.CANCEL, onSaveCancel);
		_file.removeEventListener(IOErrorEvent.IO_ERROR, onSaveError);
		_file = null;
		FlxG.log.error("Problem saving Level data");
	}

	function loadLevel()
	{
		var fr:FileReference = new FileReference();
		fr.addEventListener(Event.SELECT, _onSelect, false, 0, true);
		fr.addEventListener(Event.CANCEL, _onCancel, false, 0, true);
		var filters:Array<FileFilter> = new Array<FileFilter>();
		filters.push(new FileFilter("Level Files", "*.dream"));
		filters.push(new FileFilter("JSON Level Files", "*.json"));
		fr.browse();
	}

	function _onSelect(E:Event):Void
	{
		var fr:FileReference = cast(E.target, FileReference);
		fr.addEventListener(Event.COMPLETE, _onLoad, false, 0, true);
		fr.load();
	}

	function _onCancel(_):Void {}

	function _onLoad(E:Event):Void
	{
		var fr:FileReference = cast E.target;
		fr.removeEventListener(Event.COMPLETE, _onLoad);

		// trace(fr.data);
		LEVEL_JSON = Json.parse(fr.data.toString());
		loadJSON();
	}
}
