package game 
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSound;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	
	/**
	 * MiniLD 27 - "All Talk"
	 * @author Paul S Burgess - 26/06/11
	 */
	public class Achievements extends FlxGroup
	{
		[Embed(source = '../../data/textures/ui/Achievement.png')] private var imgIcon:Class;
		[Embed(source = '../../data/audio/award.mp3')] private var sfxAward:Class;
		
		public const eACHIEVEMENT_NAME:int = 1;
		public const eACHIEVEMENT_POWERS:int = 2;
		public const eACHIEVEMENT_LIKED:int = 3;
		public const eACHIEVEMENT_LOVED:int = 4;
		public const eACHIEVEMENT_STUDENT:int = 5;
		public const eACHIEVEMENT_ALONE:int = 6;
		public const eACHIEVEMENT_APPLES:int = 7;
		public const eACHIEVEMENT_RANOUT:int = 8;
		public const eACHIEVEMENT_STAREOFF:int = 9;
		public const eACHIEVEMENT_HATE:int = 10;
		public const eACHIEVEMENT_MUDKIPZ:int = 11;
		
		static public const NUM_ACHIEVEMENTS:int = 11;
		
		private const BACKING_WIDTH:Number = 300.0;
		private const PANEL_MOVE_SPEED:Number = 200.0;
		
		// Graphic objects
		private var m_backing:FlxSprite;
		private var m_icons:FlxGroup;
		private var m_names:FlxGroup;
		private var m_descs:FlxGroup;
		
		private var m_shownXPos:Number;
		private var m_hiddenXPos:Number;
		private var m_targetXPos:Number;
		
		private var m_awardSound:FlxSound;
		
		public function Achievements() 
		{
			super();
			
			m_awardSound = new FlxSound;
			m_awardSound.loadEmbedded(sfxAward);
			
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
			m_descs.members[eACHIEVEMENT_NAME-1].text = "Discovered her name";
			m_names.members[eACHIEVEMENT_POWERS-1].text = "I Have the Powers!";
			m_descs.members[eACHIEVEMENT_POWERS - 1].text = "I am an international man of mystery";
			m_names.members[eACHIEVEMENT_LIKED-1].text = "Someone likes me";
			m_descs.members[eACHIEVEMENT_LIKED-1].text = "Made a friend";
			m_names.members[eACHIEVEMENT_LOVED - 1].text = "Someone REALLY likes me";
			m_descs.members[eACHIEVEMENT_LOVED - 1].text = "Had her enthralled by my wit";
			m_names.members[eACHIEVEMENT_STUDENT-1].text = "Intuition";
			m_descs.members[eACHIEVEMENT_STUDENT - 1].text = "Correctly guessed she is a student";
			m_names.members[eACHIEVEMENT_ALONE-1].text = "Forever Alone";
			m_descs.members[eACHIEVEMENT_ALONE-1].text = "Didn't even talk to her :'(";
			m_names.members[eACHIEVEMENT_APPLES-1].text = "How You Like Them Apples?";
			m_descs.members[eACHIEVEMENT_APPLES - 1].text = "Got her number";
			m_names.members[eACHIEVEMENT_RANOUT-1].text = "I Have No Words";
			m_descs.members[eACHIEVEMENT_RANOUT - 1].text = "Ran out of things to say!";
			m_names.members[eACHIEVEMENT_STAREOFF-1].text = "Steel Gaze";
			m_descs.members[eACHIEVEMENT_STAREOFF - 1].text = "Conducted a staring contest";
			m_names.members[eACHIEVEMENT_HATE-1].text = "Someone Doesn't Like Me At All";
			m_descs.members[eACHIEVEMENT_HATE - 1].text = "Ouch";
			m_names.members[eACHIEVEMENT_MUDKIPZ-1].text = "Mudkipz?";
			m_descs.members[eACHIEVEMENT_MUDKIPZ-1].text = "She did NOT leik mudkipz";
			
			m_shownXPos = FlxG.width - BACKING_WIDTH;
			m_hiddenXPos = FlxG.width - m_icons.members[0].width;
			m_backing = new FlxSprite(m_shownXPos, m_icons.members[0].height);
			var backingHeight:Number = (m_icons.members[NUM_ACHIEVEMENTS - 1].y + m_icons.members[NUM_ACHIEVEMENTS - 1].height) - m_backing.y;
			m_backing.makeGraphic(BACKING_WIDTH, backingHeight, 0xdfffffff);
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
				m_awardSound.play();
				
				SaveData.setAchievementStatus(true, achievementID);
				
				m_icons.members[achievementID - 1].alpha = 1;
				m_names.members[achievementID - 1].alpha = 1;
				m_descs.members[achievementID - 1].alpha = 1;
			}
		}
	}
}