package mmo.activity170407.corpshatch.panel
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import mmo.activity170407.corpshatch.client.CHatchClient;
	import mmo.activity170407.corpshatch.common.CHatchHelper;
	import mmo.activity170407.corpshatch.common.CHatchPanelBase;
	import mmo.activity170407.corpshatch.config.CHatchConfig;
	import mmo.activity170407.corpshatch.control.CHatchManager;
	import mmo.activity170407.corpshatch.control.CHatchSetMachineCommand;
	import mmo.activity170407.corpshatch.data.CHatchData;
	import mmo.activity170407.corpshatch.item.CHatchItem;
	import mmo.activity170407.corpshatch.item.CHatchItemMovie;
	import mmo.common.DisplayUtil;
	import mmo.common.ProgressFullSprite;
	import mmo.common.dialog.NewDialog;
	import mmo.framework.comm.statistic.SundriesClient;
	import mmo.interfaces.ServiceContainer;
	import mmo.interfaces.aolabook.AolaBookTab;
	import mmo.interfaces.material.MaterialTypes;
	import mmo.interfaces.rmbshoppingmall.IRmbShoppingMallBuyMaterialHelper;
	import mmo.play.activity.framework.util.LinkUtil;
	import mmo.play.activity.helper.Panel_Helper;
	
	public class CorpsHatchMain extends CHatchPanelBase
	{
		private var _data:CHatchData;
		private var _viewList:Array = [];
		private var _manager:CHatchManager;
		private var _pickTypes:Array = [];
		private var _pickIndex:int = -1;
		
		public function CorpsHatchMain()
		{
			super(CHatchConfig.RES_MAIN);
		}
		
		override protected function updatePanel():void
		{
			// TODO Auto Generated method stub
			super.updatePanel();
			SundriesClient.logBehaviour(885,true);
			SundriesClient.logEvent(22880);
			Panel_Helper.addPraiseIcon(769,this._panel);
			this._manager = new CHatchManager();
			this._manager.init(setPanel);
			this._data.setView(this._panel);
			this._panel.mconekey.gotoAndStop(1);
			this.setPanel();
			this.initMachineTips();
			new CHatchSetMachineCommand().excute(this._data);
		}
		
		override public function dispose():void
		{
			// TODO Auto Generated method stub
			super.dispose();
			this._manager.dispose();
			this._manager = null;
			SundriesClient.logBehaviour(885);
		}
		
		override protected function onClick(evt:MouseEvent):void
		{
			// TODO Auto Generated method stub
			if(this._manager.isAuto() && evt.target.name != "btncancleonekey")
			{
				return;
			}
			switch(evt.target.name)
			{
				case "btnopen":
					var index:int = int(evt.target.parent.name.split("_")[1]);
					this._manager.startMachine(index, _data);
					break;
				case "btnpickall":
					this.pickAll();
					break;
				case "btnexchange":
					new CHatchExchange().showPanel();
					break;
				case "btnonekeystart":
					this.autoMachine();
					break;
				case "btncancleonekey":
					this.cancelAuto();
					break;
				case "btncheck":
					CHatchHelper.showCorps();
					break;
				case "btnget":
					var item:CHatchItem = evt.target.parent.parent as CHatchItem;
					this.pickOne(item);
					break;
				case "btndecs":
					LinkUtil.showAolaBookPanel(AolaBookTab.PET_CORPS);
					break;
				case "btnbuyjingdou":
					showBuyJingDouPanel();
					break;
				default:
					super.onClick(evt);
			}
		}
		
		private function showBuyJingDouPanel():void
		{
			ProgressFullSprite.show();
			ServiceContainer.tryGetService(IRmbShoppingMallBuyMaterialHelper,function onGetService(service:IRmbShoppingMallBuyMaterialHelper,params:Object):void
			{
				ProgressFullSprite.close();
				service.buyMaterialById(2339,MaterialTypes.ITEM);
			});
		}
		
		override public function showPanel():void
		{
			// TODO Auto Generated method stub
			CHatchClient.sendCmdAndCallback(CHatchClient.cmdPanel,{},onGetInfo);
		}
		
		private function pickOne(item:CHatchItem):void
		{
			var i:int = this._viewList.indexOf(item);
			function onPickOne(params:Object):void
			{
				if(params.r == 1)
				{
					ProgressFullSprite.lockScreen();
					setPickParams([],i);
					playOnceMovie(i,CHatchConfig.getType(item.id));
				}else
				{
					NewDialog.showFailMessage("失败了:"+params.r);
				}
			}
			CHatchClient.sendCmdAndCallback(CHatchClient.cmdPickIndex,{"i":i},onPickOne);
		}
		
		private function pickAll():void
		{
			if(this._data.isEmpty())
			{
				return;
			}
			function onPickAll(params:Object):void
			{
				playMovie([CHatchConfig.TYPE_EGG, CHatchConfig.TYPE_ENERGY, CHatchConfig.TYPE_GARBAGE]);
			}
			CHatchClient.sendCmdAndCallback(CHatchClient.cmdPickAll,{}, onPickAll);
		}
		
		private function playMovie(types:Array):void
		{
			ProgressFullSprite.lockScreen();
			this.setPickParams(types, -1);
			for(var i:int = this._data.cells.length - 1; i >= 0; i --)
			{
				var o:Object = this._data.cells[i];
				var type:int = CHatchConfig.getType(o.id);
				if(types.indexOf(type) == -1)
				{
					continue;
				}
				this.playOnceMovie(i, type);
			}
		}
		
		private function setPickParams(types:Array, index:int):void
		{
			this._pickTypes = types;
			this._pickIndex = index;
		}
		
		private function playOnceMovie(index:int, type:int):void
		{
			trace(type);
			switch(type)
			{
				case CHatchConfig.TYPE_EGG:
					this.tweenTo(this._viewList[index],this._panel.btncheck.x,this._panel.btncheck.y);
					break;
				case CHatchConfig.TYPE_ENERGY:
					this.tweenTo(this._viewList[index],this._panel.btnexchange.x,this._panel.btnexchange.y);
					break;
				case CHatchConfig.TYPE_GARBAGE:
					this.playGarbageMovie(index);
					break;
			}
		}
		
		private function tweenTo(mc:MovieClip, x:Number,y:Number):void
		{
			TweenLite.to(mc, 1.5, {"alpha":0,"x":x,"y":y,"scaleX":0.2,"scaleY":0.2, "onComplete":onTweenFinish, "ease":Linear.easeNone});
		}
		
		private function playGarbageMovie(index:int):void
		{
			var pos:MovieClip = this._panel.getChildByName("p_"+index) as MovieClip;
			var cc:CHatchItemMovie = new CHatchItemMovie();
			this._viewList[index].visible = false;
			var n:int = this._data.cells[index].num;
			cc.playMovie(this._panel,pos.x,pos.y,onTweenFinish,n);
		}
		
		private function onTweenFinish():void
		{
			ProgressFullSprite.unlockScreen();
			if(this._pickTypes.length <= 0 && this._pickIndex == -1)
			{
				return;
			}
			this.removeMC();
			this.setPickParams([],-1);
		}
		
		private function removeMC():void
		{
			if(this._pickIndex >= 0)
			{
				this._data.cells.splice(this._pickIndex,1);
			}else if(this._pickTypes.length > 0)
			{
				for(var i:int = this._data.cells.length - 1; i >= 0; i --)
				{
					var info:Object = this._data.cells[i];
					var type:int = CHatchConfig.getType(info.id);
					if(this._pickTypes.indexOf(type) >= 0)
					{
						this._data.cells.splice(i,1);
					}
				}
			}
			for each(var v:MovieClip in this._viewList)
			{
				DisplayUtil.stopAndRemove(v);
			}
			this._viewList = [];
			this.setPanel(); //重新加载
		}
		
		private function cancelAuto():void
		{
			this._panel.mconekey.gotoAndStop(1);
			this._manager.stopAutoMachine();
		}
		
		private function autoMachine():void
		{
			if(this._data.isFull())
			{
				CHatchHelper.showMaterialFull();
				return;
			}
			this._panel.mconekey.gotoAndStop(2);
			this._manager.autoStartMachine(_data);
		}
		
		private function onGetInfo(params:Object):void
		{
			this._data = new CHatchData(params);
			super.showPanel();
		}
		
		private function initMachineTips():void
		{
			for(var i:int = 0; i < CHatchConfig.TYPES_NUM; i ++)
			{
				var m:MovieClip = this._panel.getChildByName("mchole_"+i) as MovieClip;
				m.addEventListener(MouseEvent.ROLL_OVER, onRollOverM);
				m.addEventListener(MouseEvent.MOUSE_OUT, onRollOutM);
				var tips:MovieClip = this._panel.getChildByName("mcprice_"+i) as MovieClip;
				this.setTips(i,false);
			}
		}
		
		private function onRollOverM(e:MouseEvent):void
		{
			var m:MovieClip = e.currentTarget as MovieClip;
			var index:int = int(m.name.split("_")[1]);
			if(m.currentFrame == 2)
			{
				this.setTips(index, true);
			}
		}
		
		private function onRollOutM(e:MouseEvent):void
		{
			var m:MovieClip = e.currentTarget as MovieClip;
			var index:int = int(m.name.split("_")[1]);
			this.setTips(index,false);
		}
		
		private function setTips(index:int, vis:Boolean):void
		{
			var tips:MovieClip = this._panel.getChildByName("mcprice_"+index) as MovieClip;
			tips.gotoAndStop(this._data.halfTime > 0 ? 2 : 1);
			if(tips.mcneed)
			{
				CHatchHelper.setArtNumber(tips.mcneed, CHatchConfig.PRICE_CONFIG[index]);
			}
			if(tips.mchalf)
			{
				CHatchHelper.setArtNumber(tips.mchalf, CHatchConfig.PRICE_CONFIG[index] / 2);
			}
			tips.visible = vis;
		}
		
		private function setPanel():void
		{
			CHatchHelper.setArtNumber(this._panel.mchalf, CHatchConfig.HALF_TIMES);
			CHatchHelper.setArtNumber(this._panel.mclefthalf, _data.halfTime);
			for(var i:int = 0; i < this._data.cells.length; i ++)
			{
				if(this._viewList[i] == null)
				{
					var item:CHatchItem = new CHatchItem(this._data.cells[i]);
					var pos:MovieClip = this._panel.getChildByName("p_"+i) as MovieClip;
					item.setPosition(pos.x, pos.y);
					this._panel.addChild(item);
					this._viewList.push(item);
				}
			}
			if(!this._manager.isAuto())
			{
				this.cancelAuto();
			}
		}
	}
}