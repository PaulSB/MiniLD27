package states 
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
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
			
			FlxG.bgColor = 0xffffffff;
			var bg:FlxSprite = new FlxSprite();
			bg.loadGraphic(MenuState.imgBG);
			add(bg);
			
			FlxG.flash(0xffffffff, 0.5, onUnFade);
		}
		
		private function onUnFade():void
		{
			// Begin game
		}
	}
}