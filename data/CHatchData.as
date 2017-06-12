package mmo.activity170407.corpshatch.data
{
	import flash.display.MovieClip;
	
	import mmo.activity170407.corpshatch.config.CHatchConfig;

	public class CHatchData
	{
		private var _cells:Array = [];
		private var _types:Array = [];
		private var _panel:MovieClip;
		private var _halfTime:int;
		
		/**
		 *@out "lt" - int 剩余免费次数
		 *@out "types" - Array [],哪些门开着0-4的数组
		 *@out "b" - Object {id,type,num} 好似都是物品
		 */		
		public function CHatchData(params:Object)
		{
			this._halfTime = params.lt;
			this._types = params.types;
			if(params.b != null && params.b.length > 0)
			{
				for each(var o:Object in params.b)
				{
					this.addBonus(o);
				}
			}
		}
		
		public function setView(panel:MovieClip):void
		{
			this._panel = panel;
		}
		
		public function get panel():MovieClip
		{
			return _panel;
		}
		
		public function addBonus(b:Object):void
		{
			this._cells.push(b);
		}
		
		public function resetTypes(t:Array):void
		{
			this._types = t;
		}
		
		public function get types():Array
		{
			return this._types;
		}
		
		public function get cells():Array
		{
			return _cells;
		}
		
		public function isFull():Boolean
		{
			return this._cells.length >= CHatchConfig.MAX_CELLS;
		}
		
		public function decHalfTimes():void
		{
			if(this._halfTime > 0)
			{
				this._halfTime --;
			}
		}
		
		public function get halfTime():int
		{
			return _halfTime;
		}
		
		public function isEmpty():Boolean
		{
			return this._cells == null || this._cells.length <= 0;
		}
	}
}