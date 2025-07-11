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
	}
}
