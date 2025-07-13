package mobile;

class MobileButton extends FlxSprite
{
	override public function new(btnInt:ButtonEnum)
	{
		super();

		loadGraphic(FileManager.getImageFile('buttons', MOBILE), true, 32, 32);
		scrollFactor.set(0, 0);

		animation.add('btn', [0, 1, 2, 3, 4, 5], 0);
		animation.frameIndex = 0;

		switch (btnInt)
		{
			case A_BUTTON:
				animation.frameIndex = 0;
			case B_BUTTON:
				animation.frameIndex = 1;
			case X_BUTTON:
				animation.frameIndex = 6;
			case Y_BUTTON:
				animation.frameIndex = 7;

			case UP_BUTTON:
				animation.frameIndex = 2;
			case LEFT_BUTTON:
				animation.frameIndex = 3;
			case DOWN_BUTTON:
				animation.frameIndex = 4;
			case RIGHT_BUTTON:
				animation.frameIndex = 5;
		}

		scale.set(2, 2);

		y = FlxG.height - height * 2;
	}

	public var pressed:Bool = false;
	public var released:Bool = false;

	public var justPressed:Bool = false;
	public var justReleased:Bool = false;

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		pressed = false;
		released = false;

		justPressed = false;
		justReleased = false;

		if (FlxG.mouse.overlaps(this) && FlxG.mouse.justPressed)
			justPressed = true;
		if (FlxG.mouse.overlaps(this) && FlxG.mouse.pressed)
			pressed = true;
		if (FlxG.mouse.overlaps(this) && FlxG.mouse.justReleased)
			justReleased = true;
		if (FlxG.mouse.overlaps(this) && FlxG.mouse.released)
			released = true;
	}
}

enum ButtonEnum
{
	A_BUTTON;
	B_BUTTON;
	X_BUTTON;
	Y_BUTTON;

	UP_BUTTON;
	LEFT_BUTTON;
	DOWN_BUTTON;
	RIGHT_BUTTON;
}
