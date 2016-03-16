package  {
	
	import flash.utils.Timer;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.display.MovieClip;
	
	public class Enemy extends MovieClip{
		
		private var Wolf_Right_Leg,Wolf_Right_Arm,Wolf_Left_Leg,Wolf_Left_Arm,Wolf_Head,Wolf_Body:MovieClip;
		private var wolf_timer:Timer;
		private var wolf_timer_repeat_count:Number;
		
		public function Enemy() {
			wolf_timer_repeat_count=8;
			Wolf_Right_Leg=new Wolf_Right_Leg_Box();
			Wolf_Right_Arm=new Wolf_Right_Arm_Box();
			Wolf_Left_Leg=new Wolf_Left_Leg_Box();
			Wolf_Left_Arm=new Wolf_Left_Arm_Box();
			Wolf_Head=new Wolf_Head_Box();
			Wolf_Body=new Wolf_Body_Box();
			
			this.addChild(Wolf_Left_Arm);
			this.addChild(Wolf_Left_Leg);
			this.addChild(Wolf_Body);
			this.addChild(Wolf_Head);
			this.addChild(Wolf_Right_Leg);
			this.addChild(Wolf_Right_Arm);
			
			Wolf_Body.x=this.x;
			Wolf_Body.y=this.y;
			
			Wolf_Head.x=this.x + 191 - 180;
			Wolf_Head.y=this.y - 104 + 6;
			
			Wolf_Left_Arm.x=this.x + 280 - 180;
			Wolf_Left_Arm.y=this.y;
			
			Wolf_Left_Leg.x=this.x + 241 - 180;
			Wolf_Left_Leg.y=this.y - 104 + 245;
			
			Wolf_Right_Arm.x=this.x - 8;
			Wolf_Right_Arm.y=this.y - 104 + 117;
			
			Wolf_Right_Leg.x= this.x + 258 - 180;
			Wolf_Right_Leg.y= this.y - 104+ 251;
			
			
			wolf_timer=new Timer (80,0);
			
			this.width=75;
			this.height=100;
			
			wolf_timer.start();
			wolf_timer.addEventListener(TimerEvent.TIMER, wolf_timer_handler);
		}
		
		private function wolf_timer_handler (e:TimerEvent):void
		{
			if( wolf_timer_repeat_count <= 4) 
			{
				Wolf_Left_Arm.rotation += 10;
				Wolf_Right_Arm.rotation -= 10;
				Wolf_Left_Leg.rotation -= 10;
				Wolf_Right_Leg.rotation += 10;
				Wolf_Head.y += 1;
				Wolf_Head.rotation += 2;
			}
			else 
			{
				Wolf_Left_Arm.rotation -= 10;
				Wolf_Right_Arm.rotation += 10;
				Wolf_Left_Leg.rotation += 10;
				Wolf_Right_Leg.rotation -= 10;
				Wolf_Head.y -= 1;
				Wolf_Head.rotation -= 2;
			}
			
			wolf_timer_repeat_count-=1;
			if (wolf_timer_repeat_count == 0) wolf_timer_repeat_count=8;
			
		}
		
		
		public function Destructor():void
		{
			this.removeChild(Wolf_Left_Arm);
			this.removeChild(Wolf_Left_Leg);
			this.removeChild(Wolf_Body);
			this.removeChild(Wolf_Head);
			this.removeChild(Wolf_Right_Leg);
			this.removeChild(Wolf_Right_Arm);
			
			Wolf_Right_Leg = null;
			Wolf_Right_Arm = null;
			Wolf_Left_Leg = null;
			Wolf_Left_Arm = null;
			Wolf_Head = null;
			Wolf_Body = null;
			
			wolf_timer.removeEventListener(TimerEvent.TIMER, wolf_timer_handler);
			
			if( wolf_timer.running ) wolf_timer.stop();
		}
	}
	
}
