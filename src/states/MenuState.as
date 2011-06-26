package states 
{
	import game.SaveData;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSound;
	import org.flixel.FlxSprite;
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
		
		[Embed(source = '../../data/textures/Background.png')] static public var imgBG:Class;
		[Embed(source = '../../data/textures/Outside.png')] static public var imgOutside:Class;
		
		[Embed(source = '../../data/audio/title.mp3')] private var musicTitle:Class;
		
		private var m_startButton:BubbleButton;
		private var m_eraseButton:BubbleButton;

		// Sound
		private var m_titleMusic:FlxSound;
		
		override public function create():void
		{
			super.create();
			
			FlxG.bgColor = 0xffffffff;
			
			var outside:FlxSprite = new FlxSprite();
			outside.loadGraphic(imgOutside);
			outside.x = FlxG.width - outside.width;
			outside.y = 160;
			add(outside);
			
			var bg:FlxSprite = new FlxSprite();
			bg.loadGraphic(imgBG);
			add(bg);
			
			// Text + logo
			var tMeTxt:FlxText = new FlxText(0, FlxG.height -40, FlxG.width, "A game by Paul S Burgess for Mini-Ludum Dare #27");
			tMeTxt.setFormat("Bertham", 24, 0x000000, "center");
			var tTitle:FlxText = new FlxText(FlxG.width * 0.5, 20, FlxG.width * 0.5 -20, "\"Chance Encounter\"");
			tTitle.setFormat("Bertham", 48, 0x000000, "left", 0xffffff);
			
			m_startButton = new BubbleButton(FlxG.width * 0.5, FlxG.height * 0.5, "PLAY", startGame);
			if (FlxG.debug)
				m_eraseButton = new BubbleButton(FlxG.width -150, FlxG.height -50, "DBG ERASE DATA", eraseData);
			
			add(tMeTxt);
			add(tTitle);
			add(m_startButton);
			if (FlxG.debug)
				add(m_eraseButton);
			
			m_titleMusic = new FlxSound;
			m_titleMusic.loadEmbedded(musicTitle, true);
			m_titleMusic.play(true);
		}
		
		override public function update():void 
		{
			super.update();
			
			m_titleMusic.update();	// Needed for fadeout, seemingly
		}
		
		private function startGame():void
		{
			// Begin fade prior to starting game
			FlxG.fade(0xffffffff, 0.5, onFade);
			m_titleMusic.fadeOut(0.5);
		}
		
		private function eraseData():void
		{
			SaveData.erase();
		}
		
		private function onFade():void
		{
			m_titleMusic.stop();
			FlxG.switchState( new PlayState() );
		}
	}
}