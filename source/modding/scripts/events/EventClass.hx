package modding.scripts.events;

class EventClass
{
	public var id:String = 'UnknownEvent';

	public function new(id:String)
	{
		this.id = id;
		toString();
	}

	public function toString()
	{
		trace('EventClass(id: $id)');
	}
}
