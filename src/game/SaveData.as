package game 
{
	import org.flixel.FlxSave;
	
	/**
	 * MiniLD 27 - "All Talk"
	 * @author Paul S Burgess - 26/06/11
	 */
	public class SaveData
	{
		private static var s_tSave:FlxSave;		// The actual FlxSave object...
		private static var s_bLoaded:Boolean = false;
		private static var s_tTempData:Object;	// Used if save object is inaccessible
		
		public static function load():void
		{
			s_tSave = new FlxSave();
			s_bLoaded = s_tSave.bind("AllTalk_SaveData");
			s_tTempData = new Object();
			
			var array:Array = new Array;
			for (var loop:int = 0; loop < Achievements.NUM_ACHIEVEMENTS; loop++)
			{
				array.push(false);
			}
			s_tTempData.achievementStatus = array;
			
			if (s_bLoaded && s_tSave.data.achievementStatus == null)
			{
				s_tSave.data.achievementStatus = array;
			}
		}
		
		public static function isLoaded():Boolean
		{
			return s_bLoaded;
		}
		
		public static function save():void
		{
			if (s_bLoaded)
			{
				s_tSave.flush();
			}
		}
		
		public static function erase():void
		{
			if (s_bLoaded)
			{
				s_tSave.erase();
			}
		}
		
		public static function setAchievementStatus(status:Boolean, achievementIndex:int):void
		{
			if (s_bLoaded)
			{
				s_tSave.data.achievementStatus[achievementIndex-1] = status;
			}
			else
			{
				s_tTempData.achievementStatus[achievementIndex-1] = status;
			}
		}
		public static function getAchievementStatus(achievementIndex:int):Boolean
		{
			var achievements:Array;
			if (s_bLoaded)
			{
				achievements = s_tSave.data.achievementStatus as Array;
			}
			else
			{
				achievements = s_tTempData.achievementStatus as Array;
			}
				
			return achievements[achievementIndex-1] as Boolean;
		}
	}
}