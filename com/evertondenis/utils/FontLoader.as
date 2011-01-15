package com.evertondenis.utils
{

	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;


	public class FontLoader extends MovieClip
	{
		private var _loader:Loader;
		
		public function FontLoader(__url:String)
		{
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			_loader.load(new URLRequest(__url));
		}
		
		private function onComplete(event:Event):void
		{
			var fontLib:Class = event.target.applicationDomain.getDefinition("NormalFont") as Class;
			var font:Font = new fontLib;
			
			Font.registerFont(fontLib);
			
			var temp_txt:TextField = new TextField();
			addChild(temp_txt);
			
			temp_txt.x = stage.stageWidth >> 1; // o mesmo que stage.stageWidth / 2 porem mais rápido
			temp_txt.y = stage.stageHeight >> 1;
			temp_txt.autoSize = TextFieldAutoSize.LEFT;
			
			var tf:TextFormat = new TextFormat(font.fontName, 20);
			
			temp_txt.defaultTextFormat = tf;
			temp_txt.embedFonts = true;
			temp_txt.text = "HELLO FONT WORLD!";
		}
	}

}

/*
Cria um *.swf com a font a ser usada.

var font:FontLoader = new FontLoader("font.swf");
addChild(font);

*/