package menus;

typedef CreditsEntry =
{
	name:String,
	?role:String,
	?email:String,
	?url:String
}

class CreditsMenu extends FlxState
{
	public var creditsJSON:Array<CreditsEntry> = [];
}
