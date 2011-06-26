package game 
{
	import dialogue.DialogueManager;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	/**
	 * MiniLD 27 - "All Talk"
	 * @author Paul S Burgess - 22/06/11
	 */
	public class NPC extends FlxSprite
	{
		[Embed(source = '../../data/textures/npc/NPC_readingheaddown.png')] private var imgNPCreadingheaddown:Class;
		[Embed(source = '../../data/textures/npc/NPC_readingheadup.png')] private var imgNPCreadingheadup:Class;
		[Embed(source = '../../data/textures/npc/NPC_intro_1.png')] private var imgNPCintro1:Class;
		[Embed(source = '../../data/textures/npc/NPC_intro_2.png')] private var imgNPCintro2:Class;
		[Embed(source = '../../data/textures/npc/NPC_intro_3.png')] private var imgNPCintro3:Class;
		
		// Pseudo-enums
		static public const eANIM_NONE:uint = 0;
		static public const eANIM_NPC_ENTER:uint = 1;
		static public const eANIM_NPC_EXIT:uint = 2;
		
		public const INTRO_ANIM_TIME:Number = 4.0;
		public const OUTTRO_ANIM_TIME:Number = 4.0;
		
		private const introFrames:Array = [imgNPCintro1, imgNPCintro2, imgNPCintro3, imgNPCreadingheadup];
		private const introPositions:Array = [new FlxPoint(140, 80), new FlxPoint(120, 70), new FlxPoint(150, 55), new FlxPoint(330, 120)];
		private const comfortFrames:Array = [imgNPCreadingheaddown, imgNPCreadingheadup, imgNPCreadingheadup, imgNPCreadingheadup, imgNPCreadingheadup];
		private const comfortPositions:Array = [new FlxPoint(330, 120), new FlxPoint(330, 120), new FlxPoint(330, 120), new FlxPoint(330, 120)];
		
		// Member vars
		private var m_currentAnim:uint = eANIM_NONE;
		private var m_animTimer:Number = 0.0;
		private var m_animParam:int = 0;	// Spare var for tracking progression of certain anims
		private var m_lastComforState:int = 0;
		
		public function NPC() 
		{
			super();
			visible = false;
		}
		
		override public function update():void 
		{
			updateAnim();
			
			super.update();
		}
		
		public function setAnim(state:uint):void
		{
			m_currentAnim = state;
			
			if (m_currentAnim == eANIM_NPC_ENTER)		{ m_animTimer = INTRO_ANIM_TIME; }
			else if (m_currentAnim == eANIM_NPC_EXIT)	{ m_animTimer = OUTTRO_ANIM_TIME; }
			else										{ m_animTimer = 0.0; }
			
			m_animParam = 0;
		}
		
		private function updateAnim():void
		{
			if (m_currentAnim == eANIM_NPC_ENTER)
			{
				if (m_animTimer > 0.0)
				{
					if (m_animParam == 0)
					{
						if (m_animTimer < INTRO_ANIM_TIME)
						{
							// Transition
							visible = true;
							
							loadGraphic(introFrames[m_animParam]);
							x = introPositions[m_animParam].x;
							y = introPositions[m_animParam].y;
							alpha = 0;
							
							m_animParam++;
						}
					}
					else
					{
						var frameStartTime:Number = INTRO_ANIM_TIME - (INTRO_ANIM_TIME * (m_animParam-1)/4.0)
						var deltaAlpha:Number;
						if (m_animTimer < (frameStartTime - 1.0))
						{
							// Transition
							loadGraphic(introFrames[m_animParam]);
							x = introPositions[m_animParam].x;
							y = introPositions[m_animParam].y;
							alpha = 0;
							
							m_animParam++;
						}
						else if (m_animTimer < (frameStartTime - 0.75))
						{
							// Fade out
							deltaAlpha = ((m_animTimer - (frameStartTime - 1.0)) * 4.0);
							alpha = deltaAlpha;
						}
						else if (m_animTimer < (frameStartTime - 0.25))
						{
							// Hold
							if (alpha < 1.0)
								alpha = 1.0;
						}
						else if (m_animTimer < frameStartTime)
						{
							// Fade in
							deltaAlpha = 1.0 - ((m_animTimer - (frameStartTime - 0.25)) * 4.0);
							alpha = deltaAlpha;
						}
					}
					
					m_animTimer -= FlxG.elapsed;
				}
				else 
				{
					// Intro anim over, load current idle graphic
					m_lastComforState = DialogueManager.getCurrentComfortState();
					loadGraphic(comfortFrames[m_lastComforState]);
					x = comfortPositions[m_lastComforState].x;
					y = comfortPositions[m_lastComforState].y;
					alpha = 1;
					
					m_currentAnim = eANIM_NONE;
					m_animTimer = 0.0;
				}
			}
			else if (m_currentAnim == eANIM_NPC_EXIT)	// TO DO
			{
				if (m_animTimer > 0.0)
				{
					if (m_animParam == 0)
					{
						if (m_animTimer < INTRO_ANIM_TIME)
						{
							// Transition
							visible = true;
							
							loadGraphic(introFrames[m_animParam]);
							x = introPositions[m_animParam].x;
							y = introPositions[m_animParam].y;
							alpha = 0;
							
							m_animParam++;
						}
					}
					else
					{
						frameStartTime = INTRO_ANIM_TIME - (INTRO_ANIM_TIME * (m_animParam-1)/4.0)
						if (m_animTimer < (frameStartTime - 1.0))
						{
							// Transition
							loadGraphic(introFrames[m_animParam]);
							x = introPositions[m_animParam].x;
							y = introPositions[m_animParam].y;
							alpha = 0;
							
							m_animParam++;
						}
						else if (m_animTimer < (frameStartTime - 0.75))
						{
							// Fade out
							deltaAlpha = ((m_animTimer - (frameStartTime - 1.0)) * 4.0);
							alpha = deltaAlpha;
						}
						else if (m_animTimer < (frameStartTime - 0.25))
						{
							// Hold
							if (alpha < 1.0)
								alpha = 1.0;
						}
						else if (m_animTimer < frameStartTime)
						{
							// Fade in
							deltaAlpha = 1.0 - ((m_animTimer - (frameStartTime - 0.25)) * 4.0);
							alpha = deltaAlpha;
						}
					}
					
					m_animTimer -= FlxG.elapsed;
				}
				else 
				{
					// Intro anim over, load current idle graphic
					m_lastComforState = DialogueManager.getCurrentComfortState();
					loadGraphic(comfortFrames[m_lastComforState]);
					x = comfortPositions[m_lastComforState].x;
					y = comfortPositions[m_lastComforState].y;
					alpha = 1;
					
					m_currentAnim = eANIM_NONE;
					m_animTimer = 0.0;
				}
			}
			else if (m_currentAnim == eANIM_NONE)
			{
				if (m_lastComforState != DialogueManager.getCurrentComfortState())
				{
					m_lastComforState = DialogueManager.getCurrentComfortState();
					loadGraphic(comfortFrames[m_lastComforState]);
					x = comfortPositions[m_lastComforState].x;
					y = comfortPositions[m_lastComforState].y;
				}
			}
		}
	}
}