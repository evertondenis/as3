package com.evertondenis.display 
{
	import flash.display.MovieClip;
	import com.evertondenis.events.MyLoaderEvent;
	import com.evertondenis.utils.MyLoader;
	import com.greensock.TweenLite;

	import flash.display.Sprite;

	/**
	 * @author Everton Denis
	 * @since 27/07/2010
	 */
	public class ImageDisplay extends Sprite 
	{
		public var bgMc:MovieClip;
		public var bgContPic:MovieClip;
		public var exitBtn:MovieClip;
		
		// PRIVATE VARIABLES
		private var _loader:MyLoader;

		//----------------------------------------------
		// CONSTRUCTOR
		//----------------------------------------------
		public function ImageDisplay(pic:String = null)
		{
			bgMc.alpha = .8;
			exitBtn.buttonMode = true;
			exitBtn.mouseChildren = false;
			loaderPic(pic);
		}

		//----------------------------------------------
		// PRIVATE METHODS
		//----------------------------------------------
		
		// LOADER PIC METHOD
		private function loaderPic(value:String):void 
		{
			_loader = new MyLoader(this, false, true, 200);
			//_loader.addEventListener(ProgressEvent.PROGRESS, loaderProgress);
			_loader.addEventListener(MyLoaderEvent.COMPLETE, loaderComplete);
			_loader.load(value);
		}
		
		//----------------------------------------------
		// EVENTS HANDLERS
		//----------------------------------------------
		
		// Complete loader Pic handler
		private function loaderComplete(event:MyLoaderEvent):void 
		{
			event.content.alpha = 0;
			
			bgContPic.width = event.content.width + 10;
			bgContPic.height = event.content.height + 10;
			bgContPic.x = (0 - bgContPic.width) * .5;
			bgContPic.y = ((0 - bgContPic.height) * .5) - 50;
			
			event.content.x = bgContPic.x + 5;
			event.content.y = bgContPic.y + 5;
			
			exitBtn.x = (bgContPic.x + bgContPic.width) - 51;
			exitBtn.y = (bgContPic.y - 22);
			
			addChild(event.content);
			TweenLite.to(event.content, 0.3, {alpha:1, delay:0.2});
		}
	}
}
