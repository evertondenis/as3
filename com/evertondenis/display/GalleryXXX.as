package com.evertondenis.display 
{
	import com.evertondenis.app.CreateTag;
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	/**
	 * @author Everton Denis
	 * @create: 18/05/2010 
	 */

	public class GalleryXXX extends MovieClip 
	{
		private var _show:int;
		private var _columns:int;
		private var _padding:int;
		private var _pg:TextField;

		private var _array:Array;
		private var _arrayCategoria:Array = new Array();

		private var _page:int;
		private var _time:Number;
		private var _numPages:Number;
		private var _showInit:int = 8;
		private var _init:Boolean = true;

		
		///////////////////////////////////////////////////////////////////////////////
		// CONSTRUCTOR
		///////////////////////////////////////////////////////////////////////////////

		public function GalleryXXX(show:int = 3, columns:int = 3, padding:int = 1, time:Number = 1, pg:TextField = null)
		{
			_array = [];
			_show = show;
			_page = 0;
			_columns = columns;
			_padding = padding;
			_time = time;
			_pg = pg;
		}

		///////////////////////////////////////////////////////////////////////////////
		// ADD ITEM FUNCTION
		///////////////////////////////////////////////////////////////////////////////

		public function add(obj:Object, fcn:Function, params:Object = null):void
		{
			var item:* = obj;
			addChild(item);
			
			item.id = _array.length;
			item.params = params;
			
			if (item.tags != null)
			{
				var itemTags:CreateTag = new CreateTag();
				item.tags = itemTags.setUpTags(item.params.tags);
				
			}
			
			var posX:Number;
			var posY:Number;
			
			if (item.id < _show)
			{
				trace("ID: " + item.id + " - Mostrar: " + _showInit);
				item.mouseEnabled = true;
				posX = Math.round((item.width + _padding) * (item.id % _columns));
				posY = Math.round((item.height + _padding) * Math.floor(item.id / _columns));
				TweenLite.to(item, _time, {x:posX, y:posY, alpha:1, ease:Expo.easeOut});
			}
			else
			{
				item.mouseEnabled = false;
				item.x = Math.round((item.width + _padding) * (item.id % _columns));
				item.y = -400;
				item.alpha = 0; 
			}
			
			item.addEventListener(MouseEvent.CLICK, fcn);
			
			_array.push(item);
			_arrayCategoria.push(item);
		}

		//////////////////////////////////////////////////////////////////////////////////////////// 
		// REPOSITION FUNCTION
		////////////////////////////////////////////////////////////////////////////////////////////

		private function reposition(pagina:int = 0):void 
		{
			var i:int;
			var id:int = 0;
			var posX:Number;
			var posY:Number;
			var init:int = pagina * _show;
			var total:int = _arrayCategoria.length;
			var totalItens:int = init + _show;
			
			_numPages = Math.ceil(total / _show);
			
			// recolhe itens
			for (i = 0;i < _arrayCategoria.length;++i) 
			{
				var hideItem:MovieClip = _arrayCategoria[i] as MovieClip;
				
				hideItem.mouseEnabled = false;
				posX = Math.round((hideItem.width + _padding) * (hideItem.id % _columns));
				posY = -400;
				TweenLite.to(hideItem, _time, {x:posX, y:posY, alpha:0, ease:Expo.easeOut});
			}
			
			// set novos itens
			for (init;init < totalItens;++init)
			{
				var item:MovieClip = _arrayCategoria[init] as MovieClip;
				
				if (init < total)
				{
					item.mouseEnabled = true;
					posX = Math.round((item.width + _padding) * (id % _columns));
					posY = Math.round((item.height + _padding) * Math.floor(id / _columns));
					TweenLite.to(item, _time, {x:posX, y:posY, alpha:1, ease:Expo.easeOut});
					id++;
				}
			}
		}

		//////////////////////////////////////////////////////////////////////////////////////////// 
		// POP BY CATEGORY FUNCTION
		////////////////////////////////////////////////////////////////////////////////////////////

		public function popByCat(cat:String):int 
		{
			var i:int;
			var j:int;
			var aux:int;
			var id:int = 0;
			var posX:Number;
			var posY:Number;
			var total:int = _array.length;
			var totalTag:int;
			
			_init = false;
			
			// Recolhe os itens que estão no stage
			if (_arrayCategoria != null)
			{
				for (var k:int = 0;k < _array.length;++k) 
				{
					var hideItem:MovieClip = _array[k] as MovieClip;
				
					hideItem.mouseEnabled = false;
					posX = Math.round((hideItem.width + _padding) * (hideItem.id % _columns));
					posY = -400;
					TweenLite.to(hideItem, _time, {x:posX, y:posY, alpha:0, ease:Expo.easeOut});
				}
			}
			// caso seja null recolhe os primeiros itens
			else
			{
				for (var l:int = 0;l < _array.length;++l) 
				{
					var hideItemNull:MovieClip = _array[l] as MovieClip;
				
					hideItemNull.mouseEnabled = false;
					posX = Math.round((hideItemNull.width + _padding) * (hideItemNull.id % _columns));
					posY = -400;
					TweenLite.to(hideItemNull, _time, {x:posX, y:posY, alpha:0, ease:Expo.easeOut});
				}
			}
			
			// INICIA UMA NOVA GALERIA DE ACORDO COM A CATEGORIA SELECIONADA  ////////////////////////////////////////////

			_arrayCategoria = [];
			
			for (i = 0;i < total;++i)
			{
				totalTag = _array[i].tags.length;
				
				for (j = 0;j < totalTag;++j)
				{
					if (_array[i].tags[j] == cat)
					{
						var item:MovieClip = _array[i] as MovieClip;
						
						_arrayCategoria[aux] = item;
						
						if (aux < _show)
						{
							item.mouseEnabled = true;							
							posX = Math.round((item.width + _padding) * (id % _columns));
							posY = Math.round((item.height + _padding) * Math.floor(id / _columns));
							TweenLite.to(item, _time, {x:posX, y:posY, alpha:1, ease:Expo.easeOut});
						}
						else
						{
							item.mouseEnabled = false;
							posX = Math.round((item.width + _padding) * (id % _columns));
							posY = -400;
							TweenLite.to(item, _time, {x:posX, y:posY, alpha:0, ease:Expo.easeOut});
						}
						
						id++;
						aux++;
					}
				}
			}
			return _arrayCategoria.length;
		}

		//////////////////////////////////////////////////////////////////////////////////////////// 
		// SHOW OR HIDE GALLERY FUNCTION
		////////////////////////////////////////////////////////////////////////////////////////////

		public function showHide(sh:String):void 
		{
			var posX:Number;
			var posY:Number;
			var i:int;
			
			if (!_init)// verifica se foi selecionada uma categoria
			{
				if (sh == "HIDE")
				{
					for (i = 0;i < _arrayCategoria.length;++i) 
					{
						var hideItem:MovieClip = _arrayCategoria[i] as MovieClip;
				
						hideItem.mouseEnabled = false;
						posX = Math.round((hideItem.width + _padding) * (hideItem.id % _columns));
						posY = -400;
						TweenLite.to(hideItem, _time, {x:posX, y:posY, alpha:0, ease:Expo.easeOut});
					}
				}
				else
				{
					reposition();
				}
			}
			else //  caso não tenha sido escolhida retira os itens iniciais ou coloca os itens iniciais
			{
				if (sh == "HIDE")
				{
					for (var l:int = 0;l < _array.length;++l) 
					{
						var hideItemNull:MovieClip = _array[l] as MovieClip;
				
						hideItemNull.mouseEnabled = false;
						posX = Math.round((hideItemNull.width + _padding) * (hideItemNull.id % _columns));
						posY = -400;
						TweenLite.to(hideItemNull, _time, {x:posX, y:posY, alpha:0, ease:Expo.easeOut});
					}
				}
				else
				{
					for (var k:int = 0;k < _array.length;++k) 
					{
						var item:MovieClip = _array[k] as MovieClip;
						if (item.id < _showInit)
						{
							item.mouseEnabled = true;
							posX = Math.round((item.width + _padding) * (item.id % _columns));
							posY = Math.round((item.height + _padding) * Math.floor(item.id / _columns));
							TweenLite.to(item, _time, {x:posX, y:posY, alpha:1, ease:Expo.easeOut});
						}
					}
				}
			}
		}

		//////////////////////////////////////////////////////////////////////////////////////////// 
		// CONTROLLER FUNCTION
		//////////////////////////////////////////////////////////////////////////////////////////// 

		public function nextPage(event:MouseEvent):void
		{				
			//trace(_arrayCategoria.length);
			if ((_page * _show) < _arrayCategoria.length - _show)
			{
				_page++;
				reposition(_page);
				_pg.text = (_page + 1).toString() + " | " + (int(_arrayCategoria.length / _show) + 1).toString(); 
			}
		}

		public function prevPage(event:MouseEvent):void
		{			
			if (_page > 0)
			{
				_page--;
				reposition(_page);
				_pg.text = (_page + 1).toString() + " | " + (int(_arrayCategoria.length / _show) + 1).toString();
			}	
		}

		public function onWheel(event:MouseEvent):void
		{
			(event.delta < 0) ? nextPage(null) : prevPage(null);
		}

		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// ACCESSORS
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		public function set resetPage(__page:int):void
		{
			// zerando a paginação
			_page = __page;
			_pg.text = (_page + 1).toString() + " | " + (int(_arrayCategoria.length / _show) + 1).toString();
		}
	}
}