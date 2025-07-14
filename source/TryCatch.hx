package;

typedef TryCatchParamaters =
{
	var ?errFunc:Dynamic->Void;
	var ?traceErr:Bool;
}

class TryCatch
{
	/**
	 * This function is purely to clean up your code with all the try catch statements you are trying to use.
	 * @param func the function you are trying to run
	 * @param paramaters optional paramaters for the tryCatch.
	 */
	public static function tryCatch<T>(func:Void->T, ?options:TryCatchParamaters, ?infos:PosInfos):T
	{
		try
		{
			return func();
		}
		catch (e:Dynamic)
		{
			if (options != null)
			{
				if (options.traceErr)
				{
					infos.className = 'source/' + infos.className.replace('.', '/') + '.hx:${infos.lineNumber}';
					trace('[${infos.className}] Error: $e');
				}
				if (options.errFunc != null)
					options.errFunc(e);
			}
			return null;
		}
	}
}
