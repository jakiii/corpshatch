package mmo.activity170407.corpshatch.control
{
	import mmo.activity170407.corpshatch.common.ICHatchCommand;
	import mmo.activity170407.corpshatch.data.CHatchData;
	import mmo.activity170407.corpshatch.event.CHatchEvent;
	
	public class CHatchMacroCommand extends CHatchCommand implements ICHatchCommand
	{
		private var _commands:Array = [];
		
		public function CHatchMacroCommand()
		{
			super();
			this.initSubCommand();
		}
		
		protected function initSubCommand():void
		{
		}
		
		protected function addSubCommand(command:ICHatchCommand):void
		{
			this._commands.push(command);
		}
		
		public function excute(content:CHatchData):void
		{
			this.excuteNextCommand(content);
		}
		
		public function cancle():void
		{
			for each(var command:ICHatchCommand in this._commands)
			{
				command.cancle();
			}
		}
		
		private function excuteNextCommand(content:CHatchData):void
		{
			if(this._commands.length <= 0)
			{
				this.suc(content);
				return;
			}
			var command:ICHatchCommand = this._commands.shift();
			function onSucCommand(e:CHatchEvent):void
			{
				disposeCommand();
				excuteNextCommand(content);
			}
			function onFailCommand(e:CHatchEvent):void
			{
				trace("_______failed");
				disposeCommand();
				fail(content);
			}
			function disposeCommand():void
			{
				command.removeEventListener(CHatchEvent.SUC, onSucCommand);
				command.removeEventListener(CHatchEvent.FAIL, onFailCommand);
			}
			command.addEventListener(CHatchEvent.SUC, onSucCommand);
			command.addEventListener(CHatchEvent.FAIL, onFailCommand);
			command.excute(content);
		}
	}
}