package ui 
{
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxText;
	
	/**
	 * MiniLD 27 - "All Talk"
	 * @author Paul S Burgess - 14/06/11
	 */
	public class BubbleButton extends FlxButton
	{
		[Embed(source = '../../data/textures/BubbleButton.png')] private var imgBubbleButton:Class;
		
		public var m_minYpos:Number = 0.0;
		
		public function BubbleButton(centreX:Number, centreY:Number, caption:String = null, OnClick:Function = null) 
		{
			var leftX:Number = centreX - 160;
			var topY:Number = centreY - 40;
			super(leftX, topY, caption, OnClick);
			
			label = new FlxText(0,0,320,caption);
			label.setFormat("Bertham",32,0x000000,"center");
			labelOffset = new FlxPoint(0,24);

			loadGraphic(imgBubbleButton, true, false, 320, 80);
			
			allowCollisions = NONE;
		}
		
		override public function update():void 
		{
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
		
		public function setPos(centreX:Number, centreY:Number):void
		{
			x = centreX - 160;
			y = centreY - 40;	
		}
	}
}