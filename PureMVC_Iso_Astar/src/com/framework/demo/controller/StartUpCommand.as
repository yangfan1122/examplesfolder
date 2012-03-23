package com.framework.demo.controller
{
	import org.puremvc.as3.patterns.command.MacroCommand;
	
	public class StartUpCommand extends MacroCommand
	{
		override protected function initializeMacroCommand( ):void
		{
			addSubCommand( ModelPrepCommand );
			addSubCommand( ViewPrepCommand );
		}
	}
}