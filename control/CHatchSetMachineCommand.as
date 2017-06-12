package mmo.activity170407.corpshatch.control
{
	import flash.display.MovieClip;
	
	import mmo.activity170407.corpshatch.common.ICHatchCommand;
	import mmo.activity170407.corpshatch.config.CHatchConfig;
	import mmo.activity170407.corpshatch.data.CHatchData;
	
	public class CHatchSetMachineCommand extends CHatchCommand implements ICHatchCommand
	{
		public function CHatchSetMachineCommand()
		{
		}
		
		public function excute(content:CHatchData):void
		{
			for(var i:int = 0; i < CHatchConfig.TYPES_NUM; i ++)
			{
				var machine:MovieClip = content.panel.getChildByName("mchole_"+i) as MovieClip;
				machine.gotoAndStop(content.types.indexOf(i) != -1 ? 2 : 1);
			}
			this.suc(content);
		}
		
		public function cancle():void
		{
			//
		}
	}
}