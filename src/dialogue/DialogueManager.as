package dialogue 
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import states.PlayState;
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
		
		private const MAX_OPTION_BUTTONS:int = 8;
		private const BUTTON_X_POS:Number = 180.0;
		private const BUTTON_Y_POS_START:Number = FlxG.height + 40;
		private const BUTTON_Y_POS_FINISH:Number = 125.0;
		public static const BUTTON_Y_VELOCITY:Number = -40.0;
		
		private var m_currentNode:uint = eDIALOGUE_NONE;
		private var m_currentState:uint = eDIALOGUESTATE_BUTTONS;
		private var m_dialogueData:DialogueData;
		private var m_buttonTimer:Number = 0.0;
		private static var m_comfortLevel:int;	// 0-100 - how comfortable npc is with player (cold/indifferent/acquainted/friendly/enraptured)
		private var m_buttonsUsed:Array;
		
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
			
			m_buttonsUsed = new Array(m_dialogueData.getNumberOfButtons());
			for (var buttonLoop:int = 0; buttonLoop < m_buttonsUsed.length; buttonLoop++)
			{
				m_buttonsUsed[buttonLoop] = false;
			}
			
			m_comfortLevel = 19;
		}
		
		public function initDialogueNode(node:uint):void
		{
			m_currentNode = node;
			
			resetButtons();
			
			var nodeName:String = m_dialogueData.getNodeNameByID(node);
			var isHub:Boolean = (nodeName.search("QHUB") == 0);
			
			// Dialogue option
			var buttonIDs:Array = m_dialogueData.getButtonIDsByNodeID(m_currentNode);
			for (var buttonLoop:int = 0; buttonLoop < buttonIDs.length && buttonLoop < MAX_OPTION_BUTTONS; buttonLoop++)
			{
				var button:BubbleButton = m_optionButtons.members[buttonLoop];
				var buttonID:uint = buttonIDs[buttonLoop];
				
				if (!m_buttonsUsed[buttonID])
				{
					button.setupButton(m_dialogueData.getButtonTextByID(buttonID), process,
										buttonID, m_dialogueData.getButtonTimeByID(buttonID), BUTTON_Y_VELOCITY);
				}
			}
			
			m_currentState = eDIALOGUESTATE_BUTTONS;
			
			m_buttonTimer = 0.0;
		}
		
		public function shutDownDialogue():void
		{
			if (!isDialogueActive())
				PlayState.m_achievements.awardAchievement(PlayState.m_achievements.eACHIEVEMENT_ALONE);
			
			resetButtons();
			m_playerTextbox.visible = false;
			m_npcTextbox.visible = false;
		}
		
		public function isDialogueActive():Boolean
		{
			return (m_npcTextbox.visible);
		}
		
		public function forceGoToEndDialogue():void
		{
			shutDownDialogue();
			
			switch (getCurrentComfortState())
			{
				case 4:
				case 3:
					m_npcTextbox.SetupPanel((FlxG.width - m_npcTextbox.GetSize().x) * 0.5, 0, "This is me. Hey look... here's my number. Call me sometime if you like.");
					PlayState.m_achievements.awardAchievement(PlayState.m_achievements.eACHIEVEMENT_APPLES);
					break;
				case 2:
					m_npcTextbox.SetupPanel((FlxG.width - m_npcTextbox.GetSize().x) * 0.5, 0, "This is me. Nice meeting you.");
					break;
				case 1:
					m_npcTextbox.SetupPanel((FlxG.width - m_npcTextbox.GetSize().x) * 0.5, 0, "Excuse me.");
					break;
				case 0:
					m_npcTextbox.SetupPanel((FlxG.width - m_npcTextbox.GetSize().x) * 0.5, 0, "...");
					break;
				
				default:
					break;
			}
		}
		
		static public function getCurrentComfortState():int
		{
			if (m_comfortLevel > 80)
			{
				//PlayState.m_achievements.awardAchievement(PlayState.m_achievements.eACHIEVEMENT_LOVED);
				return 4;
			}
			else if (m_comfortLevel > 60)
			{
				PlayState.m_achievements.awardAchievement(PlayState.m_achievements.eACHIEVEMENT_LOVED);
				return 3;
			}
			else if (m_comfortLevel > 40)
			{
				PlayState.m_achievements.awardAchievement(PlayState.m_achievements.eACHIEVEMENT_LIKED);
				return 2;
			}
			else if (m_comfortLevel > 20)
			{
				return 1;
			}
			else 
			{
				if (m_comfortLevel <= 0)
					PlayState.m_achievements.awardAchievement(PlayState.m_achievements.eACHIEVEMENT_HATE);
					
				return 0;
			}
		}

		private function resetButtons():void
		{
			for each (var button:BubbleButton in m_optionButtons.members)
			{
				button.setPos(BUTTON_X_POS, BUTTON_Y_POS_START);
				button.label.y = BUTTON_Y_POS_START;
				button.active = false;
				button.m_buttonID = -1;
			}
		}
		
		private function process():void
		{
			if (m_currentState == eDIALOGUESTATE_BUTTONS)
			{
				m_npcTextbox.setFaded(true);
				m_buttonsUsed[BubbleButton.m_lastButtonIDClicked] = true;
				
				m_currentState = eDIALOGUESTATE_PLAYERSAY;
				
				resetButtons();
				
				var bodyText:String = m_dialogueData.getPlayerTextByButtonID(BubbleButton.m_lastButtonIDClicked);
				
				m_playerTextbox.SetupPanel((FlxG.width - m_playerTextbox.GetSize().x) * 0.5, FlxG.height - m_playerTextbox.GetSize().y,
											bodyText, process);
			}
			else if (m_currentState == eDIALOGUESTATE_PLAYERSAY)
			{
				m_playerTextbox.setFaded(true);
				
				m_currentState = eDIALOGUESTATE_NPCSAY;
				
				var responseText:String = m_dialogueData.getNPCTextByButtonID(BubbleButton.m_lastButtonIDClicked, m_comfortLevel);
				
				m_npcTextbox.SetupPanel((FlxG.width - m_npcTextbox.GetSize().x) * 0.5, 0, responseText, process);
			}
			else if (m_currentState == eDIALOGUESTATE_NPCSAY)
			{
				m_currentState = eDIALOGUESTATE_BUTTONS;
				
				var nextNode:int = m_dialogueData.getNextNodeByButtonID(BubbleButton.m_lastButtonIDClicked, m_comfortLevel);
				if (nextNode > 0)
					initDialogueNode(nextNode);
				else
					PlayState.m_achievements.awardAchievement(PlayState.m_achievements.eACHIEVEMENT_RANOUT);
				
				// Awards
				var achievementID:int = m_dialogueData.getAchievementByButtonID(BubbleButton.m_lastButtonIDClicked, m_comfortLevel);
				if (achievementID > 0)
				{
					PlayState.m_achievements.awardAchievement(achievementID);
				}
				
				// Adjust comfort level
				m_comfortLevel += m_dialogueData.getComfortBonusByButtonID(BubbleButton.m_lastButtonIDClicked, m_comfortLevel);
			}
		}
	}
}