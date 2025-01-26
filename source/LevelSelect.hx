package;

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

	override public function update(elapsed:Float)
	{
		for (text in level_texts)
        {
            text.x = (CURRENT_SELECTION == text.ID) ? 8 : 0;
            text.color = (CURRENT_SELECTION == text.ID) ? FlxColor.LIME : FlxColor.WHITE;
            text.alpha = (CURRENT_SELECTION == text.ID) ? 1 : 0.75;
        }

		super.update(elapsed);
	}
}
