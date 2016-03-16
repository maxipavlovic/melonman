package  {
	
	import flash.utils.Timer;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.display.MovieClip;
	
	public class Bonus extends MovieClip {
		
		private var Bonus_Sound:Sound;
		private var Uni_Bonus:MovieClip;
		private var bonus_jump_timer:Timer;
		private var flag:Boolean=true;
		private var count:Number;

		public function Bonus() {
			
			count = 8;
			Uni_Bonus=new Bonus_Gift();
			bonus_jump_timer=new Timer(100); 
			this.addChild(Uni_Bonus);
			
			bonus_jump_timer.start();
			bonus_jump_timer.addEventListener(TimerEvent.TIMER, bonus_timer_handler);
		}
		
		private function bonus_timer_handler(e:TimerEvent):void
		{
			var rotation_angle:Number=15;
	
			if (count==0) 
				{
					count=8;
					Uni_Bonus.rotation-=15;
					
				}
			if ((count==8)||(count==7)||(count==6))
				{
					Uni_Bonus.y+=5;
				}
			if ((count==3)||(count==5))
				{
					Uni_Bonus.rotation+=15;
				}
			if ((count==4))
				{
					Uni_Bonus.rotation-=15;
					Uni_Bonus.y-=5;
				}
			if ((count==1)||(count==2))
				{
					Uni_Bonus.y-=5;
				}

			count--;
		}
		
		public function Destructor():void
		{
			bonus_jump_timer.stop();
			bonus_jump_timer.removeEventListener(TimerEvent.TIMER, bonus_timer_handler);
			this.removeChild(Uni_Bonus);
			Uni_Bonus = null;
			Bonus_Sound = null;
		}
	}
	
}
