package com.evertondenis.display 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * @author Everton Denis
	 */
	public class Carousel extends Sprite 
	{
		private var _arrayImages:Array = [];
		private var _arrayItems:Array = [];
		private var radiusX:uint = 100; // width of carousel
		private var radiusY:uint = 10; // height of carousel
		private var centerX:Number = 5; // x position of center of carousel
		private var centerY:Number = 40; // y position of center of carousel
		private var speed:Number = 0.05;		
		private var _prev_btn:MovieClip;
		private var _next_btn:MovieClip;

		// initial speed of rotation of carousel

		public function Carousel(arrayImages:Array, nextbtn:MovieClip, prevbtn:MovieClip)
		{
			_arrayImages = arrayImages; 
			_next_btn = nextbtn;
			_prev_btn = prevbtn;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		function init(event:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			_next_btn.buttonMode = _prev_btn.buttonMode = true;
			_next_btn.addEventListener(MouseEvent.CLICK, rotateObjs);
			_prev_btn.addEventListener(MouseEvent.CLICK, rotateObjs);
			
			var totalItems:Number = _arrayImages.length;
			
			for(var i:int = 0;i < totalItems;++i) 
			{
				var item:ItemImage = new ItemImage();
				// public var angl:Number; is in Item class.
				// Item class extends ItemInner in FLA library.
				item.angle = i * ((Math.PI * 2) / totalItems);
				//item.ref.mask = item.masker;
				//item.alpha = 0.5;
				_arrayItems.push(item);
				addChild(item);
				item.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
				// listen for MouseEvents only on icons, not on reflections
				//item.icon.addEventListener(MouseEvent.CLICK, clickHandler);
				//item.icon.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
				//item.icon.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
			}
		}

		private function sortBySize():void 
		{
			// There isn't an Array.ASCENDING property so use DESCENDING and reverse()
			_arrayItems.sortOn("scaleX", Array.DESCENDING | Array.NUMERIC);
			_arrayItems.reverse();
			for(var i:uint = 0;i < _arrayItems.length;i++) 
			{
				var item:ItemImage = _arrayItems[i];
				setChildIndex(item, i);
			}
		}

		private function enterFrameHandler(event:Event):void 
		{
			event.target.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			event.target.x = Math.cos(event.target.angle) * radiusX + centerX; // x position of Item
			event.target.y = Math.sin(event.target.angle) * radiusY + centerY; // y postion of Item
			
			// scale Item according to y position to give perspective
			var s:Number = event.target.y / (centerY + radiusY);
			event.target.scaleX = event.target.scaleY = s;
			//event.target.angle += speed; // speed is updated by mouseMoveHandler
			sortBySize();
		}

		function mouseMoveHandler(event:MouseEvent):void 
		{
			speed = (mouseX - centerX) / 6000;
		}
		
		private function rotateObjs(event:MouseEvent):void 
		{
			switch (event.currentTarget.name){
				case "next_btn":
					trace("next_btn");
					break;
				case "prev_btn":
					trace("prev_btn");
					break;
			}
		}		
	}
}