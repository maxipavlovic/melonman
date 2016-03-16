package  {
	
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class Melonman extends MovieClip {

		private var _Melonman_Body,_Melonman_Left_Leg,_Melonman_Right_Leg,_Melonman_Head_Back,
					_Melonman_Head,_Melonman_Body_Back,_Melonman_Gun:MovieClip;
		private var Melonman_delay:Number;
		private var Melonman_repeat:Number;
		private var Melonman_timer:Timer;
		private const turnangle:int = 5;
		
		public function Melonman() {
			
			Melonman_delay = 50;
			Melonman_repeat = 8;
			Melonman_timer = new Timer (Melonman_delay, Melonman_repeat);
			_Melonman_Body = new Melonman_Body();
			_Melonman_Left_Leg = new Melonman_Left_Leg();
			_Melonman_Right_Leg = new Melonman_Right_Leg();
			_Melonman_Head_Back = new Melonman_Head_Back();
			_Melonman_Head = new Melonman_Head();
			_Melonman_Body_Back = new Melonman_Body_Back();
			_Melonman_Gun = new Melonman_Gun();
			this.addChildAt(_Melonman_Body,0);
			this.addChildAt(_Melonman_Head,1);
			this.addChildAt(_Melonman_Right_Leg,2);
			this.addChildAt(_Melonman_Left_Leg,3);
			this.addChildAt(_Melonman_Gun,4);
			this.addChildAt(_Melonman_Body_Back,5);
			this.addChildAt(_Melonman_Head_Back,6);
			_Melonman_Body.x = 512;
			_Melonman_Body.y = 384;
			_Melonman_Left_Leg.x = 80 + 512 -64;
			_Melonman_Left_Leg.y = 71 + 384 -28;
			_Melonman_Right_Leg.x = 84 + 512 -64 ;
			_Melonman_Right_Leg.y = 69 + 384 -28;
			_Melonman_Right_Leg.rotationY = 180;
			_Melonman_Head_Back.x = 92 + 512 -64;
			_Melonman_Head_Back.y = 24 + 384 -28;
			_Melonman_Head.x = 92 + 512 -64;
			_Melonman_Head.y = 24 + 384 -28;
			_Melonman_Body_Back.x = 512;
			_Melonman_Body_Back.y = 384;
			_Melonman_Gun.x = 86 + 512 -64;
			_Melonman_Gun.y = 56 + 384 -28;
		}
		
		public function Turn( cy: Number, cx: Number ):void
		{
			var Radians:Number = Math.atan2(cy-_Melonman_Gun.y,cx-_Melonman_Gun.x);
			

			var Degrees:Number = Radians * 180 / Math.PI;

			if ((Radians>=-Math.PI/2)&&(Radians<=Math.PI/2)) 
			{
				_Melonman_Gun.rotationY=Degrees;
				_Melonman_Gun.rotationZ=Degrees;
	
			}
			else
			{
				_Melonman_Gun.rotationY=-180+Degrees;
				_Melonman_Gun.rotationZ=Degrees;
			}
			if ((Radians>=-Math.PI)&&(Radians<=0)) 
			{
				_Melonman_Body_Back.visible=true;
				_Melonman_Head_Back.visible=true;
				_Melonman_Body.visible=false;
				_Melonman_Head.visible=false;
			}
			else
			{
	
				_Melonman_Body_Back.visible=false;
				_Melonman_Head_Back.visible=false;
				_Melonman_Body.visible=true;
				_Melonman_Head.visible=true;
			}

			_Melonman_Gun.rotationX=45;


			if ((Radians>=-(Math.PI/2))&&(Radians<=(Math.PI/2)) )//поворот головы 
			{
				_Melonman_Head.rotationY=0;
				_Melonman_Head_Back.rotationY=0;
			}
			else
			{
				_Melonman_Head.rotationY=180;
				_Melonman_Head_Back.rotationY=180;
			}
		}
		
		public function Melonman_render():void
		{
			Melonman_timer.start();
	  		Melonman_timer.addEventListener(TimerEvent.TIMER, Melonman_timer_handler);
	  		Melonman_timer.addEventListener(TimerEvent.TIMER_COMPLETE, Melonman_timer_complete);
		}
		
		private function Melonman_timer_handler(e:TimerEvent):void
		{
			Melonman_repeat--;
			if (Melonman_repeat>=4)
			{
				_Melonman_Left_Leg.rotation+=turnangle;
				_Melonman_Right_Leg.rotation-=turnangle;
			}
			else 
			{
				_Melonman_Left_Leg.rotation-=turnangle;
				_Melonman_Right_Leg.rotation+=turnangle;
			}
		}
		
		private function Melonman_timer_complete(e:TimerEvent):void
		{
			Melonman_repeat=8;
			Melonman_timer.reset();
			Melonman_timer.removeEventListener(TimerEvent.TIMER, Melonman_timer_handler);
	  		Melonman_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, Melonman_timer_complete);
		}
		
		public function Destructor():void
		{
			this.addChild(_Melonman_Body);
			this.addChild(_Melonman_Head);
			this.addChild(_Melonman_Right_Leg);
			this.addChild(_Melonman_Left_Leg);
			this.addChild(_Melonman_Gun);
			this.addChild(_Melonman_Body_Back);
			this.addChild(_Melonman_Head_Back);
			
			_Melonman_Body = null;
			_Melonman_Left_Leg = null;
			_Melonman_Right_Leg = null;
			_Melonman_Head_Back = null;
			_Melonman_Head = null;
			_Melonman_Body_Back = null;
			_Melonman_Gun = null;
			
			if( Melonman_timer.running ) Melonman_timer.stop();
			Melonman_timer = null;
		}
	}
}
