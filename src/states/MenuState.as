package states 
{
	//import flash.ui.Mouse;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	//import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	/**
	 * MiniLD 27 - "All Talk"
	 * @author Paul S Burgess - 13/06/11
	 */
	public class MenuState extends FlxState
	{
		//[Embed(source = '../../../Swizzle Script.TTF', fontFamily = "SwizzleScript", embedAsCFF = "false")] private var junk:String;
		
		private var m_tStartButton:FlxText;
		
		override public function create():void
		{
			super.create();
			
			FlxG.bgColor = 0xffffff;
		}
		
		override public function update():void
		{
			super.update();
		}
	}
}