package mmo.activity170407.corpshatch.common
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import mmo.common.user.UserInfo;
	import mmo.common.utils.tips.TipsManager;
	import mmo.framework.comm.Commands;
	import mmo.framework.comm.SocketClient;
	import mmo.loader.common.datastructures.ResourceObject;
	import mmo.play.activity.panelbase.PanelBase;
	
	public class CHatchPanelBase extends PanelBase
	{
		private var _suc:Function;
		private var _fail:Function;
		
		public function CHatchPanelBase(res:ResourceObject, sucFunc:Function = null, failFunc:Function = null)
		{
			super(res);
			this._suc = sucFunc;
			this._fail = failFunc;
			SocketClient.instance.addEventListener(Commands.onXingBiUpdated, onUpdate);
			SocketClient.instance.addEventListener(Commands.onJingDouUpdated,onUpdate);
		}
		
		override protected function onClick(evt:MouseEvent):void
		{
			// TODO Auto Generated method stub
			switch(evt.target.name)
			{
				case "btnclose":
				case "btnClose":
					this.fail();
					break;
				case "btnconfirm":
					this.suc();
					break;
				default:
					super.onClick(evt);
			}
		}
		
		override protected function updatePanel():void
		{
			// TODO Auto Generated method stub
			this.setTxt();
			TipsManager.getInstance().addMaterialTips(this._panel);
		}
		
		override public function dispose():void
		{
			// TODO Auto Generated method stub
			super.dispose();
			SocketClient.instance.removeEventListener(Commands.onXingBiUpdated, onUpdate);
			SocketClient.instance.removeEventListener(Commands.onJingDouUpdated,onUpdate);
		}
		
		protected function suc(obj:Object = null):void
		{
			if(this._suc != null)
			{
				if(obj != null)
				{
					this._suc.apply(null,[obj]);
				}else
				{
					this._suc.apply();
				}
			}
			this.closePanel();
		}
		
		protected function fail(obj:Object = null):void
		{
			this.closePanel();
			if(this._fail != null)
			{
				if(obj != null)
				{
					this._fail.apply(null,[obj]);
				}else
				{
					this._fail.apply();
				}
			}
		}
		
		private function onUpdate(e:Event):void
		{
			this.setTxt();
		}
		
		protected function setTxt():void
		{
			this.setMC(this._panel);
		}
		
		private function setMC(ds:DisplayObject):void
		{
			if(ds.name == "txtmy")
			{
				TextField(ds).text = UserInfo.xingbi + "";
			}
			if(ds.name == "txtjindou")
			{
				TextField(ds).text = UserInfo.jingdou + "";
			}
			if(ds is DisplayObjectContainer)
			{
				for(var i:int = 0; i < DisplayObjectContainer(ds).numChildren; i ++)
				{
					var mm:DisplayObject = DisplayObjectContainer(ds).getChildAt(i) as DisplayObject;
					setMC(mm);
				}
			}
		}
	}
}