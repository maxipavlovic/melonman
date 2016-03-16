package  {
	
	import flash.display.MovieClip;
	
	public class MMItems extends MovieClip {
		
		protected var _Parent:MainMenu;

		public function MMItems( Parent: MainMenu ) {
			
			_Parent = Parent;
		}
		
		protected function ShowMenu():void
		{
			_Parent.ShowMenu();
		}
		
		public function Destructor():void
		{
			_Parent = null;
		}

	}
	
}
