package;

import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;

class LevelSelect extends FlxState
{
	var levels:Array<String> = ['heaven', 'earth', 'hell'];
	var level_texts:FlxTypedGroup<FlxText> = new FlxTypedGroup<FlxText>();

	override public function create()
	{
		add(level_texts);

		var int:Int = 0;
		for (level in levels)
		{
			var new_text:FlxText = new FlxText(0, 0 + (36 * int), 0, level, 32);
			level_texts.add(new_text);

			int++;
		}

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}