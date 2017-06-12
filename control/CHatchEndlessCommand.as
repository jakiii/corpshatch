package mmo.activity170407.corpshatch.control
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mmo.activity170407.corpshatch.common.ICHatchCommand;
	import mmo.activity170407.corpshatch.data.CHatchData;
	import mmo.activity170407.corpshatch.event.CHatchEvent;
	
	public class CHatchEndlessCommand extends CHatchCommand implements ICHatchCommand
	{
		public function CHatchEndlessCommand()
		{
		}
		
		public function excute(content:CHatchData):void
		{
			if(this.isStop)
			{
				suc(content);
				return;
			}
			var command:ICHatchCommand = new CHatchOnceCommand();
			function nextFunc():void
			{
				suc(content);
				excute(content);
			}
			function onSucCommand(e:CHatchEvent):void
			{
				disposeCommand();
				delayApply(nextFunc);
			}
			function onFailCommand(e:CHatchEvent):void
			{
				disposeCommand();
				cancle();
				fail(content);
			}
			function disposeCommand():void
			{
				command.removeEventListener(CHatchEvent.SUC, onSucCommand);
				command.removeEventListener(CHatchEvent.FAIL, onFailCommand);
			}
			command.addEventListener(CHatchEvent.SUC, onSucCommand);
			command.addEventListener(CHatchEvent.FAIL, onFailCommand);
			command.excute(content);
		}
		
		public function cancle():void
		{
			//
		}
		
		private function delayApply(func:Function):void
		{
			var t:Timer = new Timer(500, 1);
			t.addEventListener(TimerEvent.TIMER_COMPLETE, function onTimerComp():void
			{
				t.stop();
				t.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComp);
				t = null;
				func.apply();
			});
			t.start();
		}
	}
}