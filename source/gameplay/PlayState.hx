package gameplay;

import data.LevelData.LevelData;
import data.LevelData.LevelDataManager;
import data.PlayerData;
import scripts.play.events.SetupPlayer;

class PlayState extends FlxState
{
	public static var CURRENT_LEVEL:String = 'earth';

	public static var HIGHSCORE:Bool = false;
	public static var SCORE:Int = 0;

	public static var instance:PlayState = null;

	public var score_text:FlxText = new FlxText(0, 0, 0, "Score: 0", 16);

	public var player:FlxSprite = new FlxSprite();
	public var player_offscreen_padding:Float = 16;

	public var bullets_group:FlxTypedGroup<FlxSprite> = new FlxTypedGroup<FlxSprite>();
	public var bullet_offscreen_addition:Float = 16;
	public var bullets_max_onscreen:Null<Int> = 2; // Why was this a float

	public var enemies_group:FlxTypedGroup<FlxSprite> = new FlxTypedGroup<FlxSprite>();
	public var enemy_offscreen_padding:Float = 40;

	public static var level_data:LevelData = null;

	override public function new(levelData:LevelData)
	{
		super();

		var new_leveldata = levelData ?? LevelDataManager.defaultJSON;

		if (new_leveldata == null)
			new_leveldata = LevelDataManager.defaultJSON;

		level_data = new_leveldata;

		HIGHSCORE = false;
	}

	public var interact:MobileButton = new MobileButton(A_BUTTON);

	public var up:MobileButton = new MobileButton(UP_BUTTON);
	public var down:MobileButton = new MobileButton(DOWN_BUTTON);

	override public function create()
	{
		interact.x = FlxG.width - interact.width * (MobileButton.scaleVal * 2);

		up.x = up.width * MobileButton.scaleVal;
		up.y -= up.height * MobileButton.scaleVal;
		down.x = down.width * MobileButton.scaleVal;

		if (instance != null)
		{
			trace('WARNING: PlayState instance already exists. This should not happen. Set it back to null.');
			instance = null;
		}
		instance = this;

		// trace(level_data);
		var bmos = level_data.settings.ammo ?? 2;
		bullets_max_onscreen = bmos;

		var player_json_path = FileManager.getDataFile('players/${level_data.assets.player ?? 'player'}.json');
		player_json = FileManager.getJSON(player_json_path);

		#if DISCORDRPC
		Discord.changePresence('In the level ${CURRENT_LEVEL.split('.json')[0]} by ${level_data.author}', 'Blasting Creatures');
		#end

		var bg:FlxSprite = new FlxSprite();
		add(bg);
		TryCatch.tryCatch(() ->
		{
			bg.loadGraphic(FileManager.getImageFile(level_data.assets.directory + "background"));
		}, {
				errFunc: d ->
				{
					bg.loadGraphic(FileManager.getImageFile('background'));
				}
		});
		#if MOBILE_BUILD
		bg.scale.set(4, 4);
		#else
		bg.scale.set(2, 2);
		#end
		bg.screenCenter();
		bg.color = 0xcccccc;

		add(bullets_group);

		playerSetup(); // this is the fallback
		SetupPlayer.call(player_json);

		if (player == null)
			playerSetup();

		add(player);

		add(enemies_group);

		score_text.screenCenter(X);
		score_text.y = 16;
		add(score_text);

		SCORE = 0;

		if (Save.getSavedataInfo(firsttime))
		{
			spacebar = new FlxSprite().loadGraphic(FileManager.getImageFile('tutorial/spacebar'), true, 48, 16);
			spacebar.animation.add('idle', [0, 1], 2);
			spacebar.animation.play('idle');
			spacebar.scale.set(5, 5);
			spacebar.screenCenter();
			add(spacebar);

			spacebartext = new FlxText();
			spacebartext.setPosition(spacebar.x, spacebar.y);
			spacebartext.text = 'PRESS ${Controls.getKey('gameplay_shoot')} TO SHOOT!';
			#if MOBILE_BUILD
			spacebartext.text = 'PRESS A TO SHOOT!';
			#end
			spacebartext.size = 32;
			spacebartext.screenCenter(X);
			spacebartext.y += spacebar.width * 1.1;
			add(spacebartext);
		}

		super.create();

		#if MOBILE_BUILD
		add(interact);
		add(up);
		add(down);
		#end
	}

	public var spacebar:FlxSprite;
	public var spacebartext:FlxText;

	public static var player_json:PlayerData = null;

	function playerSetup()
	{
		player.loadGraphic(FileManager.getImageFile(player_json.path ?? 'player'), true, player_json.dimensions[0] ?? 32,
			player_json.dimensions[1] ?? 32);

		var i = 0;
		for (animation in player_json.animations)
		{
			i++;
			player.animation.add(animation.name ?? 'animation$i', animation.frames ?? [0], animation.fps ?? 30, animation.looping ?? false);
		}

		player.animation.play(player_json.default_animation ?? player.animation.getNameList()[0]);

		player.scale.set(player_json.scale[0] ?? 1, player_json.scale[1] ?? 1);
		player.screenCenter();
		player.x -= player.width * 8;
	}

	public var key_up:Bool;
	public var key_down:Bool;
	public var key_shoot:Bool;

