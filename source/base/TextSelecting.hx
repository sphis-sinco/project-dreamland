package base;

class TextSelecting extends FlxState
{
	var texts:Array<String> = ['uno', 'dos', 'tres', 'cuatro'];
	var text_group:FlxTypedGroup<FlxText> = new FlxTypedGroup<FlxText>();

	var CURRENT_SELECTION:Int = 0;

	override public function create()
	{
		add(text_group);

		var int:Int = 0;
		for (text in texts)
		{
			var new_text:FlxText = new FlxText(0, 0 + (36 * int), 0, text, 32);
			new_text.ID = int;
			text_group.add(new_text);

			int++;
		}

		super.create();
	}

	var key_up:Bool;
	var key_down:Bool;
	var key_enter:Bool;
	var key_back:Bool;

	override public function update(elapsed:Float)
	{
		key_up = FlxG.keys.justReleased.UP;
		key_down = FlxG.keys.justReleased.DOWN;
		key_enter = FlxG.keys.justReleased.ENTER;
		key_back = FlxG.keys.justReleased.ESCAPE;

		if (canPressKeys())
		{
			controls();
		}

		for (text in text_group)
		{
			text.x = (CURRENT_SELECTION == text.ID) ? 10 : 0;
			text.color = (CURRENT_SELECTION == text.ID) ? FlxColor.YELLOW : FlxColor.WHITE;
			text.alpha = (CURRENT_SELECTION == text.ID) ? 1.0 : 0.6;
		}

		super.update(elapsed);
	}

	public dynamic function backKey() {}

	public dynamic function enterKey() {}

	public dynamic function canPressKeys():Bool
	{
		return true;
	}

	public function controls()
	{
		if (key_up)
		{
			CURRENT_SELECTION--;
			if (CURRENT_SELECTION < 0)
				CURRENT_SELECTION = 0;
		}
		else if (key_down)
		{
			CURRENT_SELECTION++;
			if (CURRENT_SELECTION > texts.length - 1)
				CURRENT_SELECTION--;
		}
		else if (key_enter)
		{
			enterKey();
		}
		else if (key_back)
		{
			backKey();
		}
	}
}
