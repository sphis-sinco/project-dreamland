package menus;

import base.TextSelecting;
import shaders.AdjustColorShader;

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
		var i = 0;
		for (entry in creditsJSON)
		{
			final email = creditsJSON[i].email;
			final url = creditsJSON[i].url;

			final openUrl = url != null;
			final openEmail = email != null;

			var urlEmailText = 'no email or url';

			if (openEmail && !openUrl)
				urlEmailText = 'email, no url';
			if (!openEmail && openUrl)
				urlEmailText = 'url, no email';
			if (openEmail && openUrl)
				urlEmailText = 'email and url';

			final name = entry.name;
			final role = entry.role != null ? ' (${entry.role})' : '';
			final urlemail = ' (' + urlEmailText + ')';

			texts.push('$name$role$urlemail');
			i++;
		}

		enterKey = function()
		{
			final email = creditsJSON[CURRENT_SELECTION].email;
			final url = creditsJSON[CURRENT_SELECTION].url;

			final openUrl = url != null;
			final openEmail = email != null;

			final openUrlFunc = function()
			{
				Global.goToUrl(url);
			}

			final openEmailFunc = function()
			{
				Global.goToUrl('mailto:$email');
			}

			if (!openEmail && openUrl)
				openUrlFunc();
			else if (!openUrl && openEmail)
				openEmailFunc();
			else if (openEmail && openUrl)
			{
				if (FlxG.keys.pressed.SHIFT || emailBtn.pressed)
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
	{super.create();

		#if !MOBILE_BUILD
		for (text in text_group)
			text.size = 16;
		#end

		instructionText.text = #if MOBILE_BUILD 'UP' #else '(${Controls.getKey('gameplay_move_up')}/${Controls.getKey('gameplay_move_up_alt')})' #end
		+ #if MOBILE_BUILD '/DOWN ' #else '/(${Controls.getKey('gameplay_move_down')}/${Controls.getKey('gameplay_move_down_alt')}) ' #end
		+ 'to navigate, '
		+ #if MOBILE_BUILD 'A' #else '${Controls.getKey('ui_select')}' #end
		+ ' to go to their url/email. '
		+ #if MOBILE_BUILD 'A' #else '${Controls.getKey('ui_select')}' #end
		+ ' + '
		+ #if MOBILE_BUILD 'X' #else 'SHIFT' #end
		+ ' to go to the email if both are availible';
		instructionText.size = 16;
		instructionText.scrollFactor.set(0, 0);
		add(instructionText);

		#if MOBILE_BUILD
		emailBtn.x = FlxG.width - interact.width * (MobileButton.scaleVal * 2);
		emailBtn.shader = emailBtn_shader;
		interact.y -= interact.height * MobileButton.scaleVal;
		leave.y -= leave.height * MobileButton.scaleVal;
		add(emailBtn);
		#end
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		emailBtn_shader.saturation = (creditsJSON[CURRENT_SELECTION].email != null
			&& creditsJSON[CURRENT_SELECTION].url != null) ? 0 : -50;
	}

	public var emailBtn:MobileButton = new MobileButton(X_BUTTON);
	public var emailBtn_shader:AdjustColorShader = new AdjustColorShader();
}
