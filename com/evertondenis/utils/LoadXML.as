package com.evertondenis.utils
{
	import flash.display.Sprite;
	import flash.events.*;
	import flash.net.*;
	import flash.system.System;

	/**
	@author: Celina Uemura aka cezinha 
	e-mail: cezinha@cezinha.com.br
	site: http://www.cezinha.com.br
	created: 24/Oct/2008
	
	This class loads XML, checks the preload and complete, dispatch these events and return a XML string. 
	
	Usage example: 
	
	var myxml:LoadXML = new LoadXML('example.xml');
	myxml.addEventListener(Event.COMPLETE, completeHandler);
	myxml.addEventListener(ProgressEvent.PROGRESS, progressHandler);
	
	function completeHandler(e:Event) {
		trace("XML returned:");
		trace(e.target.xml);
	}
	
	function progressHandler(e:ProgressEvent) {
		trace(e.target.percent);
	}
	
	*/
	public class LoadXML extends Sprite
	{
		private var _loaded:Boolean;
		private var _percent:Number;
		private var _xml:XML;

		public function LoadXML(xmlfile:String)
		{
			// sets the UTF-8 support
			System.useCodePage = true;
			_loaded = false;
			_xml = null;
			_percent = 0;
			
			var loader:URLLoader=new URLLoader();
			configureListeners(loader);

			var request:URLRequest=new URLRequest(xmlfile);
			try
			{
				loader.load(request);
			}
			catch (error:Error)
			{
				trace("Unable to load requested document.");
			}
		}

		private function configureListeners(dispatcher:IEventDispatcher):void
		{
			// dispatches events, if you want to use all events, use this in your instance.
			dispatcher.addEventListener(Event.COMPLETE,completeHandler);
			dispatcher.addEventListener(Event.OPEN, openHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}

		private function completeHandler(event:Event):void
		{
			_loaded = true;
			var loader:URLLoader=URLLoader(event.target);
			_xml=new XML(loader.data);
			_xml.ignoreWhite = true;
			_percent = 100;
			dispatchEvent(new Event(Event.COMPLETE));
		}

		private function openHandler(event:Event):void {
			//trace("openHandler: " + event);
			dispatchEvent(event);
		}

		private function progressHandler(event:ProgressEvent):void {
			//trace("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
			_percent = Math.round(event.bytesLoaded / event.bytesTotal * 100);
			dispatchEvent(event);
		}

		private function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("securityErrorHandler: " + event);
			dispatchEvent(event);
		}

		private function httpStatusHandler(event:HTTPStatusEvent):void {
			//trace("httpStatusHandler: " + event);
			dispatchEvent(event);
		}

		private function ioErrorHandler(event:IOErrorEvent):void {
			trace("ioErrorHandler: " + event);
			dispatchEvent(event);
		}

		public function get loaded():Boolean
		{
			return _loaded;
		}
		
		public function get percent():Number
		{
			return _percent;
		}
		
		public function get xml():XML
		{
			return _xml;
		}
	}
}