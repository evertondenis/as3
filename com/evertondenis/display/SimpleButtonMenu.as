package com.evertondenis.display 
{
	import com.greensock.easing.Back;
	import com.greensock.TweenLite;

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;

	/**
	 * @author Everton Denis
	 * create 26/05/2010
	 */
	public class SimpleButtonMenu extends MovieClip 
	{
		public var labelMc:MovieClip
		public var maskMc:MovieClip;
		public var hitMc:MovieClip;
		public var params:Object;
		public var bg:MovieClip;
		
		private var _eixo:String;
		private var _padding:int;

		public function SimpleButtonMenu(__padding:int = -20, __eixo:String = "y", __params:Object = null)
		{
			
			_padding = __padding;
			_eixo = __eixo;
			params = __params;
			
			// alteração para site Instituto Odontológico
			bg.width = .01;
			
			labelMc.labelTxt.autoSize = TextFieldAutoSize.LEFT;
			labelMc.labelTxt.mouseEnabled = false;
			labelMc.labelTxt.text = params.title;
			
			labelMc.label2Txt.autoSize = TextFieldAutoSize.LEFT;
			labelMc.label2Txt.mouseEnabled = false;
			labelMc.label2Txt.text = params.title;
			
			maskMc.width = labelMc.label2Txt.width;
			hitMc.width = this.width;
			this.buttonMode = true;
			
			this.addEventListener(MouseEvent.ROLL_OVER, overhandler);
			this.addEventListener(MouseEvent.ROLL_OUT, outhandler);
		}

		public function overhandler(event:MouseEvent):void 
		{
			if (_eixo == "y")
			{
				TweenLite.to(event.currentTarget.labelMc, 0.3, {y:_padding});
				// alteração para site Instituto Odontológico
				TweenLite.to(event.currentTarget.bg, 0.3, {width:146});
			}
			else
			{
				TweenLite.to(event.currentTarget.labelMc, 0.3, {x:_padding});
				// alteração para site Instituto Odontológico
				TweenLite.to(event.currentTarget.bg, 0.3, {width:146});
			}
		}

		public function outhandler(event:MouseEvent):void 
		{
			if (_eixo == "y")
			{
				TweenLite.to(event.currentTarget.labelMc, 0.3, {y:0});
				// alteração para site Instituto Odontológico
				TweenLite.to(this.bg, 0.3, {width:.01});
			}
			else
			{
				TweenLite.to(event.currentTarget.labelMc, 0.3, {x:0});
				// alteração para site Instituto Odontológico
				TweenLite.to(this.bg, 0.3, {width:.01});
			}
		}
	}
}
