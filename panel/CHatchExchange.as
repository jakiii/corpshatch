package mmo.activity170407.corpshatch.panel
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	
	import mmo.activity170407.corpshatch.client.CHatchClient;
	import mmo.activity170407.corpshatch.common.CHatchHelper;
	import mmo.activity170407.corpshatch.common.CHatchPanelBase;
	import mmo.activity170407.corpshatch.config.CHatchConfig;
	import mmo.common.DisplayUtil;
	import mmo.common.bonus.ShowBonusHelper;
	import mmo.common.dialog.NewDialog;
	import mmo.common.utils.tips.TipsManager;
	import mmo.play.activity.helper.ItemQuantity_Helper;
	
	public class CHatchExchange extends CHatchPanelBase
	{
		public function CHatchExchange()
		{
			super(CHatchConfig.RES_EXCHANGE);
		}
		
		override protected function updatePanel():void
		{
			// TODO Auto Generated method stub
			super.updatePanel();
			this.setPanel();
		}
		
		override protected function onClickButton(btn:SimpleButton):void
		{
			// TODO Auto Generated method stub
			if(btn.name.indexOf("btnext_") != -1)
			{
				this.exchange(int(btn.name.split("_")[1]));
			}else
			{
				super.onClickButton(btn);
			}
		}
		
		private function exchange(index:int):void
		{
			if(ItemQuantity_Helper.getItemQuantity(CHatchConfig.ID_ENERGY) < CHatchConfig.EX_NEED[index])
			{
				return;
			}
			function onEx(params:Object):void
			{
				if(params.r == 1)
				{
					ShowBonusHelper.showBonus(params.bn);
					setPanel();
				}else
				{
					NewDialog.showFailMessage("失败了:"+params.r);
				}
			}
			CHatchClient.sendCmdAndCallback(CHatchClient.cmdExchange,{"i":index},onEx);
		}
		
		private function setPanel():void
		{
			for(var i:int = 0; i < CHatchConfig.EX_NEED.length; i ++)
			{
				var btn:SimpleButton = this._panel.getChildByName("btnext_"+i) as SimpleButton;
				TipsManager.getInstance().removeTips(btn);
				DisplayUtil.clearFilters(btn);
				if(ItemQuantity_Helper.getItemQuantity(CHatchConfig.ID_ENERGY) < CHatchConfig.EX_NEED[i])
				{
					DisplayUtil.applyGray(btn);
					TipsManager.getInstance().addTips(btn,"你的"+CHatchHelper.getItemName(CHatchConfig.ID_ENERGY) + "不够哦！");
				}
				var artnum:MovieClip = this._panel.getChildByName("mcnum_"+i) as MovieClip;
				CHatchHelper.setArtNumber(artnum, CHatchConfig.EX_NEED[i]);
			}
			this._panel.txtitemnum.text = ItemQuantity_Helper.getItemQuantity(CHatchConfig.ID_ENERGY) + "";
		}
	}
}