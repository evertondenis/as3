package com.evertondenis.display 
{
	import com.greensock.TweenMax;

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	/**
	 * @author Everton Denis
	 * @since 05/07/2010
	 */
	 
	/**
	 * Basic usage:
		var btn:SimpleButtonColor = new SimpleButtonColor(DIREÇÃO DO TITULO: LEFT or RIGHT);
		btn.btnTitle = "TITLE BUTTON"; // set title for button
		btn.overColor = 0xC1272D; // set color for event Mouse ROLL_OVER
		btn.outColor = 0x999999; // set color for event Mouse ROLL_OUT
		addChild(btn); // 
	 */
	 
	public class SimpleButtonColor extends MovieClip 
	{
		// PUBLIC VARIABLES
		public var labelTxt:TextField;
		public var file:String;
		
		// PRIVATE VARIABLESS		
		private var _cover:uint;
		private var _cout:uint;
		private var _btnContent:String;
		private var _dir:String;

		//-------------------------------------------
		// CONSTRUCTOR
		//-------------------------------------------

		public function SimpleButtonColor(dir:String = null)
		{
			_dir = dir;
			init();
		}

		private function init():void 
		{
			
			this.labelTxt.autoSize = _dir == "LEFT" ? TextFieldAutoSize.LEFT : TextFieldAutoSize.RIGHT;
			
			this.buttonMode = true;
			this.mouseChildren = false;
			
			this.addEventListener(MouseEvent.ROLL_OVER, overHandler);
			this.addEventListener(MouseEvent.ROLL_OUT, outHandler);
		}
		
		//------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------
		
		public function deleteListeners():void
		{
			this.buttonMode = false;
			this.removeEventListener(MouseEvent.ROLL_OVER, overHandler);
			this.removeEventListener(MouseEvent.ROLL_OUT, outHandler);
		}
		
		public function setUpListeners():void
		{
			this.buttonMode = true;
			this.addEventListener(MouseEvent.ROLL_OVER, overHandler);
			this.addEventListener(MouseEvent.ROLL_OUT, outHandler);
		}

		//------------------------------------------
		// EVENTS HANDLERS
		//------------------------------------------

		public function overHandler(event:MouseEvent):void 
		{
			TweenMax.to(event.currentTarget, 0.2, {colorTransform:{tint:_cover}});
		}

		public function outHandler(event:MouseEvent):void 
		{
			TweenMax.to(event.currentTarget, 0.2, {colorTransform:{tint:_cout}});
		}

		//------------------------------------------
		// ACSSESSORS
		//------------------------------------------

		public function get btnContent():String
		{
			return _btnContent;
		}
		
		public function get btnTitle():String
		{
			return labelTxt.text;
		}
		
		public function set btnTitle(title:String):void 
		{
			labelTxt.htmlText = title;
		}

		public function set btnContent( value:String ):void
		{
			_btnContent = value;
		} 

		public function set overColor(colorfont:uint):void 
		{
			_cover = colorfont;
		}

		public function set outColor(colorfont:uint):void 
		{
			_cout = colorfont;
		}
	}
}
