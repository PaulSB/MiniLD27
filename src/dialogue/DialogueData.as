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
		
		public function getFullTextByID(id:uint):String
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
	}
}