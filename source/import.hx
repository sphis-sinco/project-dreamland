import Global;
import flixel.*;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.*;
import gameplay.*;
import haxe.*;
import lime.app.Application;
import menus.*;
import mobile.MobileButton;
import modding.*;
import save.Save;
import scripts.*;
import scripts.events.*;

using StringTools;

#if (discord_rpc && !hl)
import clients.DiscordClient as Discord;
#end
