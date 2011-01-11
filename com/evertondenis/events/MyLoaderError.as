//definir os pacotes
package com.evertondenis.events 
{
	/** 
	* @copyright Everton Denis 2008-2009
	* @author Everton Denis
	*/ 
	//importação
	import flash.events.Event;

	//definir a classe
	public class MyLoaderError extends Event 
	{

		//criar uma propriedade estática
		public static  const CONTENT_NULL:String = "myloadererro_ContentNull";

		//construtor da classe
		public function MyLoaderError(e:String) 
		{
			//enviar "e" para a classe superior
			super(e);
		}
	}
}