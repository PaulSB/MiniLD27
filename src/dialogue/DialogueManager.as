package dialogue 
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import ui.BubbleButton;
	import ui.TextPanel;
	
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
		private const BUTTON_X_POS:Number = 180.0;
		private const BUTTON_Y_POS_START:Number = FlxG.height + 40;
		private const BUTTON_Y_VELOCITY:Number = -10.0;
		
		private var m_currentNode:uint = eDIALOGUE_NONE;
		private var m_dialogueData:DialogueData;
		
		// Graphic objects
		private var m_optionButtons:FlxGroup;
		private var m_textbox:TextPanel;		// Text box displaying spoken text
		
		public function DialogueManager() 
		{
			super();
			
			m_optionButtons = new FlxGroup;
			
			var loop:int = 0;
			for (loop; loop < MAX_OPTION_BUTTONS; loop++)
			{
				var newButton:BubbleButton = new BubbleButton(BUTTON_X_POS, BUTTON_Y_POS_START);
				newButton.m_minYpos = loop * 80;
				m_optionButtons.add(newButton);
			}
			
			add(m_optionButtons);
			
			m_textbox = new TextPanel;
			m_textbox.visible = false;
			add(m_textbox);
			
			// Init xml data
			m_dialogueData = new DialogueData;
		}
		
		public function initDialogueNode(node:uint):void
		{
			m_currentNode = node;
			
			if (m_currentNode == eDIALOGUE_OPENER)
			{
				resetButtons();
				
				// Dialogue option
				var button:BubbleButton = m_optionButtons.members[0];
				button.label.text = m_dialogueData.getButtonTextByName("HI");
				button.velocity.y = BUTTON_Y_VELOCITY;
				// Result callback
				button.onUp = processOption;
			}
		}
		
		private function resetButtons():void
		{
			for each (var button:BubbleButton in m_optionButtons.members)
			{
				button.setPos(BUTTON_X_POS, BUTTON_Y_POS_START);
				button.velocity.y = 0;
			}
		}
		
		private function processOption():void
		{
			if (m_currentNode == eDIALOGUE_OPENER)
			{
				resetButtons();
				
				// TO DO: multiple response possibilities
				var responseText:String = m_dialogueData.getFullTextByID(BubbleButton.m_lastButtonIDClicked);
				m_textbox.SetupPanel((FlxG.width - m_textbox.GetSize().x) * 0.5, FlxG.height - m_textbox.GetSize().y, responseText);
				
				// TO DO: Next dialogue node...
			}
		}
	}
}