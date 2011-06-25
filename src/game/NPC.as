package game 
{
	import dialogue.DialogueManager;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import states.PlayState;
	
	/**
	 * MiniLD 27 - "All Talk"
	 * @author Paul S Burgess - 22/06/11
	 */
	public class NPC extends FlxSprite
	{
		[Embed(source = '../../data/textures/npc/NPC_readingheadup.png')] private var imgNPCreadingheadup:Class;
		[Embed(source = '../../data/textures/npc/NPC_intro_1.png')] private var imgNPCintro1:Class;
		
		// Pseudo-enums
		static public const eANIM_NONE:uint = 0;
		static public const eANIM_NPC_ENTER:uint = 1;
		
		// Member vars
		private var m_currentAnim:uint = eANIM_NONE;
		private var m_animTimer:Number = 0.0;
		private var m_animParam:int = 0;	// Spare var for tracking progression of certain anims
		
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
			
			if (m_currentAnim == eANIM_NPC_ENTER)	{ m_animTimer = 5.0; }
			else									{ m_animTimer = 0.0; }
			
			m_animParam = 0;
		}
		
		private function updateAnim():void
		{
			if (m_currentAnim == eANIM_NPC_ENTER)
			{
				if (m_animTimer > 0.0)
				{
					// TO DO: Intermediate anim frames (only 1 or 2)
					if (m_animParam == 0)
					{
						if (m_animTimer < 4.0)
						{
							// Transition
							visible = true;
							
							loadGraphic(imgNPCintro1);
							x = 140;
							y = 80;
							alpha = 0;
							
							m_animParam++;
						}
					}
					else if (m_animParam == 1)
					{
						var deltaAlpha:Number;
						if (m_animTimer < 3.00)
						{
							// Transition
							alpha = 0.0;
							m_animParam++;
						}
						else if (m_animTimer < 3.25)
						{
							// Fade out
							deltaAlpha = ((m_animTimer - 3.0) * 4.0);
							alpha = deltaAlpha;
						}
						else if (m_animTimer < 3.75)
						{
							// Hold
							if (alpha < 1.0)	alpha = 1.0;
						}
						else if (m_animTimer < 4.0)
						{
							// Fade in
							deltaAlpha = 1.0 - ((m_animTimer - 3.75) * 4.0);
							alpha = deltaAlpha;
						}
					}
					
					m_animTimer -= FlxG.elapsed;
				}
				else
				{
					// Intro anim over, load current idle graphic
					loadGraphic(imgNPCreadingheadup);
					x = (FlxG.width - width) * 0.5;
					y = FlxG.height - height + 10;
					alpha = 1;
					
					m_currentAnim = eANIM_NONE;
					m_animTimer = 0.0;
					
					PlayState.m_dialogue.initDialogueNode(DialogueManager.eDIALOGUE_OPENER);
				}
			}
		}
	}
}