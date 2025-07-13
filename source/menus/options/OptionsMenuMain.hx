package menus.options;

import base.TextSelecting;
import flixel.util.typeLimit.NextState;

class OptionsMenuMain extends TextSelecting
{
	public static var instance:OptionsMenuMain;

	public var optionMenuDestinations:Map<String, NextState> = [];

	public function newOptionMenu(name:String, destination:NextState)
	{
		texts.push(name);
		optionMenuDestinations.set(name, destination);
	}

	override public function new()
	{
		super();

		texts = [];
		#if !ANDROID_BUILD
		newOptionMenu('Controls Menu', () -> new ControlsMenu());
		#end
		newOptionMenu('Preferences Menu', () -> new PreferencesMenu());
	}

	override function create()
	{
		instance = this;

		super.create();
	}

	override function backKey()
	{
		instance = null;
		FlxG.switchState(MenuState.new);
	}

	override function enterKey()
	{
		instance = null;
		FlxG.switchState(optionMenuDestinations.get(texts[CURRENT_SELECTION]));
	}
}
