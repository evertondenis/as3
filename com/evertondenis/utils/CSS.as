/*
This class loads and parses the CSS file. 
To use this class in any other projects;
----------------------------------------
-- import keremk.CSSLoader

-- var css:CSSLoader = new CSSLoader;
-- css.load("YOUR_CSS_PATH");

-- yourTextField.styleSheet = css.sheet;
----------------------------------------
you don't need to change anything below


This class dispatches events;
"CSS_SecurityError"		-> occurs when css file couldn't be loaded due to security policies.
"CSS_IOError"			-> occurs when css file couldn't be found in defined path.
"CSS_Loaded"			-> occurs when css file was loaded successfully.
"CSS_ParseError"		-> occurs when css file has problems and needs debugging.
*/

package com.evertondenis.utils 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.StyleSheet;

	public class CSS extends EventDispatcher {
		private var loader:URLLoader;
		public var sheet:StyleSheet;
		
		public function CSS():void {
			loader = new URLLoader;
		}
		public function load(_req:String):void {
			loader.load(new URLRequest(_req));
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, secError);
			loader.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			loader.addEventListener(Event.COMPLETE,loaded);
		}
		private function ioError(e:IOErrorEvent):void {
			dispatchEvent(new Event("CSS_IOError"));
		}
		private function secError(e:SecurityErrorEvent):void {
			dispatchEvent(new Event("CSS_SecurityError"));
		}
		private function loaded(e:Event):void {
			try {
				sheet = new StyleSheet();
				sheet.parseCSS(loader.data);
				dispatchEvent(new Event("CSS_Loaded"));
			} catch (e:Error) {
				dispatchEvent(new Event("CSS_ParseError"));
			}
		}
	}
}