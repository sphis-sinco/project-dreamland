class Hashlink
{
	public static function main():Void
	{
		Sys.command('cls');
		Sys.command('cd ../../');
		Sys.println('Running...');
		Sys.command('lime test hl -debug --times');
		Sys.exit(0);
	}
}
