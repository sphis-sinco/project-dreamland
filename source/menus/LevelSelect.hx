package menus;

import data.LevelData;
import data.LevelSelectEntryData;

class LevelSelect extends FlxState
{
	var levels:Array<String> = ['earth', 'heaven', 'hell', 'hiku', 'jujin'];
	var level_sprite:FlxSprite = new FlxSprite();

	var level_json:LevelSelectEntryData;

	var difficulty:FlxText = new FlxText(0, 0, 0, "", 32);

	var CURRENT_SELECTION:Int = 0;
	var VARIATION_INDEX:Int = 0;

	public var interact:MobileButton = new MobileButton(A_BUTTON);
	public var leave:MobileButton = new MobileButton(B_BUTTON);

	public var left:MobileButton = new MobileButton(LEFT_BUTTON);
	public var right:MobileButton = new MobileButton(RIGHT_BUTTON);

	public var up:MobileButton = new MobileButton(UP_BUTTON);
	public var down:MobileButton = new MobileButton(DOWN_BUTTON);

	override public function create()
	{
		interact.x = FlxG.width - interact.width * (MobileButton.scaleVal * 2);
		leave.x = FlxG.width - leave.width * MobileButton.scaleVal;

		left.x = left.width * (MobileButton.scaleVal - 2);
		right.x = left.x + (right.width * (MobileButton.scaleVal * 2));

		down.x = left.x + (down.width * MobileButton.scaleVal);
		up.x = down.x;
		up.y -= up.height * MobileButton.scaleVal;

		#if !(web || MOBILE_BUILD)
		var oglevels = FileManager.getTypeArray('level files', 'data/levelSelect', ['.dreamEntry'], ['assets/data/levelSelect/']);

		levels = [];
		for (level in oglevels)
		{
			var newlevel = level.replace('assets/data/levelSelect/', '');

			levels.push(newlevel);
		}
		#end

		difficulty.y = difficulty.height / 2;
		add(difficulty);

		#if DISCORDRPC
		Discord.changePresence('In the menus', 'Looking for a Level to play');
		#end

		if (level_json == null)
			level_json = LevelSelectEntryDataManager.defaultJSON;

		level_sprite.loadGraphic(FileManager.getImageFile(LevelSelectEntryDataManager.getFileName(level_json, VARIATION_INDEX, 'background')));
		level_sprite.scale.set(1, 1);
		level_sprite.screenCenter();
		add(level_sprite);

		updateSelections();

		super.create();

		#if MOBILE_BUILD
		add(interact);
		add(leave);
		add(up);
		add(down);
		add(left);
		add(right);
		#end
	}

	var key_left:Bool;
	var key_right:Bool;
	var key_up:Bool;
	var key_down:Bool;
	var key_enter:Bool;

	override public function update(elapsed:Float)
	{
		key_left = Controls.UI_MOVE_LEFT || left.justReleased;
		key_right = Controls.UI_MOVE_RIGHT || right.justReleased;
		key_up = Controls.UI_MOVE_UP || up.justReleased;
		key_down = Controls.UI_MOVE_DOWN || down.justReleased;
		key_enter = Controls.UI_SELECT || interact.justReleased;

		if (key_left)
		{
			CURRENT_SELECTION--;
			if (CURRENT_SELECTION < 0)
			{
				CURRENT_SELECTION = 0;
			}
			else
				Global.playSound('blip');
			updateSelections();
		}
		else if (key_right)
		{
			CURRENT_SELECTION++;
			if (CURRENT_SELECTION > levels.length - 1)
			{
				CURRENT_SELECTION--;
			}
			else
				Global.playSound('blip');
			updateSelections();
		}
		else if (key_up)
		{
			VARIATION_INDEX--;
			if (VARIATION_INDEX < 0)
			{
				VARIATION_INDEX = 0;
			}
			else
				Global.playSound('blip');
			updateSelections();
		}
		else if (key_down)
		{
			VARIATION_INDEX++;

			if (VARIATION_INDEX <= level_json.variations.length - 1)
				Global.playSound('blip');
			updateSelections();
		}

		if (key_enter)
		{
			Global.playSound('select');
			var levelName = LevelSelectEntryDataManager.getJsonFileName(level_json, VARIATION_INDEX);
			PlayState.CURRENT_LEVEL = levelName;

			var path = 'levels/' + levelName + '.dream';
			var finalPath = FileManager.getDataFile(path);

			if (level_json.modded)
				finalPath = 'mods/${level_json.modFolder}/data/' + path;

			trace(finalPath);

			FlxG.switchState(() -> new PlayState(FileManager.getJSON(finalPath)));
		}
		else if (Controls.UI_LEAVE || leave.justReleased)
		{
			Global.playSound('select');
			FlxG.switchState(MenuState.new);
		}

		super.update(elapsed);
	}

	function updateSelections()
	{
		TryCatch.tryCatch(() -> updateSelMainFunc(), {traceErr: true, errFunc: d -> updateSelSecondFunc(d)});
		difficulty.screenCenter(X);
	}

	function updateSelMainFunc()
	{
		var filepath:String = (!levels[CURRENT_SELECTION].contains('levelSelect/')) ? 'levelSelect/' : '';
		filepath += levels[CURRENT_SELECTION];
		filepath += (!levels[CURRENT_SELECTION].endsWith('.dreamEntry')) ? '.dreamEntry' : '';

		var filename:String = (!filepath.contains('data/levelSelect/')) ? FileManager.getDataFile(filepath) : filepath;
		FlxG.log.add(filename);

		level_json = FileManager.getJSON(filename);

		if (VARIATION_INDEX > level_json.variations.length - 1)
			VARIATION_INDEX = level_json.variations.length - 1;

		difficulty.size = 32;

		difficulty.text = level_json.name + ' (${level_json.variations[VARIATION_INDEX]})' + ' - ' + level_json.difficulties[VARIATION_INDEX];
		loadBG();
	}

	function updateSelSecondFunc(d:Dynamic)
	{
		FlxG.log.add(d);
		difficulty.text = levels[CURRENT_SELECTION] + ': $d';
		loadBG();
	}

	function loadBG()
	{
		var bgpath = LevelSelectEntryDataManager.getFileName(level_json, VARIATION_INDEX, 'background');
		TryCatch.tryCatch(() ->
		{
			level_sprite.loadGraphic(FileManager.getImageFile(bgpath));
		}, {
				errFunc: d ->
				{
					level_sprite.loadGraphic(FileManager.getImageFile('background'));
				}
		});
	}
}
