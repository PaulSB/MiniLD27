package states 
{
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	
	/**
	 * MiniLD 27 - "All Talk"
	 * @author Paul S Burgess - 14/06/11
	 */
	public class PlayState extends FlxState
	{
		override public function create():void
		{
			super.create();
			
			FlxG.bgColor = 0xffa0a0a0;	// TEMP for debug
			
			FlxG.flash(0xffffffff, 0.5, onUnFade);
		}
		
		private function onUnFade():void
		{
			// Begin game
		}
	}
}