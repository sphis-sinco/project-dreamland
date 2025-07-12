package gameplay.results;

class Screen extends FlxSprite
{
	override public function new(pulse:Bool = false, highscore:Bool = false)
	{
		super();

		var path = 'screens${pulse ? '-pulse' : ''}';
		if (highscore)
			path = 'highScore';

		loadGraphic(FileManager.getImageFile('results/$path'), (pulse || highscore), 160, 140);

		if (pulse)
		{
			if (highscore)
				return;

			animation.add('pulse', [0, 1, 2, 3, 4, 5, 6], 12);
			animation.play('pulse');
		}

		if (highscore)
		{
			animation.add('HIGHSCORE', [0, 1], 6);
			animation.play('HIGHSCORE');
		}

		scale.set(4, 4);
	}
}
