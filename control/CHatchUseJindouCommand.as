package mmo.activity170407.corpshatch.control
{
	import mmo.activity170407.corpshatch.client.CHatchClient;
	import mmo.activity170407.corpshatch.common.CHatchHelper;
	import mmo.activity170407.corpshatch.common.ICHatchCommand;
	import mmo.activity170407.corpshatch.data.CHatchData;
	import mmo.common.material.MaterialResultDialogHelper;
	import mmo.framework.comm.statistic.SundriesClient;

	public class CHatchUseJindouCommand extends CHatchCommand implements ICHatchCommand
	{
		public function CHatchUseJindouCommand()
		{
		}
		
		public function excute(content:CHatchData):void
		{
			if(content.isFull())
			{
				CHatchHelper.showMaterialFull();
				this.fail(content);
				return;
			}
			var t:int = content.types[content.types.length - 1];
			function onUse(params:Object):void
			{
				if(params.r == 1)
				{
					SundriesClient.logEvent(22881);
					content.resetTypes(params.types);
					content.addBonus(params.b);
					content.decHalfTimes();
					suc(content);
				}else if(params.r == -3)
				{
					MaterialResultDialogHelper.showMaterialResultDialog(101, false);
					fail(content);
//					CHatchHelper.showJindouNotEnough();
				}else
				{
					MaterialResultDialogHelper.showMaterialResultDialog(params.r, false);
					fail(content);
				}
			}
			CHatchClient.sendCmdAndCallback(CHatchClient.cmdOpen,{"i":t},onUse,false);
		}
		
		public function cancle():void
		{
			//
		}
	}
}