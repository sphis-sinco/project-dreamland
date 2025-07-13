package mobile;

class MobileButton extends FlxSprite
{
	override public function new(btnInt:ButtonEnum)
	{
		super();

		loadGraphic(FileManager.getImageFile('mobile/buttons'), true, 32, 32);

		animation.add('btn', [0, 1, 2, 3, 4, 5], 0);
		animation.frameIndex = 0;

		switch (btnInt)
		{
			case A_BUTTON:
				animation.frameIndex = 0;
			case B_BUTTON:
				animation.frameIndex = 1;

			case UP_BUTTON:
				animation.frameIndex = 2;
			case LEFT_BUTTON:
				animation.frameIndex = 3;
			case DOWN_BUTTON:
				animation.frameIndex = 4;
			case RIGHT_BUTTON:
				animation.frameIndex = 5;
		}

		scale.set(4, 4);
	}
}

enum ButtonEnum
{
	A_BUTTON;
	B_BUTTON;

	UP_BUTTON;
	LEFT_BUTTON;
	DOWN_BUTTON;
	RIGHT_BUTTON;
}
