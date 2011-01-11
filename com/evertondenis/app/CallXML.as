package com.evertondenis.app
{
	import com.evertondenis.utils.LoadXML;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	
	public class CallXML extends Sprite
	{
		private var _xml:LoadXML;
		
		public function CallXML()
		{
			
		}
		
		public function set xmlPath(value:String):void
		{
			_xml = new LoadXML(value);
			_xml.addEventListener(Event.COMPLETE, completeHandler);
			_xml.addEventListener(ProgressEvent.PROGRESS, progressHandler);
		}
		
		private function completeHandler(event:Event):void
		{
			trace("XML returned:");
			trace(e.target.xml);
			return(e.target.xml);
		}
		
		private function progressHandler(event:ProgressEvent):void
		{
			trace(e.target.percent);	
		}

	}
}