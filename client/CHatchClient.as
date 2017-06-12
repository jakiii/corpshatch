package mmo.activity170407.corpshatch.client
{
	import mmo.common.ProgressFullSprite;
	import mmo.framework.comm.SocketClient;
	import mmo.framework.comm.SocketClientEvent;
	public class CHatchClient
	{
		public function CHatchClient()
		{
		}
		
		private static const EX:String = "HolidayExtension";
		private static const CMDHEAD:String = "AI-170407";
		
		/**
		 *@out "lt" - int 剩余免费次数
		 *@out "types" - Array [],哪些门开着0-4的数组
		 *@out "b" - array Object {id,type,num} 好似都是物品
		 */		
		public static const cmdPanel:String = CMDHEAD + "_p";
		
		/**点门(自动点也是此命令)
		 *@in "i" - int 点的门0-4 
		 *@out "r" - int : 1,成功
		 *@out "types" - Array [],哪些门开着0-4的数组
		 *@out "b" - Object {id,type,num} 好似都是物品
		 */			
		public static const cmdOpen:String = CMDHEAD + "_o";
		
		/**
		 * @in "i" - int 0-6
		 * @out "r" - int : 1,成功
		 * @out "bn" - Array
		 */
		public static const cmdExchange:String = CMDHEAD + "_ex";
		
		/**
		 * 拾取全部
		 * @out "bn" - Array<ASObj>
		 */
		public static const cmdPickAll:String = CMDHEAD + "_ta";
		
		/**
		 * @in "i" - int ：指定栏序号
		 * @out "r" - int : 1,成功
		 * @out "bn" - Array<ASObj> : 奖励
		 */
		public static const cmdPickIndex:String = CMDHEAD + "_ttb";
		
		public static function sendCmdAndCallback(cmd:String, params:Object, callback:Function, needProgress:Boolean = true):void
		{
			if(needProgress)
			{
				ProgressFullSprite.show();
			}
			SocketClient.instance.addEventListener(cmd, function onGetInfo(e:SocketClientEvent):void
			{
				if(needProgress)
				{
					ProgressFullSprite.close();
				}
				SocketClient.instance.removeEventListener(cmd, onGetInfo);
				callback.apply(null,[e.params]);
			});
			sendXtMessage(cmd, params);
		}
		
		private static function sendXtMessage(cmd:String, params:Object):void
		{
			SocketClient.instance.sendXtMessage(EX, cmd, params);
		}	
	}
}