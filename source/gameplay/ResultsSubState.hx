package gameplay;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import gameplay.results.Screen;

class ResultsSubState extends FlxSubState
{
	var screen:Screen;
	var backdrop:FlxSprite;

	override public function new()
	{
		super();

		backdrop = new FlxSprite().loadGraphic(FileManager.getImageFile('menus/Yellowpopup'));
		backdrop.scale.set(2, 2);
		backdrop.screenCenter();

		var backdropY = backdrop.y;

		add(backdrop);

		backdrop.y = -(backdrop.height * 2);
		FlxTween.tween(backdrop, {y: backdropY}, 1.0, {
			ease: FlxEase.smoothStepInOut
		});

		screen = new Screen();
		screen.screenCenter();

		var screenX = screen.x;
		screen.x = -(screen.width * 4);

		add(screen);

		FlxTween.tween(screen, {x: screenX}, 1.0, {
			ease: FlxEase.smoothStepInOut
		});
	}

	override function create()
	{
		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
