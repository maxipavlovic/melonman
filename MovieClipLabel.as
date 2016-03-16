package  {
	
	import flash.display.MovieClip;
    import flash.text.*;
	
	public class MovieClipLabel extends MovieClip {
	
		private var _Label:TextField;
		
		public function MovieClipLabel() {
			
			_Label = new TextField();
			_Label.height = 100;
			_Label.width = 100;
			_Label.autoSize = TextFieldAutoSize.CENTER;
			_Label.selectable = false;
			this.addChild(_Label);
		}
		
		public function ChangeText( _Text: String ):void
		{
			_Label.text = _Text;
		}
		
		public function ChangeNumber( _Number: Number ):void
		{
			_Label.text = String(_Number);
		}
		
		public function Destructor():void
		{
			_Label = null;
		}

	}
	
}
