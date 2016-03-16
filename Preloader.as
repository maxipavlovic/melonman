package  {
	
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.ui.Mouse;
	import flash.text.*;
	import flash.system.fscommand;

	public class Preloader extends MovieClip {
		
		private var _Background:MovieClip; 
		private var _BackUpText:MovieClip;
		private var _Yes_btn:MovieClip;
		private var _No_btn:MovieClip;
		private var _MainMenu:MainMenu;
		private var PreloadTimer:Timer;
		
		public function Preloader() {
			
			PreloadTimer = new Timer(1000,3);
			_MainMenu = new MainMenu(this);
			_Background = new Entrance();
			_BackUpText = new BackUpText();
			_Yes_btn = new Yes_btn();
			_No_btn = new No_btn();
			
			_Background.x = 512;
			_Background.y = 384;
			_Yes_btn.x = 300;
			_Yes_btn.y = 500;
			_No_btn.x = 700;
			_No_btn.y = 500;
			_Yes_btn.buttonMode = true;
			_No_btn.buttonMode = true;
			_BackUpText.x = 500;
			_BackUpText.y = 100;
			
			Mouse.hide();
			this.addChild(_Background);
			
			PreloadTimer.start();
			PreloadTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
		}

		private function onTimerComplete(_event:TimerEvent):void {
			this.removeChild(_Background);
			var TempBackUp:BackupClass = _MainMenu.SeeBUClass();
			if( TempBackUp.SeeChanged() )
			{
				Mouse.show();
				this.addChild(_Yes_btn);
				this.addChild(_No_btn);
				this.addChild(_BackUpText);
				
				_Yes_btn.addEventListener(MouseEvent.CLICK,YesClicked);
				_No_btn.addEventListener(MouseEvent.CLICK,NoClicked);
			}
			else
			{
				this.addChild(_MainMenu);
				Mouse.show();
			}
		}
		
		private function YesClicked(event:MouseEvent):void
		{
			_Yes_btn.removeEventListener(MouseEvent.CLICK,YesClicked);
			_No_btn.removeEventListener(MouseEvent.CLICK,NoClicked);
			this.removeChild(_Yes_btn);
			this.removeChild(_No_btn);
			this.removeChild(_BackUpText);
			this.addChild(_MainMenu);
			Mouse.show();
			_MainMenu.StartGame();
		}
		
		private function NoClicked(event:MouseEvent):void
		{
			_Yes_btn.removeEventListener(MouseEvent.CLICK,YesClicked);
			_No_btn.removeEventListener(MouseEvent.CLICK,NoClicked);
			this.removeChild(_Yes_btn);
			this.removeChild(_No_btn);
			this.removeChild(_BackUpText);
			this.addChild(_MainMenu);
			Mouse.show();
		}
		
		public function Destructor( _MM: Preloader ):void
		{
			_MM = null;
			PreloadTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			PreloadTimer = null;
			_Yes_btn = null;
			_No_btn = null;
			_Background = null;
			_BackUpText = null;
			_MainMenu = null;
		}
	}
}
