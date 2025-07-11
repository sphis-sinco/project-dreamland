import haxe.Json;
import sys.FileSystem;
import sys.io.File;

typedef Library =
{
	var name:String;
	var type:String;
	var ?version:String;
	var ?dir:String;
	var ?ref:String;
	var ?url:String;
}

class Compiler
{
	static var appends:String = '';
	static var properCompile:Bool = false;

	static var availiblePlatforms:Array<String> = ['neko', 'hashlink', 'windows', 'mac', 'linux', 'html5'];

	public static function main():Void
	{
		Sys.command('cd ../../');
		if (haxe.macro.Compiler.getDefine('HMM_SKIP') == null)
			installLibraries();

		for (platform in availiblePlatforms)
		{
			if (getPlatform(platform))
				break;
		}

		#if debug appends += ' -debug'; #end

		appends += ' --times';

		if (!properCompile)
		{
			Sys.println('Missing compile platform...');
			Sys.println('Availible platforms:');
			for (platform in availiblePlatforms)
			{
				Sys.println(' * $platform');
			}
			Sys.exit(0);
		}
		else
			compile();
	}

	public static function compile():Void
	{
		Sys.command('lime test ' + appends);
		Sys.exit(0);
	}

	public static function installLibraries():Void
	{
		if (!FileSystem.exists('.haxelib'))
		{
			FileSystem.createDirectory('.haxelib');
			Sys.println('[LIBRARY INSTALLER] Created ".haxelib" folder');
		}

		try
		{
			final json:Array<Library> = Json.parse(File.getContent('./${haxe.macro.Compiler.getDefine('LIBFILENAME') ?? 'hmm'}.json')).dependencies;

			for (lib in json)
			{
				Sys.println('[LIBRARY INSTALLER] Installing ${lib.name} version: ${lib.version}');
				switch (lib.type)
				{
					case "haxelib":
						Sys.command('haxelib --quiet install ${lib.name} ${lib.version != null ? lib.version : ""}');
					case "git":
						Sys.command('haxelib --quiet git ${lib.name} ${lib.url}');
					default:
						Sys.println('Cannot resolve library of type "${lib.type}"');
				}
			}
		}
		catch (e)
		{
			Sys.println('[LIBRARY INSTALLER] An error has occurred while trying to install the libraries');
			Sys.println('[LIBRARY INSTALLER] ${e.message}');
		};
	}

	public static function getPlatform(platformName:String):Bool
	{
		if (haxe.macro.Compiler.getDefine('comments') == '1')
			Sys.println('[PLATFORM CHECK] $platformName ${haxe.macro.Compiler.getDefine('PLATFORM') != platformName ? 'not ' : ''}defined');

		if (haxe.macro.Compiler.getDefine('PLATFORM') == platformName)
		{
			if (!properCompile)
			{
				properCompile = true;
				appends += '$platformName';

				return true;
			}
		}

		return false;
	}
}
