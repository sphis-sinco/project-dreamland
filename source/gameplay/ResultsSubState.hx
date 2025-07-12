package gameplay;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import gameplay.results.Screen;

class ResultsSubState extends FlxSubState
{
	public static var instance:ResultsSubState = null;

	public var screen:Screen;
	public var backdrop:FlxSprite;
	public var player:FlxSprite;

	public var scoreText:FlxText = new FlxText(0, 0, new Screen().width * 4, 'score: 0', 16);

	public var TransitionComplete:Bool = false;

	override public function new()
	{
		super();

		if (instance != null)
			instance = null;
		instance = this;

		backdrop = new FlxSprite().loadGraphic(FileManager.getImageFile('menus/Yellowpopup'));
		backdrop.scale.set(2, 2);
		backdrop.screenCenter();

		var backdropY = backdrop.y;

		add(backdrop);

		backdrop.y = -(backdrop.height * 2);
		FlxTween.tween(backdrop, {y: backdropY}, 1.0, {
			ease: FlxEase.smoothStepInOut
		});

		player = new FlxSprite();
		player.loadGraphic(FileManager.getImageFile('results/player/${PlayState.player_json.resultsAssetName ?? 'player'}'), true, 160, 140);
		player.animation.add('anim', PlayState.player_json.resultsFrameArray ?? [0, 1, 2, 3, 4, 5], 24, false);
		player.visible = false;
		player.scale.set(4, 4);
		add(player);

		screen = new Screen();
		screen.screenCenter();

		var screenX = screen.x;
		screen.x = -(screen.width * 4);

		add(screen);

		FlxTween.tween(screen, {x: screenX}, 1.0, {
			ease: FlxEase.smoothStepInOut,
			onComplete: tween ->
			{
				TransitionComplete = true;
				player.setPosition(screenX, screen.y);
				player.animation.play('anim');
				player.visible = true;
			}
		});

		scoreText.setPosition(80, 420);
		add(scoreText);
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
