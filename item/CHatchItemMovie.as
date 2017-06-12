package mmo.activity170407.corpshatch.item
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import mmo.activity170407.corpshatch.common.CHatchHelper;
	import mmo.activity170407.corpshatch.config.CHatchConfig;
	import mmo.common.DisplayUtil;
	
	public class CHatchItemMovie extends MovieClip
	{
		private var _func:Function;
		
		public function CHatchItemMovie()
		{
			super();
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		}
		
		public function playMovie(cc:MovieClip, x:Number,y:Number,func:Function,n:int):void
		{
			cc.addChild(this);
			this.x = x;
			this.y = y;
			this.gotoAndStop(1);
			CHatchHelper.setArtNumber(this.mcc, n*CHatchConfig.EACH_GARBAGE_GET_JINDOU);
			this._func = func;
			this.addFrameScript(totalFrames - 1, function onEnd():void
			{
				func.apply();
				close();
			});
			this.gotoAndPlay(1);
		}
		
		private function onRemoved(e:Event):void
		{
			this.stop();
		}
		
		private function close():void
		{
			this.stop();
			DisplayUtil.stopAndRemove(this);
		}
	}
}