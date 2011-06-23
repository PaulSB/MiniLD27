package states 
{
	import dialogue.DialogueManager;
	import game.NPC;
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
			super.update();
		}
		
		private function onUnFade():void
		{
			// Begin game
			m_npc.setAnim(NPC.eANIM_NPC_ENTER);
		}
	}
}