package com.evertondenis.app 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	/**
	 * @author Everton Denis
	 */
	public class ButtonLabelBox extends Sprite 
	{
		public var labelTxt:TextField;

		////////////////////////////////////////////////////////////////////////////////////////////
		// CONSTRUCTOR
		///////////////////////////////////////////////////////////////////////////////////////////

		public function ButtonLabelBox()
		{
			this.labelTxt.autoSize = TextFieldAutoSize.LEFT;
			this.labelTxt.mouseEnabled = false;
			
			this.buttonMode = true;
		}

		////////////////////////////////////////////////////////////////////////////////////////////
		// ACCESSORS
		///////////////////////////////////////////////////////////////////////////////////////////

		public function get titulo():String 
		{
			return this.labelTxt.text;
		}

		public function set titulo(title:String):void 
		{
			this.labelTxt.text = title;
		}
	}
}
