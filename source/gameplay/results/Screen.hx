package gameplay.results;

class Screen extends FlxSprite
{
	override public function new()
	{
		super();

		loadGraphic(FileManager.getImageFile('results/screens'), true, 160, 140);
		animation.add('pulse', [0, 1, 2, 3, 4, 5, 6], 12);
		animation.play('pulse');

		scale.set(4, 4);
	}
}
