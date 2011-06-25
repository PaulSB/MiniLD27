package dialogue 
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
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
		public static const eDIALOGUE_QHUB1:uint = 2;	// "QHUB" = Question hub, major branching point where new conv. threads are available
		
		// State of dialogue at given node
		private const eDIALOGUESTATE_BUTTONS:uint = 0;
		private const eDIALOGUESTATE_PLAYERSAY:uint = 1;
		private const eDIALOGUESTATE_NPCSAY:uint = 2;
		
		private const MAX_OPTION_BUTTONS:int = 8;
		private const BUTTON_X_POS:Number = 180.0;
		private const BUTTON_Y_POS_START:Number = FlxG.height + 40;
		private const BUTTON_Y_POS_FINISH:Number = 125.0;
		public static const BUTTON_Y_VELOCITY:Number = -30.0;
		
		private var m_currentNode:uint = eDIALOGUE_NONE;
		private var m_currentState:uint = eDIALOGUESTATE_BUTTONS;
		private var m_dialogueData:DialogueData;
		private var m_buttonTimer:Number = 0.0;
		
		// Graphic objects
		private var m_optionButtons:FlxGroup;
		private var m_playerTextbox:TextPanel;		// Text box displaying spoken text
		private var m_npcTextbox:TextPanel;
		
		public function DialogueManager() 
		{
			super();
			
			m_playerTextbox = new TextPanel(true);
			m_playerTextbox.visible = false;
			add(m_playerTextbox);
			
			m_npcTextbox = new TextPanel();
			m_npcTextbox.visible = false;
			add(m_npcTextbox);
			
			m_optionButtons = new FlxGroup;
			
			var loop:int = 0;
			for (loop; loop < MAX_OPTION_BUTTONS; loop++)
			{
				var newButton:BubbleButton = new BubbleButton(BUTTON_X_POS, BUTTON_Y_POS_START);
				newButton.m_minYpos = loop * 80 + BUTTON_Y_POS_FINISH;
				m_optionButtons.add(newButton);
			}
			
			add(m_optionButtons);
			
			// Init xml data
			m_dialogueData = new DialogueData;
		}
		
		public function initDialogueNode(node:uint):void
		{
			m_currentNode = node;
			
			resetButtons();
			
			// Dialogue option
			var buttonIDs:Array = m_dialogueData.getButtonIDsByNodeID(m_currentNode);
			for (var buttonLoop:int = 0; buttonLoop < buttonIDs.length && buttonLoop < MAX_OPTION_BUTTONS; buttonLoop++)
			{
				var button:BubbleButton = m_optionButtons.members[buttonLoop];
				var buttonID:uint = buttonIDs[buttonLoop];
				button.setupButton(m_dialogueData.getButtonTextByID(buttonID), process,
									buttonID, m_dialogueData.getButtonTimeByID(buttonID), BUTTON_Y_VELOCITY);
			}
			
			m_currentState = eDIALOGUESTATE_BUTTONS;
			
			m_buttonTimer = 0.0;
		}

		private function resetButtons():void
		{
			for each (var button:BubbleButton in m_optionButtons.members)
			{
				button.setPos(BUTTON_X_POS, BUTTON_Y_POS_START);
				button.label.y = BUTTON_Y_POS_START;
				button.active = false;
			}
		}
		
		private function process():void
		{
			if (m_currentState == eDIALOGUESTATE_BUTTONS)
			{
				m_npcTextbox.setFaded(true);
				
				m_currentState = eDIALOGUESTATE_PLAYERSAY;
				
				resetButtons();
				
				var bodyText:String = m_dialogueData.getPlayerTextByButtonID(BubbleButton.m_lastButtonIDClicked);
				
				m_playerTextbox.SetupPanel((FlxG.width - m_playerTextbox.GetSize().x) * 0.5, FlxG.height - m_playerTextbox.GetSize().y +0,
											bodyText, process);
			}
			else if (m_currentState == eDIALOGUESTATE_PLAYERSAY)
			{
				m_playerTextbox.setFaded(true);
				
				m_currentState = eDIALOGUESTATE_NPCSAY;
				
				var responseText:String = m_dialogueData.getNPCTextByButtonID(BubbleButton.m_lastButtonIDClicked);
				
				m_npcTextbox.SetupPanel((FlxG.width - m_playerTextbox.GetSize().x) * 0.5, 0, responseText, process);
			}
			else if (m_currentState == eDIALOGUESTATE_NPCSAY)
			{
				m_currentState = eDIALOGUESTATE_BUTTONS;
				
				initDialogueNode(m_dialogueData.getNextNodeByButtonID(BubbleButton.m_lastButtonIDClicked));
			}
		}
	}
}