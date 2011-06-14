package ui 
{
	import org.flixel.FlxButton;
	import org.flixel.FlxPoint;
	import org.flixel.FlxText;
	
	/**
	 * MiniLD 27 - "All Talk"
	 * @author Paul S Burgess - 14/06/11
	 */
	public class BubbleButton extends FlxButton
	{
		[Embed(source = '../../data/BubbleButton.png')] private var imgBubbleButton:Class;
		
		public function BubbleButton(centreX:Number, centreY:Number, caption:String = null, OnClick:Function = null) 
		{
			var leftX:Number = centreX - 160;
			var topY:Number = centreY - 40;
			super(leftX, topY, caption, OnClick);
			
			if(caption != null)
			{
				label = new FlxText(0,0,320,caption);
				label.setFormat("Bertham",32,0x333333,"center");
				labelOffset = new FlxPoint(0,24);
			}
			loadGraphic(imgBubbleButton,true,false,320,80);
		}
	}
}