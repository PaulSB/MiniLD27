package dialogue 
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import ui.BubbleButton;
	
	/**
	 * MiniLD 27 - "All Talk"
	 * @author Paul S Burgess - 19/06/11
	 */
	public class DialogueManager extends FlxGroup
	{
		// Dialogue node IDs
		public static const eDIALOGUE_NONE:uint = 0;
		public static const eDIALOGUE_OPENER:uint = 1;
		
		// Constants
		private const MAX_OPTION_BUTTONS:int = 8;
		private const BUTTON_X_POS:Number = 200.0;
		private const BUTTON_Y_POS_START:Number = FlxG.height + 100.0;
		
		private var m_currentNode:uint = eDIALOGUE_NONE;
		private var m_dialogueData:DialogueData;
		
		// Graphic objects
		private var m_optionButtons:FlxGroup;
		
		public function DialogueManager() 
		{
			super();
			
			m_optionButtons = new FlxGroup;
			
			var loop:int = 0;
			for (loop; loop < MAX_OPTION_BUTTONS; loop++)
			{
				var newButton:BubbleButton = new BubbleButton(BUTTON_X_POS, BUTTON_Y_POS_START);
				m_optionButtons.add(newButton);
			}
			
			add(m_optionButtons);
			
			// Init xml data
			m_dialogueData = new DialogueData;
		}
	}
}