package  {
	
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.text.*;
	import flash.display.MovieClip;
	
	public class MMOptions extends MMServeItems {
		
		private var Label1,Label2,Label3,Label4:TextField;
		private var _Button_Up, _Button_Left, _Button_Right, _Button_Down, _Mask /*маска слоя для нажатия*/
		, _ReturnToDefault: MovieClip;
		
		public function MMOptions( Parent: MainMenu ) {
			
			super(Parent);
			
			_Button_Up = new Btn_Up();
			_Button_Left = new Btn_Left();
			_Button_Right = new Btn_Right();
			_Button_Down = new Btn_Down();
			_ReturnToDefault = new Back_To_Default();
			_Mask = new InnerMask();
			
			Label1 = new TextField();
			Label2 = new TextField();
			Label3 = new TextField();
			Label4 = new TextField();
			
			_Button_Up.x = 700;
			_Button_Up.y = 100;
			_Button_Down.x = 700;
			_Button_Down.y = 250;
			_Button_Right.x = 700;
			_Button_Right.y = 400;
			_Button_Left.x = 700;
			_Button_Left.y = 550;
			_ReturnToDefault.x = 150;
			_ReturnToDefault.y = 650;
			_Button_Up.buttonMode = true;
			_Button_Down.buttonMode = true;
			_Button_Right.buttonMode = true;
			_Button_Left.buttonMode = true;
			_ReturnToDefault.buttonMode = true;
			
			Label1.height = 100;
			Label1.width = 100;
			Label1.autoSize = TextFieldAutoSize.CENTER;
			Label1.selectable = false;
			Label2.height = 100;
			Label2.width = 100;
			Label2.autoSize = TextFieldAutoSize.CENTER;
			Label2.selectable = false;
			Label3.height = 100;
			Label3.width = 100;
			Label3.autoSize = TextFieldAutoSize.CENTER;
			Label3.selectable = false;
			Label4.height = 100;
			Label4.width = 100;
			Label4.autoSize = TextFieldAutoSize.CENTER;
			Label4.selectable = false;
			Label1.text = "Нажмите ВВЕРХ, чтобы изменить клавишу движения ВВЕРХ";
			Label2.text = "Нажмите ВНИЗ, чтобы изменить клавишу движения ВНИЗ";
			Label3.text = "Нажмите ВПРАВО, чтобы изменить клавишу движения ВПРАВО";
			Label4.text = "Нажмите ВЛЕВО, чтобы изменить клавишу движения ВЛЕВО";
			Label1.x = 100;
			Label1.y = 100;
			Label2.x = 100;
			Label2.y = 250;
			Label3.x = 100;
			Label3.y = 400;
			Label4.x = 100;
			Label4.y = 550;
			
			this.addChild(Label1);
			this.addChild(Label2);
			this.addChild(Label3);
			this.addChild(Label4);
			this.addChild(_Button_Up);
			this.addChild(_Button_Down);
			this.addChild(_Button_Left);
			this.addChild(_Button_Right);
			this.addChild(_ReturnToDefault);
			
			_ReturnToDefault.addEventListener(MouseEvent.CLICK, ToDefault);
			_Back_btn.addEventListener(MouseEvent.CLICK, ShowMenuEvent);
			_Button_Up.addEventListener(MouseEvent.CLICK, onUpClick);
			_Button_Down.addEventListener(MouseEvent.CLICK, onDownClick);
			_Button_Right.addEventListener(MouseEvent.CLICK, onRightClick);
			_Button_Left.addEventListener(MouseEvent.CLICK, onLeftClick);
		}
		
		private function ToDefault(_event:MouseEvent):void
		{
			(_Parent.SeeGame()).ChangeUpKeyCode(38);
			(_Parent.SeeGame()).ChangeDownKeyCode(40);
			(_Parent.SeeGame()).ChangeLeftKeyCode(37);
			(_Parent.SeeGame()).ChangeRightKeyCode(39);
		}
		
		private function onUpClick(_event:MouseEvent):void
		{
			this.addChild(_Mask);
			stage.focus = _Mask;
			this.addEventListener(KeyboardEvent.KEY_DOWN, UpKeyValue);
		}
		
		private function onDownClick(_event:MouseEvent):void
		{
			this.addChild(_Mask);
			stage.focus = _Mask;
			this.addEventListener(KeyboardEvent.KEY_DOWN, DownKeyValue);
		}
		
		private function onRightClick(_event:MouseEvent):void
		{
			this.addChild(_Mask);
			stage.focus = _Mask;
			this.addEventListener(KeyboardEvent.KEY_DOWN, RightKeyValue);
		}
		
		private function onLeftClick(_event:MouseEvent):void
		{
			this.addChild(_Mask);
			stage.focus = _Mask;
			this.addEventListener(KeyboardEvent.KEY_DOWN, LeftKeyValue);
		}
		
		private function UpKeyValue(event:KeyboardEvent):void
		{
			(_Parent.SeeGame()).ChangeUpKeyCode(event.keyCode);
			this.removeEventListener(KeyboardEvent.KEY_DOWN, UpKeyValue);
			this.removeChild(_Mask);
		}
		
		private function DownKeyValue(event:KeyboardEvent):void
		{
			(_Parent.SeeGame()).ChangeDownKeyCode(event.keyCode);
			this.removeEventListener(KeyboardEvent.KEY_DOWN, DownKeyValue);
			this.removeChild(_Mask);
		}
		
		private function RightKeyValue(event:KeyboardEvent):void
		{
			(_Parent.SeeGame()).ChangeRightKeyCode(event.keyCode);
			this.removeEventListener(KeyboardEvent.KEY_DOWN, RightKeyValue);
			this.removeChild(_Mask);
		}
		
		private function LeftKeyValue(event:KeyboardEvent):void
		{
			(_Parent.SeeGame()).ChangeLeftKeyCode(event.keyCode);
			this.removeEventListener(KeyboardEvent.KEY_DOWN, LeftKeyValue);
			this.removeChild(_Mask);
		}
				
		private function ShowMenuEvent(_event:MouseEvent):void
		{
			this.ShowMenu();
		}
		
		override protected function ShowMenu():void
		{
			super.ShowMenu();
		}
		
		override public function Destructor():void
		{
			_Back_btn.removeEventListener(MouseEvent.CLICK, ShowMenuEvent);
			super.Destructor();
		}

	}
	
}
