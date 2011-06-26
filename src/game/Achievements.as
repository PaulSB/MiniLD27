package game 
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	
	/**
	 * MiniLD 27 - "All Talk"
	 * @author Paul S Burgess - 26/06/11
	 */
	public class Achievements extends FlxGroup
	{
		[Embed(source = '../../data/textures/ui/Achievement.png')] private var imgIcon:Class;
		
		public const eACHIEVEMENT_NAME:int = 1;
		public const eACHIEVEMENT_TEST2:int = 2;
		public const eACHIEVEMENT_TEST3:int = 3;
		public const eACHIEVEMENT_TEST4:int = 4;
		public const eACHIEVEMENT_TEST5:int = 5;
		
		static public const NUM_ACHIEVEMENTS:int = 5;
		
		private const BACKING_WIDTH:Number = 250.0;
		private const PANEL_MOVE_SPEED:Number = 200.0;
		
		// Graphic objects
		private var m_backing:FlxSprite;
		private var m_icons:FlxGroup;
		private var m_names:FlxGroup;
		private var m_descs:FlxGroup;
		
		private var m_shownXPos:Number;
		private var m_hiddenXPos:Number;
		private var m_targetXPos:Number;
		
		public function Achievements() 
		{
			super();
			
			m_icons = new FlxGroup;
			m_names = new FlxGroup;
			m_descs = new FlxGroup;
			for (var achievementLoop:int = 0; achievementLoop < NUM_ACHIEVEMENTS; achievementLoop++)
			{
				var unlocked:Boolean = SaveData.getAchievementStatus(achievementLoop+1);
				
				var icon:FlxSprite = new FlxSprite(FlxG.width - BACKING_WIDTH, 0);
				icon.loadGraphic(imgIcon);
				icon.y = (achievementLoop +1) * icon.height;
				
				icon.alpha = unlocked ? 1 : 0.25;
				m_icons.add(icon);
				
				var textWidth:Number = BACKING_WIDTH - icon.width;
				
				var name:FlxText = new FlxText(FlxG.width - textWidth, icon.y, textWidth, "");
				name.setFormat("Bertham", 16, 0x000000, "left");
				name.alpha = unlocked ? 1 : 0.5;
				m_names.add(name);
				
				var desc:FlxText = new FlxText(FlxG.width - textWidth, icon.y + icon.height * 0.5, textWidth, "");
				desc.setFormat("Bertham", 16, 0x808080, "left");
				desc.alpha = unlocked ? 1 : 0;
				m_descs.add(desc);
			}
			
			// Hard-coded achievement text! Wooooooo!
			m_names.members[eACHIEVEMENT_NAME-1].text = "What's My Name?";
			m_descs.members[eACHIEVEMENT_NAME-1].text = "Discover her name";
			
			m_shownXPos = FlxG.width - BACKING_WIDTH;
			m_hiddenXPos = FlxG.width - m_icons.members[0].width;
			m_backing = new FlxSprite(m_shownXPos, m_icons.members[0].height);
			var backingHeight:Number = (m_icons.members[NUM_ACHIEVEMENTS - 1].y + m_icons.members[NUM_ACHIEVEMENTS - 1].height) - m_backing.y;
			m_backing.makeGraphic(BACKING_WIDTH, backingHeight, 0xd0ffffff);
			add(m_backing);
			
			add(m_icons);
			add(m_names);
			add(m_descs);
		}
		
		override public function update():void 
		{
			super.update();
			
			var mousePos:FlxPoint = FlxG.mouse.getWorldPosition();
			if (mousePos.x > m_backing.x && mousePos.y > m_backing.y && mousePos.y < m_backing.y + m_backing.height)
			{
				m_targetXPos = m_shownXPos;
			}
			else
			{
				m_targetXPos = m_hiddenXPos;
			}
			
			var achievementLoop:int = 0;
			if ((m_backing.x < m_targetXPos +5 && m_backing.x > m_targetXPos -5) && m_backing.velocity.x != 0)
			{
				// Stop
				m_backing.velocity.x = 0;
				m_backing.x = m_targetXPos;
				for (achievementLoop = 0; achievementLoop < NUM_ACHIEVEMENTS; achievementLoop++)
				{
					m_icons.members[achievementLoop].velocity.x = 0;
					m_names.members[achievementLoop].velocity.x = 0;
					m_descs.members[achievementLoop].velocity.x = 0;
					
					m_icons.members[achievementLoop].x = m_targetXPos;
					m_names.members[achievementLoop].x = m_targetXPos + m_icons.members[achievementLoop].width;
					m_descs.members[achievementLoop].x = m_targetXPos + m_icons.members[achievementLoop].width;
				}
			}
			if (m_backing.x < m_targetXPos && m_backing.velocity.x <= 0)
			{
				// Hide
				m_backing.velocity.x = PANEL_MOVE_SPEED;
				for (achievementLoop = 0; achievementLoop < NUM_ACHIEVEMENTS; achievementLoop++)
				{
					m_icons.members[achievementLoop].velocity.x = PANEL_MOVE_SPEED;
					m_names.members[achievementLoop].velocity.x = PANEL_MOVE_SPEED;
					m_descs.members[achievementLoop].velocity.x = PANEL_MOVE_SPEED;
				}
			}
			else if (m_backing.x > m_targetXPos && m_backing.velocity.x >= 0)
			{
				// Show
				m_backing.velocity.x = -PANEL_MOVE_SPEED;
				for (achievementLoop = 0; achievementLoop < NUM_ACHIEVEMENTS; achievementLoop++)
				{
					m_icons.members[achievementLoop].velocity.x = -PANEL_MOVE_SPEED;
					m_names.members[achievementLoop].velocity.x = -PANEL_MOVE_SPEED;
					m_descs.members[achievementLoop].velocity.x = -PANEL_MOVE_SPEED;
				}
			}
		}
		
		public function awardAchievement(achievementID:int):void
		{
			if (SaveData.getAchievementStatus(achievementID) == false)
			{
				SaveData.setAchievementStatus(true, achievementID);
				
				// TO DO: Unlock notification? Maybe even just a sound
				m_icons.members[achievementID-1].alpha = 1;
				m_descs.members[achievementID-1].alpha = 1;
			}
		}
	}
}