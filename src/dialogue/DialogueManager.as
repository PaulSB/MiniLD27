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
		// Dialogue node IDs	***THESE ARE HARD-CODED INTO XML AND CAN NOT CHANGE!!!***
		public static const eDIALOGUE_NONE:uint = 0;
		public static const eDIALOGUE_OPENER:uint = 1;
		
		// State of dialogue at given node
		private const eDIALOGUESTATE_BUTTONS:uint = 0;
		private const eDIALOGUESTATE_PLAYERSAY:uint = 1;
		private const eDIALOGUESTATE_NPCSAY:uint = 2;
		
		// Constants
		private const MAX_OPTION_BUTTONS:int = 8;
		private const BUTTON_X_POS:Number = 180.0;
		private const BUTTON_Y_POS_START:Number = FlxG.height + 40;
		private const BUTTON_Y_VELOCITY:Number = -10.0;
		
		private var m_currentNode:uint = eDIALOGUE_NONE;
		private var m_currentState:uint = eDIALOGUESTATE_BUTTONS;
		private var m_dialogueData:DialogueData;
		
		// Graphic objects
		private var m_optionButtons:FlxGroup;
		private var m_playerTextbox:TextPanel;		// Text box displaying spoken text
		private var m_npcTextbox:TextPanel;
		
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
			
			m_playerTextbox = new TextPanel(true);
			m_playerTextbox.visible = false;
			add(m_playerTextbox);
			
			m_npcTextbox = new TextPanel();
			m_npcTextbox.visible = false;
			add(m_npcTextbox);
			
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
				button.onUp = process;
				
				m_currentState = eDIALOGUESTATE_BUTTONS;
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
		
		private function process():void
		{
			if (m_currentNode == eDIALOGUE_OPENER)
			{
				if (m_currentState == eDIALOGUESTATE_BUTTONS)
				{
					m_npcTextbox.visible = false;
					
					m_currentState = eDIALOGUESTATE_PLAYERSAY;
					
					resetButtons();
					
					var bodyText:String = m_dialogueData.getPlayerTextByButtonID(BubbleButton.m_lastButtonIDClicked);
					
					m_playerTextbox.SetupPanel((FlxG.width - m_playerTextbox.GetSize().x) * 0.5, FlxG.height - m_playerTextbox.GetSize().y +0,
												bodyText, process);
				}
				else if (m_currentState == eDIALOGUESTATE_PLAYERSAY)
				{
					m_playerTextbox.visible = false;
					
					m_currentState = eDIALOGUESTATE_NPCSAY;
					
					var responseText:String = m_dialogueData.getNPCTextByButtonID(BubbleButton.m_lastButtonIDClicked);
					
					m_npcTextbox.SetupPanel((FlxG.width - m_playerTextbox.GetSize().x) * 0.5, 0, responseText);
					
					initDialogueNode(m_dialogueData.getNextNodeByButtonID(BubbleButton.m_lastButtonIDClicked));
				}
			}
		}
	}
}