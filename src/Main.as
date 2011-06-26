package 
{
	import game.SaveData;
	import flash.ui.Mouse;
	import org.flixel.FlxG;
	import org.flixel.FlxGame;
	import states.MenuState;
	
	/**
	 * MiniLD 27 - "All Talk"
	 * @author Paul S Burgess - 13/06/11
	 */

	// Display properties
	[SWF(width = "800", height = "600", backgroundColor = "#ffffff")]
	// Prep preloader
	[Frame(factoryClass="Preloader")]
	
	public class Main extends FlxGame
	{
		public function Main()
		{			
			// Entry - invoke FlxGame constructor
			super(800, 600, MenuState, 1, 60, 30, true);
			
			// Load any save data
			SaveData.load();
		}
	}
}