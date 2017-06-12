package mmo.activity170407.corpshatch.config
{
	import mmo.loader.common.datastructures.ResourceObject;

	public class CHatchConfig
	{
		public function CHatchConfig()
		{
		}
		
		private static const FLA_PRE_PATH:String = "activityres/activity170407/corpshatch/";
		
		public static const RES_MAIN:ResourceObject = new ResourceObject(FLA_PRE_PATH + "corpshatch_main",
			"mmo.activity170407.corpshatch.view.CorpsHatchMain");
		
		public static const RES_EXCHANGE:ResourceObject = new ResourceObject(FLA_PRE_PATH + "corpshatch_exchange",
			"mmo.activity170407.corpshatch.view.CHatchExchange");
		
		public static const RES_JIN_DOU_NOT_ENOUGH:ResourceObject = new ResourceObject(FLA_PRE_PATH + "corpshatch_tipspanel",
			"mmo.activity170407.corpshatch.view.CHatchJindouNotEnough");
		
		public static const RES_MATERIAL_FULL:ResourceObject = new ResourceObject(FLA_PRE_PATH + "corpshatch_tipspanel",
			"mmo.activity170407.corpshatch.view.CHatchMaterialFull");
		
		public static const MAX_CELLS:int = 16;
		
		public static const TYPES_NUM:int = 5;
		
		public static const PRICE_CONFIG:Array = [100,300,500,1000,2000];
		
		public static const HALF_TIMES:int = 100;
		
		public static const ID_ENERGY:int = 2715;
		private static const ID_GARBAGE:int = 2716;
		
		public static const EACH_GARBAGE_GET_JINDOU:int = 10;
		
		public static const TYPE_EGG:int = 0;
		public static const TYPE_ENERGY:int = 1;
		public static const TYPE_GARBAGE:int = 2;
		
		public static function getType(id:int):int
		{
			if(id == ID_ENERGY)
			{
				return TYPE_ENERGY;
			}else if(id == ID_GARBAGE)
			{
				return TYPE_GARBAGE;
			}
			return TYPE_EGG;
		}
		
		public static const EX_NEED:Array = 
			[
				10,
				20,
				40,
				60,
				100,
				200,
				300
			];
	}
}