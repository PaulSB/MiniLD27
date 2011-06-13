package states 
{
	
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
		[Embed(source = '../../../Bertham.ttf', fontFamily = "Bailey", embedAsCFF = "false")] private var junk:String;
		
		private var m_tStartButton:FlxText;
		
		override public function create():void
		{
			super.create();
			
			FlxG.bgColor = 0xffffffff;
			
			// Text + logo
			var tMeTxt:FlxText = new FlxText(0, FlxG.height -40, FlxG.width, "A game by Paul S Burgess for Mini-Ludum Dare #27");
			tMeTxt.setFormat("Bailey", 24, 0x000000, "center");
			var tTitle:FlxText = new FlxText(0, 100, FlxG.width, "\"Chance Encounter\"");
			tTitle.setFormat("Bailey", 96, 0x000000, "center");
			
			m_tStartButton = new FlxText(0, 350, FlxG.width, "NEW GAME");
			m_tStartButton.setFormat("Bailey", 48, 0x000000, "center");
			
			add(tMeTxt);
			add(tTitle);
			add(m_tStartButton);
		}
		
		override public function update():void
		{
			super.update();
		}
	}
}