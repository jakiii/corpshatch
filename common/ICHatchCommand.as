package mmo.activity170407.corpshatch.common
{
	import flash.events.IEventDispatcher;
	
	import mmo.activity170407.corpshatch.data.CHatchData;

	public interface ICHatchCommand extends IEventDispatcher
	{
		function excute(content:CHatchData):void;
		
		function cancle():void;
	}
}