package base;

import flixel.math.FlxMath;
import flixel.math.FlxPoint;

class TextSelecting extends FlxState
{
	public var texts:Array<String> = ['uno', 'dos', 'tres', 'cuatro'];
	public var text_group:FlxTypedGroup<FlxText> = new FlxTypedGroup<FlxText>();

	public var CURRENT_SELECTION(default, set):Int = 0;

	public var customCamEnabled:Bool = false;
	public var customCam:FlxObject;

	public var interact:MobileButton = new MobileButton(A_BUTTON);
	public var leave:MobileButton = new MobileButton(B_BUTTON);

	public var up:MobileButton = new MobileButton(UP_BUTTON);
	public var down:MobileButton = new MobileButton(DOWN_BUTTON);

	override public function create()
	{
		interact.x = FlxG.width - interact.width * 4;
		leave.x = FlxG.width - leave.width * 2;

		up.x = up.width * 2;
		up.y -= up.height * 2;
		down.x = up.width * 2;

		add(text_group);

		var int:Int = 0;
		for (text in texts)
		{
			var new_text:FlxText = new FlxText(0, 0 + (36 * int), 0, text, 32);
			new_text.ID = int;
			text_group.add(new_text);

			int++;
		}

		customCam = new FlxObject(0, 0, 1, 1);
		if (customCamEnabled)
		{
			add(customCam);
			FlxG.camera.follow(customCam, null, 0.05);
		}

		super.create();

		#if ANDROID_BUILD
		add(interact);
		add(leave);
		add(up);
		add(down);
		#end
	}

	public var key_up:Bool;
	public var key_down:Bool;
	public var key_enter:Bool;
	public var key_back:Bool;

	override public function update(elapsed:Float)
	{
		key_up = Controls.UI_MOVE_UP || up.justReleased;
		key_down = Controls.UI_MOVE_DOWN || down.justReleased;
		key_enter = Controls.UI_SELECT || interact.justReleased;
		key_back = Controls.UI_LEAVE || leave.justReleased;

		if (canPressKeys())
		{
			controls();
			// outOfBoundsCheck();
		}

		for (text in text_group)
		{
			text.x = (CURRENT_SELECTION == text.ID) ? 10 : 0;
			text.color = (CURRENT_SELECTION == text.ID) ? FlxColor.YELLOW : FlxColor.WHITE;
			text.alpha = (CURRENT_SELECTION == text.ID) ? 1.0 : 0.6;

			if (CURRENT_SELECTION == text.ID)
				customCam.setPosition(getCamPos(text).x, getCamPos(text).y);
		}

		super.update(elapsed);
	}

	public function getCamPos(text:FlxText)
	{
		return new FlxPoint(FlxG.width / 2, text.getGraphicMidpoint().y);
	}

	/*public function outOfBoundsCheck()
		{
			if (CURRENT_SELECTION < 0)
				CURRENT_SELECTION = 0;

			if (CURRENT_SELECTION > texts.length - 1)
				CURRENT_SELECTION--;
	}*/
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
		}
		else if (key_down)
		{
			CURRENT_SELECTION++;
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

	function set_CURRENT_SELECTION(val:Int):Int
	{
		return CURRENT_SELECTION = Std.int(FlxMath.bound(val, 0, texts.length - 1));
	}
}
