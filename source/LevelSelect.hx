package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class LevelSelect extends FlxState
{
	var levels:Array<String> = ['heaven', 'earth', 'hell'];
	var level_texts:FlxTypedGroup<FlxText> = new FlxTypedGroup<FlxText>();

	var CURRENT_SELECTION:Int = 0;

	override public function create()
	{
		levels = FileManager.readDirectory('assets/data/levels');

		add(level_texts);

		var int:Int = 0;
		for (level in levels)
		{
			var new_text:FlxText = new FlxText(0, 0 + (36 * int), 0, level, 32);
			new_text.ID = int;
			level_texts.add(new_text);

			int++;
		}

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
        
		for (text in level_texts)
        {
            text.x = (CURRENT_SELECTION == text.ID) ? 8 : 0;
            text.color = (CURRENT_SELECTION == text.ID) ? FlxColor.LIME : FlxColor.WHITE;
            text.alpha = (CURRENT_SELECTION == text.ID) ? 1 : 0.75;
        }

		super.update(elapsed);
	}
}
