package mmo.activity170407.corpshatch.control
{
	public class CHatchOnceCommand extends CHatchMacroCommand
	{
		public function CHatchOnceCommand()
		{
		}
		
		override protected function initSubCommand():void
		{
			// TODO Auto Generated method stub
			super.initSubCommand();
			this.addSubCommand(new CHatchUseJindouCommand());
			this.addSubCommand(new CHatchSetMachineCommand());
		}
	}
}