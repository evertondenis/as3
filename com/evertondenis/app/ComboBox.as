package com.evertondenis.app 
{
	import com.greensock.TweenLite;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.Timer;

	/**
	 * @author Everton Denis
	 */
	public class ComboBox extends MovieClip 
	{
		public var labelInicial:TextField;
		public var boxBtn:MovieClip;

		private var _labels:Array;
		private var _cont:MovieClip;
		private var labelH:Number;
		private var _flag:Boolean = false;
		private var _maskCont:Sprite;
		private var _type:String;
		private var _timer:Timer;

		////////////////////////////////////////////////////////////////////////////////////////////
		// CONSTRUCTOR
		///////////////////////////////////////////////////////////////////////////////////////////

		public function ComboBox(...args)
		{
			_labels = args;
			
			labelInicial.autoSize = TextFieldAutoSize.LEFT;
			labelInicial.text = _labels[0];
			
			labelInicial.addEventListener(MouseEvent.CLICK, updownLabels);
			
			boxBtn.buttonMode = true;
			boxBtn.addEventListener(MouseEvent.CLICK, updownLabels);
			
			_type = labelInicial.text;
			
			createTimer();
			createLabels();
		}		

		private function createTimer():void 
		{
			_timer = new Timer(800, 1);
			_timer.addEventListener(TimerEvent.TIMER, upCont);
		}

		private function createLabels():void 
		{
			var i:int;
			var totalLabel:int = _labels.length;
			labelH = labelInicial.height;
			_cont = new MovieClip();
			
			for (i = 1;i < totalLabel;++i)
			{
				var labelBtn:ButtonLabelBox = new ButtonLabelBox();
				labelBtn.titulo = _labels[i];
				labelBtn.y = (labelBtn.height - 2) * i;
				labelBtn.addEventListener(MouseEvent.CLICK, clickHandler);
				labelBtn.addEventListener(MouseEvent.ROLL_OVER, overHandler);
				labelBtn.addEventListener(MouseEvent.ROLL_OUT, outHandler);
			
				_cont.addChild(labelBtn);
			}
			
			_cont.y = -(_cont.height + labelH);
			addChild(_cont);
			
			createMask();
		}

		
		private function createMask():void 
		{
			_maskCont = new Sprite();
			_maskCont.graphics.beginFill(0x000000);
			_maskCont.graphics.drawRect(0, labelH - 3, _cont.width, _cont.height + 5);
			_maskCont.graphics.endFill();
			
			this.addChild(_maskCont);
			_cont.mask = _maskCont;			
		}

		////////////////////////////////////////////////////////////////////////////////////////////
		// EVENTS FUNCTIONS
		///////////////////////////////////////////////////////////////////////////////////////////

		private function clickHandler(event:MouseEvent):void 
		{
			labelInicial.text = event.currentTarget.titulo;
			_type = labelInicial.text;
			TweenLite.to(_cont, 0.3, {y:-(_cont.height + labelH)});
			boxBtn.gotoAndStop(1);
			_flag = false;
		}

		private function updownLabels(event:MouseEvent):void 
		{
			if (!_flag)
			{
				_flag = true;
				boxBtn.gotoAndStop(2);
				TweenLite.to(_cont, 0.3, {y:-1});
			}
			else
			{
				_flag = false;
				boxBtn.gotoAndStop(1);
				TweenLite.to(_cont, 0.3, {y:-(_cont.height + labelH)});
			}
		}

		private function overHandler(event:MouseEvent):void 
		{
			_timer.stop();
		}

		private function outHandler(event:MouseEvent):void 
		{
			_timer.start();
		}

		// TIMER EVENT
		private function upCont(event:TimerEvent):void 
		{
			TweenLite.to(_cont, 0.3, {y:-(_cont.height + labelH)});
			boxBtn.gotoAndStop(1);
			_flag = false;
			_timer.stop();
		}

		////////////////////////////////////////////////////////////////////////////////////////////
		// ACCESSORS
		///////////////////////////////////////////////////////////////////////////////////////////

		public function get tipo():String 
		{
			return _type;
		}
	}
}
