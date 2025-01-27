package;

class LevelSelect extends FlxState
{
	var levels:Array<String> = ['earth', 'heaven', 'hell'];
	var level_diffs:Array<String> = ['easy-ish', 'medium', 'hard'];
	var level_texts:FlxTypedGroup<FlxText> = new FlxTypedGroup<FlxText>();

	var level_json:LevelData;

	var difficulty:FlxText = new FlxText(0, 0, 0, "", 32);
    
	var CURRENT_SELECTION:Int = 0;

	override public function create()
	{
		#if !web
		levels = FileManager.readDirectory('assets/data/levels');
		#end

		add(level_texts);

		var int:Int = 0;
		for (level in levels)
		{
			var new_text:FlxText = new FlxText(0, 0 + (36 * int), 0, level.split('.')[0], 32);
			new_text.ID = int;
			level_texts.add(new_text);

			int++;
		}

		difficulty.y = FlxG.height - difficulty.height;
		add(difficulty);

		#if (discord_rpc && !hl)
		Discord.changePresence('In the menus', 'Looking for a Level to play');
		#end

		super.create();
	}

	var key_up:Bool;
	var key_down:Bool;
	var key_enter:Bool;

	override public function update(elapsed:Float)
	{
		key_up = FlxG.keys.justReleased.UP;
		key_down = FlxG.keys.justReleased.DOWN;
		key_enter = FlxG.keys.justReleased.ENTER;

		if (key_up)
		{
			CURRENT_SELECTION--;
			if (CURRENT_SELECTION < 0)
				CURRENT_SELECTION = 0;
		}
		else if (key_down)
		{
			CURRENT_SELECTION++;
			if (CURRENT_SELECTION > levels.length - 1)
				CURRENT_SELECTION--;
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
        
		for (text in level_texts)
        {
            text.x = (CURRENT_SELECTION == text.ID) ? 8 : 0;
            text.color = (CURRENT_SELECTION == text.ID) ? FlxColor.LIME : FlxColor.WHITE;
            text.alpha = (CURRENT_SELECTION == text.ID) ? 1 : 0.75;
        }

		try
		{
			var filename:String = FileManager.getDataFile('levels/${levels[CURRENT_SELECTION]}${(!levels[CURRENT_SELECTION].endsWith('.json')) ? '.json' : ''}');
			// trace(filename);
			level_json = Json.parse(FileManager.readFile(filename));
			difficulty.text = level_json.difficulty;
		}
		catch (e)
		{
			// trace(e);
			#if web
			difficulty.text = level_diffs[CURRENT_SELECTION];
			#else
			difficulty.text = "unknown difficulty: " + e;
			#end
		}
		super.update(elapsed);
	}
}
