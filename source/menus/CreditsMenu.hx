package menus;

import base.TextSelecting;

typedef CreditsEntry =
{
	name:String,
	?role:String,
	?email:String,
	?url:String
}

class CreditsMenu extends TextSelecting
{
	public var creditsJSON:Array<CreditsEntry> = [];

	public var instructionText:FlxText = new FlxText(10, 10, FlxG.width);

	override public function new()
	{
		super();

		creditsJSON = FileManager.getJSON(FileManager.getDataFile('credits.json'));
		texts = [];
		for (entry in creditsJSON)
		{
			texts.push('${entry.name}${entry.role != null ? '(${entry.role})' : ''}');
		}

		enterKey = function()
		{
			final email = creditsJSON[CURRENT_SELECTION].email;
			final url = creditsJSON[CURRENT_SELECTION].url;

			final openUrl = url != null;
			final openEmail = email != null;

			final openUrlFunc = function()
			{
				#if linux
				Sys.command('/usr/bin/xdg-open', [url, "&"]);
				#else
				FlxG.openURL(url);
				#end
			}

			final openEmailFunc = function()
			{
				#if linux
				Sys.command('/usr/bin/xdg-open', ['mailto:$email', "&"]);
				#else
				FlxG.openURL('mailto:$email');
				#end
			}

			if (!openEmail && openUrl)
				openUrlFunc();
			else if (!openUrl && openEmail)
				openEmailFunc();
			else if (openEmail && openUrl)
			{
				if (FlxG.keys.pressed.SHIFT)
					openEmailFunc();
				else
					openUrlFunc();
			}
		}

		backKey = function()
		{
			FlxG.switchState(MenuState.new);
		}

		customCamEnabled = true;
	}

	override function create()
	{
		super.create();

		for (text in text_group)
			text.size = 16;

		instructionText.text = '(${Controls.getKey('gameplay_move_up')}/${Controls.getKey('gameplay_move_up_alt')})'
			+ '/(${Controls.getKey('gameplay_move_down')}/${Controls.getKey('gameplay_move_down_alt')}) '
			+ 'to navigate, '
			+ '${Controls.getKey('ui_select')}'
			+ ' to go to their url/email. ${Controls.getKey('ui_select')} + SHIFT to go to the email if both are availible';
		instructionText.size = 16;
		instructionText.scrollFactor.set(0, 0);
		add(instructionText);
	}
}
