package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	var player:FlxSprite = new FlxSprite();
	var player_offscreen_padding:Float = 16;

	var bullets_group:FlxTypedGroup<FlxSprite> = new FlxTypedGroup<FlxSprite>();

	override public function create()
	{
		add(bullets_group);

		player.makeGraphic(32,32, FlxColor.LIME); 
		player.screenCenter();
		add(player);

		super.create();
	}

	var key_up:Bool;
	var key_down:Bool;
	var key_shoot:Bool;

	override public function update(elapsed:Float)
	{
		key_up = FlxG.keys.pressed.UP;
		key_down = FlxG.keys.pressed.DOWN;
		key_shoot = FlxG.keys.justReleased.SPACE;

		if (key_up)
		{
			player.y -= 10;
			if (player.y < 0 + player_offscreen_padding)
				player.y = 0 + player_offscreen_padding;
		}
		if (key_down)
		{
			player.y += 10;
			if (player.y > FlxG.height - player.height - player_offscreen_padding)
				player.y = FlxG.height - player.height - player_offscreen_padding;
		}
		if (key_shoot && bullets_group.members.length != 2)
		{
			var new_bullet:FlxSprite = new FlxSprite();
			new_bullet.makeGraphic(24, 24, FlxColor.YELLOW);
			new_bullet.setPosition(player.x, player.y);
			bullets_group.add(new_bullet);
		}

		for (bullet in bullets_group.members)
		{
			bullet.x += bullet.width;
			if (bullet.x > FlxG.width + player_offscreen_padding)
				bullets_group.remove(bullet);
		}

		super.update(elapsed);
	}
}
