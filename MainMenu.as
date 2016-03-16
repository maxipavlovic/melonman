package  {
	
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	
	public class MainMenu extends MovieClip {
		
		private var _Preloader:Preloader;
		private var _StartGame_btn:MovieClip;
		private var _Rules_btn:MovieClip;
		private var _Options_btn:MovieClip;
		private var _Results_btn:MovieClip;
		private var _Exit_btn:MovieClip;
		private var _Game:Game;
		private var _BackupClass:BackupClass;
		private var _MMRules:MMRules;
		private var _MMOptions:MMOptions;
		private var _MMResults:MMResults;
		private var Flag:Boolean;
		private var RotationTimer:Timer;
		private var Angles:Array;
		private const DIST = 250;

		public function MainMenu( _preloader: Preloader ) {
			
			var RAD:Number = 72*Math.PI/180;
			
			RotationTimer = new Timer(100);
			
			_Preloader = _preloader;
			Angles = new Array(5);
			_StartGame_btn = new StartGame_btn();
			_Rules_btn = new Rules_btn();
			_Options_btn = new Options_btn();
			_Results_btn = new Results_btn();
			_Exit_btn = new Exit_btn();
			_MMRules = new MMRules(this);
			_MMOptions = new MMOptions(this);
			_MMResults = new MMResults(this);
			
			_BackupClass = new BackupClass();
			_Game = new Game(this);
			
			_StartGame_btn.buttonMode = true;
			_Rules_btn.buttonMode = true;
			_Options_btn.buttonMode = true;
			_Results_btn.buttonMode = true;
			_Exit_btn.buttonMode = true;
			
			Angles[0] = 2*RAD + Math.PI/2;
			Angles[1] = RAD + Math.PI/2;
			Angles[2] = 0*RAD + Math.PI/2;
			Angles[3] = 4*RAD + Math.PI/2;
			Angles[4] = 3*RAD + Math.PI/2;
			
			_StartGame_btn.x = 512+DIST*Math.cos(Angles[0]);
			_StartGame_btn.y = 384+DIST*Math.sin(Angles[0]);
			_Rules_btn.x = 512+DIST*Math.cos(Angles[1]);
			_Rules_btn.y = 384+DIST*Math.sin(Angles[1]);
			_Options_btn.x = 512+DIST*Math.cos(Angles[2]);
			_Options_btn.y = 384+DIST*Math.sin(Angles[2]);
			_Results_btn.x = 512+DIST*Math.cos(Angles[3]);
			_Results_btn.y = 384+DIST*Math.sin(Angles[3]);
			_Exit_btn.x = 512+DIST*Math.cos(Angles[4]);
			_Exit_btn.y = 384+DIST*Math.sin(Angles[4]);
						
			this.ShowMenu();
			
			Flag = true;
			RotationTimer.start();
			
			RotationTimer.addEventListener(TimerEvent.TIMER, onRTTick);
			
			_StartGame_btn.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverButton);
			_Rules_btn.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverButton);
			_Options_btn.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverButton);
			_Results_btn.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverButton);
			_Exit_btn.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverButton);
			
			_StartGame_btn.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutOfButton);
			_Rules_btn.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutOfButton);
			_Options_btn.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutOfButton);
			_Results_btn.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutOfButton);
			_Exit_btn.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutOfButton);
			
			_StartGame_btn.addEventListener(MouseEvent.CLICK, onSGBClick);
			_Rules_btn.addEventListener(MouseEvent.CLICK, onRuBClick);
			_Options_btn.addEventListener(MouseEvent.CLICK, onOBClick);
			_Results_btn.addEventListener(MouseEvent.CLICK, onReBClick);
			_Exit_btn.addEventListener(MouseEvent.CLICK, onEBClick);
		}
		
		private function onRTTick(_event:TimerEvent):void
		{
			if( Flag )
			{
				var i:int;
				for( i = 0; i < 5; i++ ) 
					Angles[i] += 0.01;
				_StartGame_btn.x = 512 + DIST*Math.cos(Angles[0]);
				_StartGame_btn.y = 384 + DIST*Math.sin(Angles[0]); 
				_Rules_btn.x = 512+DIST*Math.cos(Angles[1]);
				_Rules_btn.y = 384+DIST*Math.sin(Angles[1]); 
				_Options_btn.x = 512+DIST*Math.cos(Angles[2]);
				_Options_btn.y = 384+DIST*Math.sin(Angles[2]);
				_Results_btn.x = 512+DIST*Math.cos(Angles[3]);
				_Results_btn.y = 384+DIST*Math.sin(Angles[3]);
				_Exit_btn.x = 512+DIST*Math.cos(Angles[4]);
				_Exit_btn.y = 384+DIST*Math.sin(Angles[4]);
			}
		}
		
		private function onMouseOverButton(_event:MouseEvent):void
		{
			Flag = false;
		}
		
		private function onMouseOutOfButton(_event:MouseEvent):void
		{
			Flag = true;
		}
		
		private function onSGBClick(_event:MouseEvent):void
		{
			this.addChild(_Game);
			this.StartGame();
		}
		
		public function SeeGame():Game
		{
			return _Game;
		}
		
		public function SeeBUClass():BackupClass
		{
			return _BackupClass;
		}
		
		public function StartGame():void
		{
			this.HideMenu();
			this.addChild(_Game);
			_Game.StartGame();
		}
		
		private function onRuBClick(_event:MouseEvent):void
		{
			this.HideMenu();
			this.addChild(_MMRules);
			_MMRules.ShowRules();
		}
		
		private function onOBClick(_event:MouseEvent):void
		{
			this.HideMenu();
			this.addChild(_MMOptions);
		}
		
		private function onReBClick(_event:MouseEvent):void
		{
			this.HideMenu();
			_MMResults.EnableBB();
			AcessTable();
		}
		
		public function SeeMMResults():MMResults
		{
			return _MMResults;
		}
		
		public function AcessTable():void
		{
			this.addChild(_MMResults);
			_MMResults.ShowTable();
		}
		
		private function onEBClick(_event:MouseEvent):void
		{
			Destructor();
		}
		
		public function ShowMenu():void
		{
			Flag = true;
			this.addChild(_StartGame_btn);
			this.addChild(_Rules_btn);
			this.addChild(_Options_btn);
			this.addChild(_Results_btn);
			this.addChild(_Exit_btn);
			if( this.contains(_MMOptions) ) this.removeChild(_MMOptions);
			if( this.contains(_MMResults) ) this.removeChild(_MMResults);
			if( this.contains(_MMRules  ) ) this.removeChild(_MMRules);
		}
		
		public function HideMenu():void
		{
			Flag = false;
			this.removeChild(_StartGame_btn);
			this.removeChild(_Rules_btn);
			this.removeChild(_Options_btn);
			this.removeChild(_Results_btn);
			this.removeChild(_Exit_btn);
		}
		
		public function Destructor():void
		{
			RotationTimer.stop();
			Angles.length = 0;
			
			RotationTimer.removeEventListener(TimerEvent.TIMER, onRTTick);
			
			_StartGame_btn.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOverButton);
			_Rules_btn.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOverButton);
			_Options_btn.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOverButton);
			_Results_btn.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOverButton);
			_Exit_btn.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOverButton);
			
			_StartGame_btn.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOutOfButton);
			_Rules_btn.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOutOfButton);
			_Options_btn.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOutOfButton);
			_Results_btn.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOutOfButton);
			_Exit_btn.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOutOfButton);
			
			_StartGame_btn.removeEventListener(MouseEvent.CLICK, onSGBClick);
			_Rules_btn.removeEventListener(MouseEvent.CLICK, onRuBClick);
			_Options_btn.removeEventListener(MouseEvent.CLICK, onOBClick);
			_Results_btn.removeEventListener(MouseEvent.CLICK, onReBClick);
			_Exit_btn.removeEventListener(MouseEvent.CLICK, onEBClick);
			_StartGame_btn = null;
			_Rules_btn = null;
			_Options_btn = null;
			_Results_btn = null;
			_Exit_btn = null;
			_Game.Destructor();
			_Game = null;
			_BackupClass = null;
			_MMRules.Destructor();
			_MMOptions.Destructor();
			_MMResults.Destructor();
			_MMRules = null;
			_MMOptions = null;
			_MMResults = null;
			RotationTimer = null;
			_Preloader.Destructor(_Preloader);
		}
	}
	
}
