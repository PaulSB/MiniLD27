package ui 
{
	import org.flixel.FlxG;
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
		[Embed(source = '../../data/textures/ui/TextBox_prompt.png')] private var imgPrompt:Class;
		
		private const TEXT_INDENT_X:Number = 25.0;
		private const TEXT_INDENT_Y:Number = 12.5;
		private const TEXT_TYPE_LETTER_INTERVAL:Number = 0.1;
		
		private var m_text:String;
		private var m_cursorPos:int = 0;
		private var m_label:FlxText;
		private var m_backing:FlxSprite;
		private var m_prompt:FlxSprite = null;
		
		private var m_promptPressed:Boolean = false;
		private var m_promptCallback:Function;
		private var m_readyToProceed:Boolean = false;
		private var m_readoutTimer:Number = 0;
		
		public function TextPanel(showPrompt:Boolean = false) 
		{
			super();
			
			m_backing = new FlxSprite;
			m_backing.loadGraphic(imgBox);
			
			m_label = new FlxText(0, 0, m_backing.width - TEXT_INDENT_X);
			m_label.setFormat("Bertham", 32, 0x000000, "left");
			
			add(m_backing);
			add(m_label);
			
			if (showPrompt)
			{
				m_prompt = new FlxSprite;
				m_prompt.loadGraphic(imgPrompt);
				m_prompt.alpha = 0.8;
				
				add(m_prompt);
			}
		}
		
		override public function update():void 
		{
			if (!m_readyToProceed)
			{
				if (m_text)
				{
					m_readoutTimer -= FlxG.elapsed;
					
					if (m_readoutTimer <= 0.0)
					{
						if (m_cursorPos < m_text.length)
						{
							m_label.text = m_label.text + m_text.charAt(m_cursorPos++);
							m_readoutTimer = TEXT_TYPE_LETTER_INTERVAL;
						}
						else
						{
							m_readyToProceed = true;
							if (m_prompt)
								m_prompt.visible = true;
						}
					}
				}
			}
			else if (m_prompt)
			{
				// Update highlighting
				if (m_prompt.alpha < 1.0)
				{
					if((FlxG.mouse.x > m_prompt.x && FlxG.mouse.x < m_prompt.x + m_prompt.width)
						&& (FlxG.mouse.y > m_prompt.y && FlxG.mouse.y < m_prompt.y + m_prompt.height))
					{
						m_prompt.alpha = 1.0;
					}
				}
				else
				{
					if(!(FlxG.mouse.x > m_prompt.x && FlxG.mouse.x < m_prompt.x + m_prompt.width)
						|| !(FlxG.mouse.y > m_prompt.y && FlxG.mouse.y < m_prompt.y + m_prompt.height))
					{
						m_prompt.alpha = 0.8;
					}
				}
				
				// Check press
				if (FlxG.mouse.justPressed())
				{
					if((FlxG.mouse.x > m_prompt.x && FlxG.mouse.x < m_prompt.x + m_prompt.width)
						&& (FlxG.mouse.y > m_prompt.y && FlxG.mouse.y < m_prompt.y + m_prompt.height))
					{
						m_promptCallback();
					}
				}
			}
			
			super.update();
		}
		
		public function SetupPanel(posX:Number, posY:Number, text:String, clickCB:Function = null):void
		{
			SetPosition(posX, posY);
			m_label.text = "";
			m_text = text;
			visible = true;
			
			m_promptPressed = false;
			m_promptCallback = clickCB;
			m_readyToProceed = false;
			m_readoutTimer = TEXT_TYPE_LETTER_INTERVAL;
			m_cursorPos = 0;
			if (m_prompt)
				m_prompt.visible = false;
		}
		
		public function SetPosition(posX:Number, posY:Number):void
		{
			m_backing.x = posX;
			m_backing.y = posY;
			m_label.x = posX + TEXT_INDENT_X;
			m_label.y = posY + TEXT_INDENT_Y;
			if (m_prompt)
			{
				m_prompt.x = posX + m_backing.width - m_prompt.width;
				m_prompt.y = posY + m_backing.height - m_prompt.height -0;
			}
		}
		
		public function GetSize():FlxPoint
		{
			var ret:FlxPoint = new FlxPoint(m_backing.width, m_backing.height);
			return ret;
		}
	}
}