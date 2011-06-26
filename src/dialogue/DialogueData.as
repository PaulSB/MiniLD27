package dialogue 
{
	import flash.utils.ByteArray;
	
	/**
	 * MiniLD 27 - "All Talk"
	 * @author Paul S Burgess - 19/06/11
	 */
	public class DialogueData
	{
		[Embed(source = '../../data/dialogue.xml', mimeType = "application/octet-stream")] public static const xmlFile:Class;
		
		private var m_xmlData:XML;
		
		public function DialogueData() 
		{
			var file:ByteArray = new xmlFile;
			var str:String = file.readUTFBytes(file.length);
			m_xmlData = new XML(str);
		}
		
		// Node stuff
		
		public function getNodeNameByID(nodeID:uint):String
		{
			var numEntries:int = m_xmlData.nodes.children().length();
			
            var idList:XMLList = m_xmlData.nodes.node.@id;  
            var nameList:XMLList =  m_xmlData.nodes.node.@name;
			
			for (var loop:int = 0; loop < numEntries; loop++)
			{
				if (idList[loop] == nodeID)
				{
					return nameList[loop];
				}
			}
			
			return "INVALID STRING";
		}
		
		public function getButtonIDsByNodeID(nodeID:uint):Array
		{
			var numEntries:int = m_xmlData.nodes.children().length();
			
            var nodeList:XMLList = m_xmlData.nodes.node;
			
			var ret:Array = new Array;
			for (var loop:int = 0; loop < numEntries; loop++)
			{
				var node:XML = nodeList[loop];
				if (node.@id == nodeID)
				{
					var buttonList:XMLList =  node.buttonid;
					for (loop = 0; loop < buttonList.length(); loop++)
					{
						var id:uint = buttonList[loop];
						ret.push(id);
					}

					break;
				}
			}
			
			return ret;
		}
		
		// Button stuff
		
		public function getNumberOfButtons():int
		{
			return m_xmlData.buttons.children().length();
		}
		
		public function getButtonTextByName(stringID:String):String
		{
			var numEntries:int = m_xmlData.buttons.children().length();
			
            var nameList:XMLList = m_xmlData.buttons.button.@name;  
            var textList:XMLList =  m_xmlData.buttons.button.@text;
			
			for (var loop:int = 0; loop < numEntries; loop++)
			{
				if (nameList[loop] == stringID)
				{
					return textList[loop];
				}
			}
			
			return "INVALID STRING";
		}
		public function getButtonTextByID(ID:uint):String
		{
			var numEntries:int = m_xmlData.buttons.children().length();
			
            var idList:XMLList = m_xmlData.buttons.button.@id;  
            var textList:XMLList =  m_xmlData.buttons.button.@text;
			
			for (var loop:int = 0; loop < numEntries; loop++)
			{
				if (idList[loop] == ID)
				{
					return textList[loop];
				}
			}
			
			return "INVALID STRING";
		}
		
		public function getButtonTimeByName(stringID:String):uint
		{
			var numEntries:int = m_xmlData.buttons.children().length();
			
            var nameList:XMLList = m_xmlData.buttons.button.@name;  
            var timeList:XMLList =  m_xmlData.buttons.button.@time;
			
			for (var loop:int = 0; loop < numEntries; loop++)
			{
				if (nameList[loop] == stringID)
				{
					return timeList[loop];
				}
			}
			
			return 0;
		}
		public function getButtonTimeByID(ID:uint):uint
		{
			var numEntries:int = m_xmlData.buttons.children().length();
			
            var idList:XMLList = m_xmlData.buttons.button.@id;
            var timeList:XMLList =  m_xmlData.buttons.button.@time;
			
			for (var loop:int = 0; loop < numEntries; loop++)
			{
				if (idList[loop] == ID)
				{
					return timeList[loop];
				}
			}
			
			return 0;
		}
		
		public function getPlayerTextByButtonID(id:uint):String
		{
			var numEntries:int = m_xmlData.buttons.children().length();
			
            var idList:XMLList = m_xmlData.buttons.button.@id;  
            var bodyList:XMLList =  m_xmlData.buttons.button.body;
			
			for (var loop:int = 0; loop < numEntries; loop++)
			{
				if (idList[loop] == id)
				{
					return bodyList[loop];
				}
			}
			
			return "INVALID STRING";
		}
		
		public function getNPCTextByButtonID(id:uint, comfort:uint):String
		{
			var numEntries:int = m_xmlData.buttons.children().length();
			
            var idList:XMLList = m_xmlData.buttons.button.@id;

			for (var loop:int = 0; loop < numEntries; loop++)
			{
				if (idList[loop] == id)
				{
					var button:XML = m_xmlData.buttons.button[loop];
					
					var comfortList:XMLList = button.responses.response.@comfort;
					var bodyList:XMLList =  button.responses.response.body;
					
					for (loop = 0; loop < bodyList.length(); loop++)
					{
						if (comfortList[loop] <= comfort)
							return bodyList[loop];
					}
					
					break;
				}
			}
			
			return "INVALID STRING";
		}
		
		public function getNextNodeByButtonID(id:uint, comfort:uint):uint
		{
			var numEntries:int = m_xmlData.buttons.children().length();
			
            var idList:XMLList = m_xmlData.buttons.button.@id;  
			
			for (var loop:int = 0; loop < numEntries; loop++)
			{
				if (idList[loop] == id)
				{
					var button:XML = m_xmlData.buttons.button[loop];
					
					var comfortList:XMLList = button.responses.response.@comfort;
					var nodeList:XMLList =  button.responses.response.nextnode;
					
					for (loop = 0; loop < nodeList.length(); loop++)
					{
						if (comfortList[loop] <= comfort)
							return nodeList[loop];
					}
					
					break;
				}
			}
			
			return 0;
		}
		
		public function getComfortBonusByButtonID(id:uint, comfort:uint):int
		{
			var numEntries:int = m_xmlData.buttons.children().length();
			
            var idList:XMLList = m_xmlData.buttons.button.@id;  
			
			for (var loop:int = 0; loop < numEntries; loop++)
			{
				if (idList[loop] == id)
				{
					var button:XML = m_xmlData.buttons.button[loop];
					
					var comfortList:XMLList = button.responses.response.@comfort;
					var bonusList:XMLList = button.responses.response.comfortbonus;
					
					for (loop = 0; loop < bonusList.length(); loop++)
					{
						if (comfortList[loop] <= comfort)
							return bonusList[loop];
					}
					
					break;
				}
			}
			
			return 0;
		}
		
		public function getAchievementByButtonID(id:uint, comfort:uint):int
		{
			var numEntries:int = m_xmlData.buttons.children().length();
			
            var idList:XMLList = m_xmlData.buttons.button.@id;  
			
			for (var loop:int = 0; loop < numEntries; loop++)
			{
				if (idList[loop] == id)
				{
					var button:XML = m_xmlData.buttons.button[loop];
					
					var comfortList:XMLList = button.responses.response.@comfort;
					var awardList:XMLList = button.responses.response.achievement;
					
					for (loop = 0; loop < awardList.length(); loop++)
					{
						if (comfortList[loop] <= comfort)
							return awardList[loop];
					}
					
					break;
				}
			}
			
			return 0;
		}
	}
}