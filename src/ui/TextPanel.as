package ui 
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	
	/**
	 * MiniLD 27 - "All Talk"
	 * @author Paul S Burgess - 20/06/11
	 */
	public class TextPanel extends FlxGroup
	{
		[Embed(source = '../../data/textures/ui/TextBox.png')] private var imgBox:Class;
		private const TEXT_INDENT_X:Number = 40.0;
		private const TEXT_INDENT_Y:Number = 20.0;
		
		private var m_label:FlxText;
		private var m_backing:FlxSprite;
		
		public function TextPanel() 
		{
			super();
			
			m_backing = new FlxSprite;
			m_backing.loadGraphic(imgBox);
			
			m_label = new FlxText(0, 0, m_backing.width - TEXT_INDENT_X);
			m_label.setFormat("Bertham", 32, 0x000000, "left");
			
			add(m_backing);
			add(m_label);
		}
		
		public function SetupPanel(posX:Number, posY:Number, text:String):void
		{
			SetPosition(posX, posY);
			m_label.text = text;
			visible = true;
		}
		
		public function SetPosition(posX:Number, posY:Number):void
		{
			m_backing.x = posX;
			m_backing.y = posY;
			m_label.x = posX + TEXT_INDENT_X;
			m_label.y = posY + TEXT_INDENT_Y;
		}
		
		public function GetSize():FlxPoint
		{
			var ret:FlxPoint = new FlxPoint(m_backing.width, m_backing.height);
			return ret;
		}
	}
}