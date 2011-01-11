//declarar o pacote
package com.evertondenis.events 
{
	/** 
	* @copyright Everton Denis 2008-2009
	* @author Everton Denis
	*/ 

	//importação
	import flash.events.Event;

	//declarar a classe
	public class MyLoaderEvent extends Event 
	{

		//definir uma constante
		public static  const COMPLETE:String = "myloaderevent_Complete";

		//definir o content
		public var content:*;

		//definir o construtor da classe
		public function MyLoaderEvent(e:String, c:*) 
		{
			// transferir o content
			content = c;

			//aplicar recusar de herança
			super(e);
		}
	}
}