package  {
	
	import flash.display.MovieClip;
	
	public class Main extends MovieClip {
		
		
		public function Main() {
			var _Preloader:Preloader = new Preloader();
			this.addChild(_Preloader);
		}
		
		public function Destructor( _M: Main):void
		{
			_M = null;
		}
		
	}
	
}
