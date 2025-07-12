package gameplay.results;

class Screen extends FlxSprite
{
	override public function new(pulse:Bool = false)
	{
		super();

		loadGraphic(FileManager.getImageFile('results/screens${pulse ? '-pulse' : ''}'), pulse, 160, 140);

		if (pulse)
		{
			animation.add('pulse', [0, 1, 2, 3, 4, 5, 6], 12);
			animation.play('pulse');
		}

		scale.set(4, 4);
	}
}
