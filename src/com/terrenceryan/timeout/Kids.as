package com.terrenceryan.timeout
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.xml.SimpleXMLDecoder;
	import mx.rpc.xml.SimpleXMLEncoder;
	import mx.utils.ArrayUtil;
	
	[Event(name="result", type="flash.events.Event")]

	public class Kids extends EventDispatcher
	{
		
		private var _list:ArrayCollection = new ArrayCollection();
		private const FILENAME:String = "kids.xml";
		
		
		public function Kids(){
			
		}
		
		public function initList():void{
			read();
		}
		
		
		public function get list():ArrayCollection
		{
			return _list;
		}

		public function set list(value:ArrayCollection):void
		{
			_list = value;
		}
		
		
		public function save(obj:Kid, position:int=-1):void{
			if (position == -1){
				_list.addItem(obj);	
			}
			else{
				_list.setItemAt(obj,position);
			}
			write();	
			
			
		}
		
		public function destroy(position:int=-1):void{
			_list.removeItemAt(position);
			write();	
			
			
		}
		
		private function kidsToXML(kids:ArrayCollection):String {
			
			var result:String = '<?xml version="1.0" encoding="utf-8"?>\n';
			result += '<kids>\n';
			
			for (var i:int=0; i < kids.length; i++ ){
				result += '\t<kid>\n';
				result += '\t\t<name>'+ kids[i].name +'</name>\n';
				result += '\t\t<timeout>'+ kids[i].timeout +'</timeout>\n';
				result += '\t</kid>\n';
			}
			
			
			result += '</kids>';
			
			return result;
		}
		
		
		private function write():void{
			
			var listXML:String = kidsToXML(_list);
			var file:File = File.applicationStorageDirectory.resolvePath(FILENAME);
			if (file.exists)
				file.deleteFile();
			var fileStream:FileStream = new FileStream(); //create a file stream
			fileStream.open(file, FileMode.WRITE);// and open the file for write
			fileStream.writeUTFBytes(listXML);
			fileStream.close();
			
			
		}

		private function read():void {
			//read the file
			var file:File = File.applicationStorageDirectory.resolvePath(FILENAME);
			if (file.exists) {
				//create a file stream and open it for reading
				var fileStream:FileStream = new FileStream();
				fileStream.open(file, FileMode.READ);
				var kidsXML:XML = XML(fileStream.readUTFBytes(fileStream.bytesAvailable));
				var temp:ArrayCollection = convertXmlToArrayCollection(kidsXML);
				_list = convertACtoACofKid(temp);				
			}
			onResultComplete();
			
		}
		
		private function convertXmlToArrayCollection( file:String ):ArrayCollection
		{
			var xml:XMLDocument = new XMLDocument( file );
			var decoder:SimpleXMLDecoder = new SimpleXMLDecoder();
			var data:Object = decoder.decodeXML( xml );
			
			if (data == null){
				array = new Array();	
			}
			else{
				var array:Array = ArrayUtil.toArray(data.kids.kid);
			}
			return new ArrayCollection( array );
		}
		
		private function convertACtoACofKid(ac:ArrayCollection):ArrayCollection{
			var result:ArrayCollection = new ArrayCollection();
			
			for (var i:int = 0; i < ac.length; i++){
				var tmp:Kid = new Kid();
				tmp.name = ac[i].name;
				tmp.timeout = ac[i].timeout;
				result.addItemAt(tmp,i); 
			}
			return result;
		}

		public function onResultComplete():void {
			trace("dispatching event..");
			dispatchEvent(new Event("result",true));
		}
	}
}