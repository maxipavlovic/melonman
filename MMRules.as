package  {
	
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	
	public class MMRules extends MMServeItems {

		private var _Rules_Text:MovieClip;

		public function MMRules( Parent: MainMenu ) {
			
			super(Parent);
			_Rules_Text= new Rules_Text();
			_Rules_Text.buttonMode = false;
			_Rules_Text.x = 25;
			_Rules_Text.y = 15;
			_Back_btn.addEventListener(MouseEvent.CLICK, ShowMenuEvent);
		}
		
		public function ShowRules()
		{
			this.addChild(_Rules_Text);
		}
		
		private function ShowMenuEvent(_event:MouseEvent):void
		{
			this.removeChild(_Rules_Text);
			this.ShowMenu();
		}
		
		override protected function ShowMenu():void
		{
			super.ShowMenu();
		}
		
		override public function Destructor():void
		{
			_Back_btn.removeEventListener(MouseEvent.CLICK, ShowMenuEvent);
			_Rules_Text = null;
			super.Destructor();
		}

	}
	
}
