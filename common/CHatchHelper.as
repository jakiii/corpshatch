package mmo.activity170407.corpshatch.common
{
	import flash.display.MovieClip;
	
	import mmo.activity170407.corpshatch.panel.CHatchJindouNotEnough;
	import mmo.activity170407.corpshatch.panel.CHatchMaterialFull;
	import mmo.interfaces.ServiceContainer;
	import mmo.interfaces.material.item.IItemService;
	import mmo.interfaces.petcorps.IPetCorpsService;
	import mmo.util.component.artnumber.ArtNumberManager;

	public class CHatchHelper
	{
		public function CHatchHelper()
		{
		}
		
		public static function showMaterialFull():void
		{
			new CHatchMaterialFull().showPanel();
		}
		
		public static function getItemName(id:int):String
		{
			var ii:IItemService = ServiceContainer.getService(IItemService) as IItemService;
			return ii.getItemById(id).name;
		}
		
		public static function setArtNumber(mc:MovieClip, n:int):void
		{
			var arr:Array = [];
			for(var i:int = 0; i < 10; i ++)
			{
				var mcnum:MovieClip = mc.getChildByName("mc_"+i) as MovieClip;
				if(mcnum != null)
				{
					arr.push(mcnum);
				}
			}
			ArtNumberManager.setNumber(arr,n);
		}
		
		public static function showJindouNotEnough():void
		{
			new CHatchJindouNotEnough().showPanel();
		}
		
		public static function showCorps():void
		{
			var icorp:IPetCorpsService = ServiceContainer.getService(IPetCorpsService) as IPetCorpsService;
			icorp.showPetCorpsMainPanel();
		}
	}
}