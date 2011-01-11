package com.evertondenis.display 
{
	import noponies.display.NpFullBrowserXShow;
	import noponies.utils.LoadXmlToArray;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;

	/**
	 * @author Everton Denis
	 */
	public class SlideFullBackground extends MovieClip 
	{
		private var _xml:LoadXmlToArray;
		private var _bgSlideShow:NpFullBrowserXShow;
		private var loaderBg:MovieClip;

		public function SlideFullBackground(xmlurl:String, loadermc:MovieClip)
		{
			loaderBg = loadermc;
			loaderXML(xmlurl);
		}

		private function loaderXML(xmlurl:String):void 
		{
			_xml = new LoadXmlToArray(xmlurl);
			_xml.addEventListener("xmlParsed", initSlides);
		}

		private function initSlides(event:Event):void 
		{
			// instantiate slideShow
			_bgSlideShow = new NpFullBrowserXShow(_xml.imagesArray);
			_bgSlideShow.imageFadeTime = 2;
			_bgSlideShow.imageDisplayTime = 8;
			_bgSlideShow.randomPlayBack = true;
			_bgSlideShow.slidesLoop = true;
			_bgSlideShow.autoPlay = true;
			_bgSlideShow.slideAlignX = 1;
			_bgSlideShow.slideAlignY = 1;
			addChild(_bgSlideShow);
			
			// configure listeners
			_bgSlideShow.addEventListener(NpFullBrowserXShow.PROGRESS, handleProgEvent);
		}
		
		private function handleProgEvent(event:ProgressEvent):void
		{
			//trace(100 * event.bytesLoaded / event.bytesTotal);
			if (uint(100 * event.bytesLoaded / event.bytesTotal) == 100)
			{
				loaderBg.labelTxt.text = "";
			} else {
				loaderBg.labelTxt.text = "loading background "+uint(100 * event.bytesLoaded / event.bytesTotal)+"%";
			}			
		}
	}
}
