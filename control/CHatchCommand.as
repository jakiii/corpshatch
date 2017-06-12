package mmo.activity170407.corpshatch.control
{
	import flash.events.EventDispatcher;
	
	import mmo.activity170407.corpshatch.data.CHatchData;
	import mmo.activity170407.corpshatch.event.CHatchEvent;
	
	public class CHatchCommand extends EventDispatcher
	{
		protected var isStop:Boolean = false;
		
		public function CHatchCommand()
		{
			super();
		}
		
		public function isRunning():Boolean
		{
			return !isStop;
		}
		
		public function stop():void
		{
			this.isStop = true;
		}
		
		public function suc(content:CHatchData):void
		{
			dispatchEvent(new CHatchEvent(CHatchEvent.SUC,content));
		}
		
		public function fail(content:CHatchData):void
		{
			this.dispatchEvent(new CHatchEvent(CHatchEvent.FAIL,content));
		}
	}
}