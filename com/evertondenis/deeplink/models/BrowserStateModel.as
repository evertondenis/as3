package com.evertondenis.deeplink.models
{
	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;

	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class BrowserStateModel extends EventDispatcher
	{
		static private var _instance:BrowserStateModel;
		public var path:String;

		private var _arrNavPath:Array;
		private var _arrHistoryPath:Array;
		private var _arrNewNavPath:Array;
		private var _strValue:String;
		private var _boolInit:Boolean = false;

		public function BrowserStateModel(enforcer:SingletonEnforcer)
		{
			SWFAddress.addEventListener(SWFAddressEvent.CHANGE, onSWFAddress);
			_arrNavPath = [];
			_arrHistoryPath = [];
		}

		public static function getInstance():BrowserStateModel 
		{			
			if(BrowserStateModel._instance == null) 
			{
				BrowserStateModel._instance = new BrowserStateModel(new SingletonEnforcer());
			}
			
			return BrowserStateModel._instance;
		}

		// ----- Public API ----- //	
		public function setPath(strPath:String):void 
		{
					
			SWFAddress.setValue(strPath);
		}

		public function updateHistory():void 
		{
			
			_arrHistoryPath = _arrNewNavPath;
		}

		public function getHistory(intNavLevel:int):String 
		{
			return _arrHistoryPath[intNavLevel];
		}

		public function getCurrentPath(intNavLevel:int):String 
		{
			return _arrNavPath[intNavLevel];
		}

		public function getNewPath(intNavLevel:int):String 
		{
			return _arrNewNavPath[intNavLevel];
			
			// store value to nav path...
			_arrNavPath[intNavLevel] = _arrNewNavPath[intNavLevel];
		}

		// ----- Event Handlers ----- //
		private function onSWFAddress(e:SWFAddressEvent):void 
		{
			e.stopPropagation();

			var strValue:String = e.value;
			_arrNewNavPath = strValue.split("/");
			
			dispatchEvent(new Event(Event.CHANGE));
		}
	}
}

class SingletonEnforcer 
{
}