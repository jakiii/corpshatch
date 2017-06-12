package mmo.activity170407.corpshatch.item
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import mmo.activity170407.corpshatch.common.CHatchHelper;
	import mmo.activity170407.corpshatch.config.CHatchConfig;
	import mmo.common.DisplayUtil;
	import mmo.common.utils.tips.TipsManager;
	import mmo.interfaces.IDispose;
	import mmo.interfaces.ServiceContainer;
	import mmo.interfaces.material.MaterialServiceEvent;
	import mmo.interfaces.material.item.IItemService;

	public class CHatchItem extends MovieClip implements IDispose
	{
		private var _id:int;
		private var _isInit:Boolean = false;
		
		public function CHatchItem(infos:Object)
		{
			this._id = infos.id;
			this.txtname.text = CHatchHelper.getItemName(_id);
			this.txtnum.text = "x"+infos.num + "";
			this.mctypes.visible = false;
			this.addEventListener(MouseEvent.ROLL_OVER, onOverM);
			this.addEventListener(MouseEvent.ROLL_OUT, onOutM);
			var items:IItemService = ServiceContainer.getService(IItemService) as IItemService;
			items.addEventListener(MaterialServiceEvent.onGetView, onGetView);
			items.getView(_id);
		}
		
		public function setPosition(x:Number, y:Number):void
		{
			this.x = x;
			this.y = y;
		}
		
		public function get id():int
		{
			return _id;
		}
		
		public function dispose():void{}
		
		private function onOverM(e:MouseEvent):void
		{
			this.mctypes.visible = true;
			this.mctypes.gotoAndStop(CHatchConfig.getType(_id) + 1);
		}
		
		private function onOutM(e:MouseEvent):void
		{
			this.mctypes.visible = false;
		}
		
		private function onGetView(e:MaterialServiceEvent):void
		{
			if(e.params.id != _id || this._isInit)
			{
				return;
			}
			var s:IItemService = ServiceContainer.getService(IItemService) as IItemService;
			s.removeEventListener(MaterialServiceEvent.onGetView, onGetView);
			this._isInit = true;
			var cc:DisplayObject = DisplayUtil.cloneDisplayObject(e.params.view);
			cc.name = "mTips_2_"+_id;
			this.viewcontainer.addChild(cc);
			TipsManager.getInstance().addMaterialTips(this);
			DisplayUtil.alignDisplay(cc,this.viewcontainer,"11");
		}
	}
}