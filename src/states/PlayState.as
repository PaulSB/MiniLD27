package states 
{
	import dialogue.DialogueManager;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	
	/**
	 * MiniLD 27 - "All Talk"
	 * @author Paul S Burgess - 14/06/11
	 */
	public class PlayState extends FlxState
	{
		[Embed(source = '../../data/textures/npc/NPC_readingheadup.png')] private var imgNPCreadingheadup:Class;
		
		// Pseudo-enums
		private const eANIM_NONE:uint = 0;
		private const eANIM_NPC_ENTER:uint = 1;
		
		// Member vars
		private var m_currentAnim:uint = eANIM_NONE;
		private var m_animTimer:Number = 0.0;
		
		// Graphic objects
		private var m_npc:FlxSprite;			// The character you are talking to
		private var m_dialogue:DialogueManager;	// The dialogue manager object, containing all text and conversation options
		
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
			super.update();
			
			updateAnim();
		}
		
		private function onUnFade():void
		{
			// Begin game
			m_currentAnim = eANIM_NPC_ENTER;
			m_animTimer = 4.0;
		}
		
		private function updateAnim():void
		{
			if (m_currentAnim == eANIM_NPC_ENTER)
			{
				if (m_animTimer > 0.0)
				{
					// TO DO: Intermediate anim frames (only 1 or 2)
					
					m_animTimer -= FlxG.elapsed;
				}
				else
				{
					m_npc = new FlxSprite;
					m_npc.loadGraphic(imgNPCreadingheadup);
					m_npc.x = (FlxG.width - m_npc.width) * 0.5;
					m_npc.y = FlxG.height - m_npc.height;
					s_layerScene.add(m_npc);
					
					m_currentAnim = eANIM_NONE;
					m_animTimer = 0.0;
					
					m_dialogue.initDialogueNode(DialogueManager.eDIALOGUE_OPENER);
				}
			}
		}
	}
}