package states 
{
	import dialogue.DialogueManager;
	import game.NPC;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import ui.BubbleButton;
	
	/**
	 * MiniLD 27 - "All Talk"
	 * @author Paul S Burgess - 14/06/11
	 */
	public class PlayState extends FlxState
	{
		private const GAME_DURATION:Number = 60;		// Seconds
		private const END_FADEOUT_TIME:Number = 2.5;	// Seconds
		
		// Time-based game states
		static public var eGAMESTATE_NONE:uint = 0;
		static public var eGAMESTATE_INTRO:uint = 1;
		static public var eGAMESTATE_JOURNEYSTART:uint = 2;
		static public var eGAMESTATE_JOURNEYNEAREND:uint = 3;
		static public var eGAMESTATE_JOURNEYEND:uint = 4;
		static public var eGAMESTATE_OUTTRO:uint = 5;
		static public var eGAMESTATE_FADEOUT:uint = 6;
		
		static public var m_currentGameState:uint = eGAMESTATE_NONE;
		private var m_clockTime:Number = 0;	// Game clock
		
		// Graphic objects
		private var m_npc:NPC;							// The character you are talking to
		public static var m_dialogue:DialogueManager;	// The dialogue manager object, containing all text and conversation options
		
		// Render layers
		public static var s_layerOutside:FlxGroup;
		public static var s_layerBackground:FlxGroup;
		public static var s_layerScene:FlxGroup;
		public static var s_layerUI:FlxGroup;
		
		override public function create():void
		{
			super.create();
			
			s_layerOutside = new FlxGroup;
			s_layerBackground = new FlxGroup;
			s_layerScene = new FlxGroup;
			s_layerUI = new FlxGroup;
			
			FlxG.bgColor = 0xffffffff;
			
			var outside:FlxSprite = new FlxSprite();
			outside.loadGraphic(MenuState.imgOutside);
			outside.x = FlxG.width - outside.width;
			outside.y = 160;
			s_layerBackground.add(outside);
			
			var bg:FlxSprite = new FlxSprite();
			bg.loadGraphic(MenuState.imgBG);
			s_layerBackground.add(bg);
			
			m_npc = new NPC;
			s_layerScene.add(m_npc);
			
			m_dialogue = new DialogueManager;
			s_layerUI.add(m_dialogue);
			
			// Add render layers
			add(s_layerOutside);
			add(s_layerBackground);
			add(s_layerScene);
			add(s_layerUI);
			
			FlxG.flash(0xffffffff, 0.5, onUnFade);
		}
		
		override public function update():void 
		{
			if (m_currentGameState > eGAMESTATE_NONE)
				m_clockTime += FlxG.elapsed;
			
			if (m_currentGameState == eGAMESTATE_INTRO)
			{
				if (m_clockTime > m_npc.INTRO_ANIM_TIME)
				{
					m_currentGameState = eGAMESTATE_JOURNEYSTART;
					
					m_dialogue.initDialogueNode(DialogueManager.eDIALOGUE_OPENER);
				}
			}
			if (m_currentGameState == eGAMESTATE_JOURNEYSTART)
			{
				if (m_clockTime > GAME_DURATION - 10)
				{
					// If conversation is "active", jump to her "goodbye" dialogue node here, rather than just fucking off
					if (m_dialogue.isDialogueActive())
					{
						m_currentGameState = eGAMESTATE_JOURNEYNEAREND;
						
						m_dialogue.forceGoToEndDialogue();
					}
					else
					{
						m_currentGameState = eGAMESTATE_JOURNEYEND;
					}
				}
			}
			else if (m_currentGameState == eGAMESTATE_JOURNEYNEAREND || m_currentGameState == eGAMESTATE_JOURNEYEND)
			{
				if (m_clockTime > GAME_DURATION - m_npc.OUTTRO_ANIM_TIME)
				{
					m_currentGameState = eGAMESTATE_OUTTRO;
					
					m_dialogue.shutDownDialogue();
					m_npc.setAnim(NPC.eANIM_NPC_EXIT);
				}
			}
			else if (m_currentGameState == eGAMESTATE_OUTTRO)
			{
				if (m_clockTime > GAME_DURATION)
				{
					m_currentGameState = eGAMESTATE_FADEOUT;
					
					FlxG.fade(0xffffffff, END_FADEOUT_TIME, onFadeOut);
				}
			}
			else if (m_currentGameState == eGAMESTATE_FADEOUT)
			{
				m_currentGameState = eGAMESTATE_NONE;
			}
			
			super.update();
		}
		
		private function onUnFade():void
		{
			// Begin game
			m_currentGameState = eGAMESTATE_INTRO;
			m_npc.setAnim(NPC.eANIM_NPC_ENTER);
		}
		private function onFadeOut():void
		{
			FlxG.switchState( new MenuState() );
		}
	}
}