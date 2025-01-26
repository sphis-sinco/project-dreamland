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
	var bullet_offscreen_addition:Float = 16;
	var bullets_max_onscreen:Float = 2;

	var enemies_group:FlxTypedGroup<FlxSprite> = new FlxTypedGroup<FlxSprite>();
	var enemy_offscreen_padding:Float = 40;

	override public function create()
	{
		add(bullets_group);

		player.makeGraphic(32,32, FlxColor.LIME); 
		player.screenCenter();
		add(player);

		add(enemies_group);

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
		if (key_shoot && bullets_group.members.length != bullets_max_onscreen)
		{
			var new_bullet:FlxSprite = new FlxSprite();
			new_bullet.makeGraphic(24, 24, FlxColor.YELLOW);
			new_bullet.setPosition(player.x, player.y);
			bullets_group.add(new_bullet);
		}

		for (bullet in bullets_group.members)
		{
			try
			{
				bullet.x += bullet.width;
				if (bullet.x > FlxG.width + bullet_offscreen_addition)
				{
					bullet.destroy();
					bullets_group.members.remove(bullet);
				}
			}
			catch (e) {}
		}

		if (FlxG.random.int(0, 20) == 10)
		{
			var new_enemy:FlxSprite = new FlxSprite();
			new_enemy.makeGraphic(40, 40, FlxColor.RED);
			new_enemy.setPosition(FlxG.width + new_enemy.width * 2, player.y + FlxG.random.float(-60, 60));
			if (new_enemy.y < 0 + enemy_offscreen_padding)
				new_enemy.y = 0 + enemy_offscreen_padding;
			if (new_enemy.y > FlxG.height - new_enemy.height - enemy_offscreen_padding)
				new_enemy.y = FlxG.height - new_enemy.height - enemy_offscreen_padding;

			enemies_group.add(new_enemy);
		}

		for (enemy in enemies_group.members)
		{
			try
			{
				enemy.x -= enemy.width / 6;
				if (enemy.x < 0 - enemy.width * 2)
				{
					enemy.destroy();
					enemies_group.members.remove(enemy);
				}
				for (bullet in bullets_group.members)
				{
					if (enemy.overlaps(bullet))
					{
						enemy.destroy();
						enemies_group.members.remove(enemy);
						bullet.destroy();
						bullets_group.members.remove(bullet);
					}
				}
			
			}
			catch (e) {}
		}

		super.update(elapsed);
	}
}
