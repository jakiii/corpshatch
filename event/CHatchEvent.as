package mmo.activity170407.corpshatch.event
{
	import flash.events.Event;
	
	import mmo.activity170407.corpshatch.data.CHatchData;
	
	public class CHatchEvent extends Event
	{
		public static const SUC:String = "CHATCHEVENT_SUC";
		public static const FAIL:String = "CHATCHEVENT_FAIL";
		
		public var params:CHatchData;
		
		public function CHatchEvent(type:String, params:CHatchData)
		{
			super(type, false, false);
			this.params = params;
		}
	}
}