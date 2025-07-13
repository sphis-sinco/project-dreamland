package gameplay;

import flixel.math.FlxMath;
import flixel.sound.FlxSound;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import gameplay.results.Screen;

class ResultsSubState extends FlxSubState
{
	public static var instance:ResultsSubState = null;

	public var screen:Screen;
	public var screen_pulse:Screen;
	public var HIGHSCORE:Screen;

	public var backdrop:FlxSprite;
	public var player:FlxSprite;

	public var scoreText:FlxText = new FlxText(0, 0, new Screen().width * 4, 'score: 0', 32);
	public var score:Int = 0;

	public var TransitionComplete:Bool = false;

	public var blip:FlxSound = new FlxSound().loadEmbedded(FileManager.getSoundFile('sounds/blip-results'));
	public var blip_finished:FlxSound = new FlxSound().loadEmbedded(FileManager.getSoundFile('sounds/blip-results-finished'));

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

		var resultsAssetName = null;
		var resultsFrameArray = PlayState.player_json.resultsFrameArrays.good;

		trace(PlayState.SCORE < Save.getSavedataInfo(highscore) / 2);
		Global.set_HIGHSCORE();
		trace(Save.getSavedataInfo(highscore) / 2);
		trace(PlayState.SCORE);

		if (PlayState.HIGHSCORE)
		{
			trace('new highscore anim');

			resultsAssetName = PlayState.player_json.resultsAssetNames.new_highscore;
			resultsFrameArray = PlayState.player_json.resultsFrameArrays.new_highscore;
		}
		else if (PlayState.SCORE < Save.getSavedataInfo(highscore) / 2)
		{
			trace('Bad anim');

			resultsAssetName = PlayState.player_json.resultsAssetNames.bad;
			resultsFrameArray = PlayState.player_json.resultsFrameArrays.bad;
		}
		else
		{
			trace('Good anim');

			resultsAssetName = PlayState.player_json.resultsAssetNames.good;
			resultsFrameArray = PlayState.player_json.resultsFrameArrays.good;
		}

		resultsAssetName ??= 'player';
		resultsFrameArray ??= [0, 1, 2, 3, 4, 5];

		player.loadGraphic(FileManager.getImageFile('results/player/$resultsAssetName'), true, 160, 140);
		player.animation.add('anim', resultsFrameArray, 24, false);
		player.animation.add('loop', [resultsFrameArray[resultsFrameArray.length]], 24, true);
		player.visible = false;
		player.scale.set(4, 4);
		add(player);

		screen = new Screen(false);
		screen.screenCenter();

		screen_pulse = new Screen(true);
		screen_pulse.screenCenter();

		var screenX = screen.x;
		screen.x = -(screen.width * 4);

		add(screen);

		FlxTween.tween(screen, {x: screenX}, 1.0, {
			ease: FlxEase.smoothStepInOut,
			onComplete: tween ->
			{
				TransitionComplete = true;

				screen_pulse.visible = true;

				scoreText.visible = true;
				scoreLerpVal = 0.001;

				if (PlayState.SCORE == 0)
				{
					lerpComplete = true;
					lerpCompleteFlash();
				}
				else
				{
					player.animation.play('anim');
					player.visible = true;
				}
			}
		});

		scoreText.setPosition(80, 420);
		scoreText.visible = false;
		add(scoreText);

		screen_pulse.visible = false;
		screen_pulse.alpha = 0.5;
		// add(screen_pulse);

		HIGHSCORE = new Screen(false, true);
		HIGHSCORE.visible = false;
		HIGHSCORE.scale.set(3.75, 3.75);
		add(HIGHSCORE);
	}

	override function create()
	{
		super.create();
	}

	public var scoreLerpVal:Float = 0.0;
	public var lerpComplete:Bool = false;

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		screen_pulse.screenCenter();
		HIGHSCORE.screenCenter();
		player.screenCenter();
		scoreText.text = 'score: ${FlxStringUtil.formatMoney(score)}';

		if (player.animation.finished && player.animation.name == 'anim')
			player.animation.play('loop');

		if (TransitionComplete && score != PlayState.SCORE && !lerpComplete)
		{
			var prevScore = score;
			score = Std.int(FlxMath.lerp(score, PlayState.SCORE, scoreLerpVal));

			scoreLerpVal = scoreLerpVal * 1.05;
			scoreLerpVal = FlxMath.bound(scoreLerpVal, scoreLerpVal, 1.0);

			lerpComplete = score == PlayState.SCORE;

			if (lerpComplete)
				lerpCompleteFlash();

			if (score != prevScore)
			{
				if (!lerpComplete)
					blip.play(true);
				if (lerpComplete)
					blip_finished.play(true);
			}
		}

		if (Controls.UI_SELECT && lerpComplete)
		{
			FlxG.switchState(LevelSelect.new);
		}
	}

	public function lerpCompleteFlash()
	{
		scoreText.color = FlxColor.YELLOW;
		FlxTween.color(scoreText, 1, scoreText.color, FlxColor.WHITE);

		if (PlayState.HIGHSCORE)
		{
			HIGHSCORE.visible = true;
			FlxTween.tween(HIGHSCORE, {
				'scale.x': 4,
				'scale.y': 4,
			}, .25, {
				ease: FlxEase.bounceInOut
			});
		}
	}
}
