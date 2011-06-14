package states 
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import ui.BubbleButton;
	
	/**
	 * MiniLD 27 - "All Talk"
	 * @author Paul S Burgess - 13/06/11
	 */
	public class MenuState extends FlxState
	{
		[Embed(source = '../../../Bertham.ttf', fontFamily = "Bertham", embedAsCFF = "false")] private var junk:String;
		
		private var m_tStartButton:BubbleButton;
		
		override public function create():void
		{
			super.create();
			
			FlxG.bgColor = 0xffffffff;
			
			// Text + logo
			var tMeTxt:FlxText = new FlxText(0, FlxG.height -40, FlxG.width, "A game by Paul S Burgess for Mini-Ludum Dare #27");
			tMeTxt.setFormat("Bertham", 24, 0x000000, "center");
			var tTitle:FlxText = new FlxText(0, 150, FlxG.width, "\"Chance Encounter\"");
			tTitle.setFormat("Bertham", 96, 0x000000, "center");
			
			m_tStartButton = new BubbleButton(FlxG.width * 0.5, 400, "New Game", startGame);
			
			add(tMeTxt);
			add(tTitle);
			add(m_tStartButton);
		}
		
		private function startGame():void
		{
			// Begin fade prior to starting game
			FlxG.fade(0xffffffff, 0.5, onFade);
		}
		
		private function onFade():void
		{
			FlxG.switchState( new PlayState() );
		}
	}
}