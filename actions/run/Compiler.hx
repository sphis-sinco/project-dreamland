class Compiler
{
	static var appends:String = '';
	static var properCompile:Bool = false;

	static var availiblePlatforms:Array<String> = ['hl', 'windows', 'osx/mac', 'linux'];

	public static function main():Void
	{
		#if linux
		if (!properCompile)
		{
			properCompile = true;
			appends += 'linux';
		}
		#end
		#if (osx || mac)
		if (!properCompile)
		{
			properCompile = true;
			appends += 'mac';
		}
		#end
		#if windows
		if (!properCompile)
		{
			properCompile = true;
			appends += 'windows';
		}
		#end
		#if hashlink
		if (!properCompile)
		{
			properCompile = true;
			appends += 'hl';
		}
		#end

		#if debug appends += ' -debug'; #end
		#if watch appends += ' -watch'; #end

		appends += ' --times';

		compile();

		if (!properCompile)
		{
			Sys.println('Missing compile platform...');
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
}
