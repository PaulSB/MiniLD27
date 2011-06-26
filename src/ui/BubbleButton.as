package ui 
{
	import flash.events.MouseEvent;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	//import org.flixel.FlxSound;
	import org.flixel.FlxText;
	
	/**
	 * MiniLD 27 - "All Talk"
	 * @author Paul S Burgess - 14/06/11
	 */
	public class BubbleButton extends FlxButton
	{
		[Embed(source = '../../data/textures/ui/BubbleButton.png')] private var imgBubbleButton:Class;
		//[Embed(source = '../../data/audio/thwip.mp3')] private var sfxThwip:Class;
		
		public static var m_lastButtonIDClicked:uint;
		
		public var m_minYpos:Number = 0;
		public var m_buttonSpeed:Number = 0;
		public var m_buttonID:int = -1;
		public var m_thinkingTime:Number = 0;
		
		private var m_buttonTimer:Number = 0;
		
		//private var m_buttonSound:FlxSound;
		
		public function BubbleButton(centreX:Number, centreY:Number, caption:String = null, OnClick:Function = null) 
		{
			var leftX:Number = centreX - 160;
			var topY:Number = centreY - 40;
			super(leftX, topY, caption, OnClick);
			
			label = new FlxText(0,0,320,caption);
			label.setFormat("Bertham",32,0x000000,"center");
			labelOffset = new FlxPoint(0,24);

			loadGraphic(imgBubbleButton, true, false, 320, 80);
			blend = "normal";
			antialiasing = true;
			label.blend = "normal";
			label.antialiasing = true;
			
			allowCollisions = NONE;
			
			//m_buttonSound = new FlxSound;
			//m_buttonSound.loadEmbedded(sfxThwip);
		}
		
		override public function update():void 
		{	
			m_buttonTimer += FlxG.elapsed;
			
			if (y > m_minYpos && velocity.y == 0 && m_buttonTimer > m_thinkingTime)
			{
				velocity.y = m_buttonSpeed;
			}
			
			if (velocity.x != 0.0)
			{
				x += velocity.x * FlxG.elapsed;
			}
			if (velocity.y != 0.0)
			{
				if (velocity.y < 0 && y < m_minYpos)
				{
					velocity.y = 0;
					y = m_minYpos;
				}
				else
				{
					y += velocity.y * FlxG.elapsed;
				}
			}
			
			super.update();
		}
		
		override protected function onMouseUp(event:MouseEvent):void 
		{
			if (status == PRESSED)
			{
				if (m_buttonID > -1)
				{
					// Store off button ID so we know what was just pressed
					m_lastButtonIDClicked = m_buttonID;
				}
				
				super.onMouseUp(event);
			}
		}
		
		public function setupButton(caption:String = null, OnClick:Function = null,	buttonID:int = -1, time:Number = 0.0, speed:Number = 0.0):void
		{
			label.text = caption;
			
			onUp = OnClick;
			
			m_buttonID = buttonID;
			m_thinkingTime = time;
			m_buttonTimer = 0;
			m_buttonSpeed = speed;
			
			velocity.y = 0;
			active = true;
		}
		
		public function setPos(centreX:Number, centreY:Number):void
		{
			x = centreX - 160;
			y = centreY - 40;	
		}
	}
}