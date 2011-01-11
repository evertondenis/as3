package com.evertondenis.utils
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;

	/**
	 * @author Everton Denis
	 */
	public class CountdownTimer extends MovieClip
	{
		public var secTxt:TextField;
		public var minTxt:TextField;
		public var hourTxt:TextField;
		public var dayTxt:TextField;
		
		private var _endDate:Date;
		private var _timerEvent:Timer;
		
		public function CountdownTimer(year:Number, month:Number, day:Number, hour:Number = 12, second:Number = 0)
		{
			_endDate = new Date(year, (month - 1), day, hour, second);
			_timerEvent = new Timer(1000);
			_timerEvent.addEventListener(TimerEvent.TIMER, updateTimer);
			_timerEvent.start();

			addEventListener(Event.ADDED_TO_STAGE, updateTimer);
		}

		private function updateTimer(event:Event):void
		{
			var curDate:Date = new Date();
			var differece:Number = _endDate.getTime() - curDate.getTime();

			var seconds:Number = Math.floor(differece / 1000);
			var minutes:Number = Math.floor(seconds / 60);
			var hours:Number = Math.floor(minutes / 60);
			var days:Number = Math.floor(hours / 24);

			seconds %= 60;
			minutes %= 60;
			hours %= 24;

			var sec:String = String(seconds);
			var min:String = String(minutes);
			var hour:String = String(hours);
			var day:String = String(days);

			if (sec.length < 2) sec = "0" + sec;
			if (min.length < 2) min = "0" + min;
			if (hour.length < 2) hour = "0" + hour;
			if (day.length < 2) day = "0" + day;
			
			secTxt.text = sec;
			minTxt.text = min;
			hourTxt.text = hour;
			dayTxt.text = day;
		}
	}
}
