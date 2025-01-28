package menus;

import data.LevelData;

class LevelSelect extends FlxState
{
	var levels:Array<String> = ['earth', 'heaven', 'hell'];
	var level_diffs:Array<String> = ['easy-ish', 'medium', 'hard'];
	var level_sprite:FlxSprite = new FlxSprite();

	var level_json:LevelData;

	var difficulty:FlxText = new FlxText(0, 0, 0, "", 32);
    
	var CURRENT_SELECTION:Int = 0;

	override public function create()
	{
		#if !web
		levels = FileManager.readDirectory('assets/data/levels');
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
				CURRENT_SELECTION = 0;
			updateSelections();
		}
		else if (key_right)
		{
			CURRENT_SELECTION++;
			if (CURRENT_SELECTION > levels.length - 1)
				CURRENT_SELECTION--;
			updateSelections();
		}
		else if (key_enter)
		{
			PlayState.CURRENT_LEVEL = levels[CURRENT_SELECTION];
			FlxG.switchState(new PlayState());
		}
		else if (FlxG.keys.justReleased.ESCAPE)
		{
			FlxG.switchState(new MenuState());
		}
		super.update(elapsed);
	}

	function updateSelections()
	{
		try
		{
			var filename:String = FileManager.getDataFile('levels/${levels[CURRENT_SELECTION]}${(!levels[CURRENT_SELECTION].endsWith('.json')) ? '.json' : ''}');
			// trace(filename);
			level_json = Json.parse(FileManager.readFile(filename));
			difficulty.text = levels[CURRENT_SELECTION].split('.json')[0] + ' - ' + level_json.difficulty;
			level_sprite.loadGraphic(FileManager.getImageFile(level_json.assets.directory + 'background'));
		}
		catch (e)
		{
			// trace(e);
			#if web
			difficulty.text = levels[CURRENT_SELECTION].split('.json')[0] + ' - ' + level_diffs[CURRENT_SELECTION];
			#else
			difficulty.text = "unknown difficulty: " + e;
			#end
			level_json = LevelDataManager.defaultJSON;
			level_sprite.loadGraphic(FileManager.getImageFile(level_json.assets.directory + 'background'));
		}
		difficulty.screenCenter(X);
	}
}
