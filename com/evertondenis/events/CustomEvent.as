package com.evertondenis.events 
{
	import flash.events.Event;

	/**
	 * @author Everton Denis
	 */
	public class CustomEvent extends Event 
	{
		public var argumment:*;

		/**
		 * Construtor
		 *
		 * @param	type
		 * @param	bubbles
		 * @param	cancelable
		 * @param	... a
		 */
		public function CustomEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false, ... a:* )
		{
			super(type, bubbles, cancelable);
			argumment = a;
		}
	}
}
