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
	}
}