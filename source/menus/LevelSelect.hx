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

	override public function create()
	{
		#if !web
		var oglevels = FileManager.getTypeArray('level files', 'data/levelSelect', ['.dreamEntry'], ['assets/data/levelSelect/']);

		levels = [];
		for (level in oglevels)
		{
			var newlevel = level.replace('assets/data/levelSelect/', '');

			levels.push(newlevel);
		}
		#end

		difficulty.y = FlxG.height - difficulty.height;
		add(difficulty);

		#if (discord_rpc && !hl)
		Discord.changePresence('In the menus', 'Looking for a Level to play');
		#end

		level_json ??= LevelSelectEntryDataManager.defaultJSON;

		level_sprite.loadGraphic(FileManager.getImageFile(LevelSelectEntryDataManager.getFileName(level_json, VARIATION_INDEX, 'background')));
		level_sprite.scale.set(1.25, 1.25);
		level_sprite.screenCenter();
		add(level_sprite);

		updateSelections();

		super.create();
	}

	var key_left:Bool;
	var key_right:Bool;
	var key_up:Bool;
	var key_down:Bool;
	var key_enter:Bool;

	override public function update(elapsed:Float)
	{
		key_left = Controls.UI_MOVE_LEFT;
		key_right = Controls.UI_MOVE_RIGHT;
		key_up = Controls.UI_MOVE_UP;
		key_down = Controls.UI_MOVE_DOWN;
		key_enter = Controls.UI_SELECT;

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
			if (VARIATION_INDEX > level_json.variations.length - 1)
			{
				VARIATION_INDEX--;
			}
			else
				Global.playSound('blip');
			updateSelections();
		}

		if (key_enter)
		{
			Global.playSound('select');
			PlayState.CURRENT_LEVEL = levels[CURRENT_SELECTION];
			FlxG.switchState(() -> new PlayState(FileManager.getJSON(FileManager.getDataFile('levels/'
				+ LevelSelectEntryDataManager.getJsonFileName(level_json, VARIATION_INDEX)
				+ '.dream'))));
		}
		else if (Controls.UI_LEAVE)
		{
			Global.playSound('select');
			FlxG.switchState(MenuState.new);
		}

		super.update(elapsed);
	}

	function updateSelections()
	{
		difficulty.size = 32;
		var filepath:String = (!levels[CURRENT_SELECTION].contains('levelSelect/')) ? 'levelSelect/' : '';
		filepath += levels[CURRENT_SELECTION];
		filepath += (!levels[CURRENT_SELECTION].endsWith('.dreamEntry')) ? '.dreamEntry' : '';

		var filename:String = (!filepath.contains('data/levelSelect/')) ? FileManager.getDataFile(filepath) : filepath;
		FlxG.log.add(filename);
		level_json = Json.parse(FileManager.readFile(filename));
		difficulty.text = level_json.name + ' (${level_json.variations[VARIATION_INDEX]})' + ' - ' + level_json.difficulties[VARIATION_INDEX];
		var bgpath = LevelSelectEntryDataManager.getFileName(level_json, VARIATION_INDEX, 'background');
		TryCatch.tryCatch(() ->
		{
			level_sprite.loadGraphic(FileManager.getImageFile(bgpath));
		}, {
				errFunc: () ->
				{
					level_sprite.loadGraphic(FileManager.getImageFile('background'));
				}
		});
		difficulty.screenCenter(X);
	}
}