	override public function update(elapsed:Float)
	{
		score_text.text = "Score: " + SCORE;

		key_up = Controls.GAMEPLAY_MOVE_UP || up.pressed;
		key_down = Controls.GAMEPLAY_MOVE_DOWN || down.pressed;
		key_shoot = Controls.GAMEPLAY_SHOOT || interact.justReleased;

		inputCheck();

		bulletMovement();

		if (FlxG.random.int(0, 20) == 10)
		{
			var new_enemy:FlxSprite = newEnemy();
			onNewEnemy(new_enemy);
			enemies_group.add(new_enemy);
		}

		enemyMovement();

		if (player.animation.finished)
			player.animation.play('idle');

		super.update(elapsed);
	}

	function inputCheck()
	{
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
			Global.playSound('shoot' + FlxG.random.int(1, 3));

			var new_bullet:FlxSprite = newBullet();
			onNewBullet(new_bullet);
			player.animation.play('shoot-a${bullets_max_onscreen - bullets_group.members.length}');
			bullets_group.add(new_bullet);

			if (Save.getSavedataInfo(firsttime))
			{
				Save.setSavedataInfo(firsttime, false);
				spacebar.destroy();
				spacebartext.destroy();
			}
		}
		else if (bullets_group.members.length == bullets_max_onscreen)
		{
			player.animation.play('shoot-a0');
		}
	}

	function bulletMovement()
	{
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
	}

	function enemyMovement()
	{
		for (enemy in enemies_group.members)
		{
			try
			{
				var additionalSpeed:Float = 0;

				try
				{
					switch (enemy.ID)
					{
						case 0:
							additionalSpeed += level_data.settings.speed_additions.enemy_common;
						case 1:
							additionalSpeed += level_data.settings.speed_additions.enemy_easy;
						case 2:
							additionalSpeed += level_data.settings.speed_additions.enemy_rare;
					}
				}
				catch (e)
				{
					additionalSpeed = 0;
				}
				enemy.x -= enemy.width / 6 + additionalSpeed;

				if (enemy.x < 0 - enemy.width * 2)
				{
					enemy.destroy();
					enemies_group.members.remove(enemy);
				}
				enemyBeingShotCheck(enemy);
				if (enemy.overlaps(player))
				{
					FlxG.switchState(GameOver.new);
					instance = null;
				}
			}
			catch (e)
			{
				trace(e);
			}
		}
	}

	function enemyBeingShotCheck(enemy:FlxSprite)
	{
		for (bullet in bullets_group.members)
		{
			if (enemy.overlaps(bullet))
			{
				switch (enemy.ID)
				{
					case 0:
						SCORE += level_data.settings.scores.enemy_common;
					case 1:
						SCORE += level_data.settings.scores.enemy_easy;
					case 2:
						SCORE += level_data.settings.scores.enemy_rare;
				}

				if (Global.HIGHSCORE < SCORE && score_text.color != FlxColor.LIME)
				{
					HIGHSCORE = true;

					score_text.color = FlxColor.LIME;
					Global.playSound('blip');
				}

				#if MOBILE_BUILD
				// if vibrator
				lime.ui.Haptic.vibrate(100, 10);
				#end

				Global.playSound('explosion' + FlxG.random.int(1, 3));
				enemy.destroy();
				enemies_group.members.remove(enemy);
				bullet.destroy();
				bullets_group.members.remove(bullet);
			}
		}
	}

	function newBullet():FlxSprite
	{
		var new_bullet:FlxSprite = new FlxSprite();
		new_bullet.makeGraphic(player_json.bullet.size[0] ?? 24, player_json.bullet.size[1] ?? 24,
			FlxColor.fromRGB(player_json.bullet.color[0] ?? 255, player_json.bullet.color[1] ?? 255, player_json.bullet.color[2] ?? 0,
				player_json.bullet.color[3] ?? 255));
		new_bullet.setPosition(player.x, player.y);

		return new_bullet;
	}

	function newEnemy():FlxSprite
	{
		var new_enemy:FlxSprite = new FlxSprite();
		var texturepath = FileManager.getImageFile(level_data.assets.directory + level_data.assets.enemy_common);
		new_enemy.ID = 0;

		if (FlxG.random.bool(level_data.settings.chances.enemy_rare))
		{
			texturepath = FileManager.getImageFile(level_data.assets.directory + level_data.assets.enemy_rare);
			new_enemy.ID = 2;
		}
		else if (FlxG.random.bool(level_data.settings.chances.enemy_easy))
		{
			texturepath = FileManager.getImageFile(level_data.assets.directory + level_data.assets.enemy_easy);
			new_enemy.ID = 1;
		}

		new_enemy.loadGraphic(texturepath);

		new_enemy.setPosition(FlxG.width + new_enemy.width * 2, player.y + FlxG.random.float(-60, 60));
		if (new_enemy.y < 0 + enemy_offscreen_padding)
			new_enemy.y = 0 + enemy_offscreen_padding;
		if (new_enemy.y > FlxG.height - new_enemy.height - enemy_offscreen_padding)
			new_enemy.y = FlxG.height - new_enemy.height - enemy_offscreen_padding;

		return new_enemy;
	}

	public dynamic function onNewEnemy(enemy:FlxSprite) {}

	public dynamic function onNewBullet(bullet:FlxSprite) {}
}
