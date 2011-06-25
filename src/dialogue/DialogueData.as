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
		
		public function getButtonIDByNodeID(nodeID:uint):uint
		{
			var numEntries:int = m_xmlData.nodes.children().length();
			
            var idList:XMLList = m_xmlData.nodes.node.@id;
            var buttonList:XMLList =  m_xmlData.nodes.node.buttonid;
			
			for (var loop:int = 0; loop < numEntries; loop++)
			{
				if (idList[loop] == nodeID)
				{
					return buttonList[loop];	// TODO: be able to get all buttons, not just one
				}
			}
			
			return 0;
		}
		
		// Button stuff
		
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
		
		public function getNPCTextByButtonID(id:uint):String
		{
			var numEntries:int = m_xmlData.buttons.children().length();
			
            var idList:XMLList = m_xmlData.buttons.button.@id;  
            var bodyList:XMLList =  m_xmlData.buttons.button.responses.response.body;
			
			for (var loop:int = 0; loop < numEntries; loop++)
			{
				if (idList[loop] == id)
				{
					return bodyList[loop];
				}
			}
			
			return "INVALID STRING";
		}
		
		public function getNextNodeByButtonID(id:uint):uint
		{
			var numEntries:int = m_xmlData.buttons.children().length();
			
            var idList:XMLList = m_xmlData.buttons.button.@id;  
            var nodeList:XMLList =  m_xmlData.buttons.button.responses.response.nextnode;
			
			for (var loop:int = 0; loop < numEntries; loop++)
			{
				if (idList[loop] == id)
				{
					return nodeList[loop];
				}
			}
			
			return 0;
		}
	}
}