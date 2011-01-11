package com.evertondenis.utils
{	
	/** 
	* @copyright Everton Denis 2008-2009
	* @author Everton Denis
	* Last update: 22-05
	*/ 
	//pacotes a serem importados
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	//minhas classes
	import com.evertondenis.events.MyLoaderEvent;
	import com.evertondenis.events.MyLoaderError;
	
	/**===================================================================================================
	Usage exemple:
		var loader:MyLoader;
		
		loaderPic("pic.jpg");
		
		function loaderPic(pic:String):void {
			loader = new MyLoader(this, false, true, 200);
			loader.addEventListener(MyLoaderEvent.COMPLETE, loaderComplete);
			loader.load(pic);
		}
		function loaderComplete(event:MyLoaderEvent):void {
			addChild(event.content);
		}
	======================================================================================================*/
	
	//definir a classe
	public class MyLoader extends Sprite{
		
		//declarar as propriedades
		private var _loader:Loader = new Loader();
		private var _bg:Sprite;
		private var _bar:Sprite;
		
		//private var wBar:int;
		
		private var __useProgressBar:Boolean;
		
		//construtor
		public function MyLoader(container:DisplayObjectContainer 	= null,
						useProgressBar:Boolean 						= false,
						useAsContainer:Boolean 						= false,
						widthBar:int 								= 100,
						color:uint									= 0x000000,
						positionLoader:String						= "TOP"
						){
			
			__useProgressBar = useProgressBar;
			//verificação se useAsContainer
			if(useAsContainer){
				//adiciona a display
				addChild(_loader);
			}
			//verificação para adicionar automaticamente ao container
			if(container != null){
				//adiciona o objeto ao container
				container.addChild(this);
			}
			//verificação se usar barra de progresso
			if(useProgressBar){
				//criar a barra
				//instanciação do objeto
				_bg = new Sprite();
				//criação visual
				//_bg.graphics.lineStyle(1, 0x000000);
				_bg.graphics.beginFill(0x000000, 0.2);
				_bg.graphics.drawRect(0, 0, widthBar, 3);
				_bg.graphics.endFill();
				//adiciona a display
				
				if (container != null) {
					switch ( positionLoader )
					{
						case "TOP":
							_bg.y = 0;
							addChild(_bg);
						break; 
						 
						case "MIDDLE":
							_bg.y = container.height / 2 - 3;
							addChild(_bg);
						break;
							 
						case "BOTTOM":
							_bg.y = container.height - 3;
							addChild(_bg);
						break;
					}
				}
				else
				{
					addChild(_bg);
				}
				/*if (container != null) {
					_bg.y = 0;// container.height - 3;
					addChild(_bg);
				} else {
					addChild(_bg);
				}*/
				
				//criar a barra de progresso
				//instanciação do oobjeto
				_bar = new Sprite();
				//criação visual
				_bar.graphics.beginFill(color);
				_bar.graphics.drawRect(0, 0, widthBar, 3);
				_bar.graphics.endFill();
				
				//definir a posição escalar para x
				_bar.scaleX = 0;
				//adiciona a display
				if (container != null) {
					switch ( positionLoader )
					{
						case "TOP":
							_bar.y = 0;
							addChild(_bar);
						break; 
						
						case "MIDDLE":
							_bar.y = container.height / 2 - 3;
							addChild(_bar);
						break;
							 
						case "BOTTOM":
							_bar.y = container.height - 3;
							addChild(_bar);
						break;
					}
				}
				else
				{
					addChild(_bg);
				}
				/*if (container != null) {
					_bar.y = 0;// container.height - 3;
					addChild(_bar);
				} else {
					addChild(_bar);
				}*/
			}
			//registrando os eventos
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loaderProgress);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderComplete);
		}
		//declara a função load
		public function load(string:String):void{
			//verificar o load via URLRequest
			_loader.load(new URLRequest(string));
		}
		//declara um objeto de leitura
		public function getLoadedObject():*{
			//verificação se _loader está null
			if(_loader.content!= null){
				//retornar
				return _loader.content;
			}else{
				//retorna mensagem da classe de erro
				dispatchEvent(new MyLoaderError(MyLoaderError.CONTENT_NULL));
			}
		}
		//declara metódo para verificar status de progresso
		//declara metódo que verifica se completou
		public function loaderProgress(e:ProgressEvent):void{
			//calcular a porcentagem de progresso
			if(__useProgressBar)
			{
				_bar.scaleX = e.bytesLoaded / e.bytesTotal;
			}
		}
		public function loaderComplete(e:Event):void{
			//remover os eventos de progresso e complete
			e.target.removeEventListener(ProgressEvent.PROGRESS, loaderProgress);
			e.target.removeEventListener(Event.COMPLETE, loaderComplete);
			if(__useProgressBar)
			{
				removeChild(_bar);
				removeChild(_bg);
			}
			//disparar um complete,  passando o conteúdo
			dispatchEvent(new MyLoaderEvent(MyLoaderEvent.COMPLETE, _loader.content));
		}
	}
}