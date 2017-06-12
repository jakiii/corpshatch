package mmo.activity170407.corpshatch.control
{
	import mmo.activity170407.corpshatch.common.ICHatchCommand;
	import mmo.activity170407.corpshatch.data.CHatchData;
	import mmo.activity170407.corpshatch.event.CHatchEvent;
	import mmo.interfaces.IDispose;
	
	public class CHatchManager implements IDispose
	{
		private var _currentCommand:ICHatchCommand;
		private var _isExcuting:Boolean = false;
		private var _updateFunc:Function;
		
		public function CHatchManager()
		{
		}
		
		public function init(updateFunc:Function):void
		{
			this._updateFunc = updateFunc;
		}
		
		public function get isExcuting():Boolean
		{
			return _isExcuting;
		}
		
		public function startMachine(index:int, content:CHatchData):void
		{
			content.resetTypes([index]);
			this.excuteCommand(new CHatchOnceCommand(), content);
		}
		
		public function autoStartMachine(content:CHatchData):void
		{
			this.excuteCommand(new CHatchEndlessCommand(), content);
		}
		
		public function stopAutoMachine():void
		{
			if(this._currentCommand != null && this._currentCommand is CHatchEndlessCommand)
			{
				CHatchEndlessCommand(this._currentCommand).stop();
			}
		}
		
		public function isAuto():Boolean
		{
			return this._currentCommand != null && this._currentCommand is CHatchEndlessCommand &&
				CHatchEndlessCommand(_currentCommand).isRunning();
		}
		
		public function dispose():void
		{
			this.disposeCommand();
		}
		
		private function excuteCommand(command:ICHatchCommand, content:CHatchData):void
		{
			this.disposeCommand();
			this._isExcuting = true;
			this._currentCommand = command;
			this._currentCommand.addEventListener(CHatchEvent.SUC, onCommandSuc);
			this._currentCommand.addEventListener(CHatchEvent.FAIL, onCommandFail);
			this._currentCommand.excute(content);
		}
		
		private function disposeCommand():void
		{
			if(this._currentCommand != null)
			{
				this._currentCommand.cancle();
				this._currentCommand.removeEventListener(CHatchEvent.SUC, onCommandSuc);
				this._currentCommand.removeEventListener(CHatchEvent.FAIL, onCommandFail);
				this._currentCommand = null;
			}
		}
		
		private function onCommandFail(e:CHatchEvent):void
		{
			this._isExcuting = false;
			this.stopAutoMachine();
			this.disposeCommand();
			this._updateFunc.apply();
		}
		
		private function onCommandSuc(e:CHatchEvent):void
		{
			this._updateFunc.apply();
		}
	}
}