package  com.evertondenis.utils
{
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Everton Denis
	 * Greeting.as V.1.0
	 * created: 28/Abr/2009
	 */
	
	 /* =====================================================================================================================
		Usage example:
		var _greeting:Greeting = new Greeting();
		
		SAUDAÇÃO
		label.text = _greeting.msg;

		DIA DO MÊS
		label.text = _greeting.day_month;

		DIA DA SEMANA
		label.text = _greeting.day_week;

		MÊS
		label.text = _greeting.month;

		ANO
		label.text = _greeting.year;
		
	 */// =====================================================================================================================
	 
	public class Greeting
	{
		// Instance properties ----------------------------------------------------------------
		
		protected var _week:Array = ["domingo", "segunda-feira", "terça-feira", "quarta-feira", "quinta-feira", "sexta-feira", "sábado"];
		protected var _month:Array = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"];
		protected var _date:Date = new Date();
		protected var _hora:Number = _date.getHours();
		
		// Instance methods -------------------------------------------------------------------
		public var msg:String;
		public var day_month:String;
		public var day_week:String;
		public var month:String;
		public var year:String;
		
		// ================================================================================================================
		// CONSTRUCTOR ----------------------------------------------------------------------------------------------------
		
		public function Greeting() 
		{
			DateNow();
			DayMonth();
			DayWeek();
			Month();
			Year();
		}
		
		// ================================================================================================================
		// METHODS ----------------------------------------------------------------------------------------------------
		
		private function DateNow():String
		{
			msg = _hora >= 6 && _hora <= 12 ? "Bom dia " : _hora > 12  && _hora <= 18 ? "Boa tarde " : "Boa Noite ";
			return msg;
		}
		private function DayMonth():String
		{
			day_month = _date.getDate().toString();
			return day_month;
		}
		private function DayWeek():String
		{
			day_week = _week[_date.getDay()];
			return day_week;
		}
		private function Month():String
		{
			month = _month[_date.getMonth()];
			return month;
		}
		private function Year():String
		{
			year = _date.getFullYear().toString();
			return year;
		}
	}
	
}