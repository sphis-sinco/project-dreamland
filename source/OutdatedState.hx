package;

class OutdatedState extends FlxState
{
	public var openURL:MobileButton = new MobileButton(A_BUTTON);
	public var closeState:MobileButton = new MobileButton(B_BUTTON);

	override public function create()
	{
		var outdatedText:FlxText = new FlxText(0, 0, 0, "blah", 16);
		add(outdatedText);

		outdatedText.text = 'YOUR BUILD OF THE GAME (v${Global.APP_VERSION}) IS OUTDATED!\n'
			+ 'THE CURRENT PUBLIC RELEASE IS v${CheckOutdated.updateVersion},\n AND IS AVAILIABLE FOR DOWNLOAD.\n\n'
			+ 'You can '
			+ #if ANDROID_BUILD 'press A' #else 'press ${Controls.getKey('ui_select')}' #end
			+ ' to go to the github to update.\n'
			+ 'or you can '
			+ #if ANDROID_BUILD 'press B' #else 'press ${Controls.getKey('ui_select')}' #end
			+ ' to continue.';

		#if html5
		outdatedText.text = 'Right now, the full-game (v1.0+) is/will be coming out.'
			+ '\nIt has/will have several features that this build wont\'t ever.'
			+ '\nSo if you want those features. Download the desktop release.'
			+ '\nYou can press ${Controls.getKey('ui_select')} to go to the github to update.'
			+ '\nor you can press ${Controls.getKey('ui_leave')} to continue.'
			+ '\n\nIt is your choice.';
		outdatedText.size = 8;
		#end

		outdatedText.text = outdatedText.text.toUpperCase();
		outdatedText.alignment = CENTER;
		outdatedText.screenCenter();

		#if (discord_rpc && !hl)
		Discord.changePresence('Playing an outdated Version (v${Global.APP_VERSION})', 'Needs to update to v${CheckOutdated.updateVersion}');
		#end

		#if ANDROID_BUILD
		openURL.screenCenter(X);
		closeState.screenCenter(X);

		openURL.x -= openURL.width * 2;
		closeState.x += closeState.width * 2;

		add(openURL);
		add(closeState);
		#end

		super.create();
	}

	override public function update(elapsed:Float)
	{
		if (Controls.UI_SELECT || openURL.justReleased)
		{
			Global.goToUrl('https://github.com/sphis-Sinco/project-dreamland/releases/latest');
			#if sys
			Sys.exit(0);
			#end
		}
		else if (Controls.UI_LEAVE || closeState.justReleased)
		{
			FlxG.switchState(MenuState.new);
		}

		super.update(elapsed);
	}
}
