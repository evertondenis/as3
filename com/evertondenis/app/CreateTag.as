package com.evertondenis.app 
{
	import flash.display.Sprite;

	/**
	 * @author Everton Denis
	 */
	public class CreateTag extends Sprite 
	{
		private var _setTags:String;
		private var _arrayTags:Array = [];

		public function CreateTag()
		{
		}

		public function setUpTags(__tags:String):Array 
		{
			var tag:String = __tags.toLowerCase();
			var str:Array = tag.split(" ");
			var newString:String = str.join("");
			_arrayTags = newString.split(",");
			return _arrayTags;
		}
	}
}
