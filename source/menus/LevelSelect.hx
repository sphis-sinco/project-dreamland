package menus;

import data.LevelData;

class LevelSelect extends FlxState
{
	var levels:Array<String> = ['earth', 'heaven', 'hell', 'jujin'];
	var level_diffs:Array<String> = ['easy-ish', 'medium', 'hard', 'medium-hard'];
	var level_sprite:FlxSprite = new FlxSprite();

	var level_json:LevelData;

	var difficulty:FlxText = new FlxText(0, 0, 0, "", 32);

	var CURRENT_SELECTION:Int = 0;

	override public function create()
	{
		#if !web
		var oglevels = FileManager.getTypeArray('level files', 'data/levels', ['.dream'], ['assets/data/levels/']);

		levels = [];
		for (level in oglevels)
		{
			var newlevel = level.replace('assets/data/levels/', '');

			levels.push(newlevel);
		}
		#end

		difficulty.y = FlxG.height - difficulty.height;
		add(difficulty);

		#if (discord_rpc && !hl)
		Discord.changePresence('In the menus', 'Looking for a Level to play');
		#end

		level_json = LevelDataManager.defaultJSON;

		level_sprite.loadGraphic(FileManager.getImageFile(level_json.assets.directory + 'background'));
		level_sprite.scale.set(1.25, 1.25);
		level_sprite.screenCenter();
		add(level_sprite);

		updateSelections();

		super.create();
	}

	var key_left:Bool;
	var key_right:Bool;
	var key_enter:Bool;

	override public function update(elapsed:Float)
	{
		key_left = FlxG.keys.justReleased.LEFT;
		key_right = FlxG.keys.justReleased.RIGHT;
		key_enter = FlxG.keys.justReleased.ENTER;

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
		else if (key_enter)
		{
			Global.playSound('select');
			PlayState.CURRENT_LEVEL = levels[CURRENT_SELECTION];
			FlxG.switchState(() -> new PlayState(level_json));
		}
		else if (FlxG.keys.justReleased.ESCAPE)
		{
			Global.playSound('select');
			FlxG.switchState(MenuState.new);
		}
		super.update(elapsed);
	}

	function updateSelections()
	{
		difficulty.size = 32;
		try
		{
			var filepath:String = (!levels[CURRENT_SELECTION].contains('levels/')) ? 'levels/' : '';
			filepath += levels[CURRENT_SELECTION];
			filepath += (!levels[CURRENT_SELECTION].endsWith('.dream')) ? '.dream' : '';

			var filename:String = (!filepath.contains('data/levels/')) ? FileManager.getDataFile(filepath) : filepath;
			FlxG.log.add(filename);
			level_json = Json.parse(FileManager.readFile(filename));
			difficulty.text = level_json.name + ' - ' + level_json.difficulty;
			level_sprite.loadGraphic(FileManager.getImageFile(level_json.assets.directory + 'background'));
		}
		catch (e)
		{
			FlxG.log.warn(e);
			#if web
			difficulty.text = levels[CURRENT_SELECTION].split('.dream')[0] + ' - ' + level_diffs[CURRENT_SELECTION];
			#else
			difficulty.size = Std.int(difficulty.size / 2);
			difficulty.text = "parsing error: " + e;
			#end
			level_json = LevelDataManager.defaultJSON;
			level_sprite.loadGraphic(FileManager.getImageFile(level_json.assets.directory + 'background'));
		}
		difficulty.screenCenter(X);
	}
}
