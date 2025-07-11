class Compiler
{
	static var appends:String = '';
	static var properCompile:Bool = false;

	static var availiblePlatforms:Array<String> = ['hl', 'windows', 'mac', 'linux'];

	public static function main():Void
	{
		for (platform in availiblePlatforms)
		{
			if (getPlatform(platform))
				break;
		}

		#if debug appends += ' -debug'; #end
		#if watch appends += ' -watch'; #end

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
		Sys.command('cd ../../');
		Sys.command('lime test ' + appends);
		Sys.exit(0);
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
