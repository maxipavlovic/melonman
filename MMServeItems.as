package  {
	
	import flash.display.MovieClip;
	
	public class MMServeItems extends MMItems {
		
		protected var _Back_btn:MovieClip;
		//protected var _MMBackground:MovieClip;
		
		public function MMServeItems( Parent: MainMenu ) {
			
			super(Parent);
			
			_Back_btn = new Back_btn();
			//_MMBackground = new MovieClip();//MMBackground(); Фон для пунктов меню
			_Back_btn.buttonMode = enabled;
			_Back_btn.x = 512;
			_Back_btn.y = 700;
			
			//this.addChild(_MMBackground);
			this.addChild(_Back_btn);
		}
				
		override protected function ShowMenu():void
		{
			super.ShowMenu();
		}
		
		override public function Destructor():void
		{
			super.Destructor();
			_Back_btn = null;
		}

	}
	
}
