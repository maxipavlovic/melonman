package  {
	
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.utils.*;
	import flash.events.TimerEvent;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	
	public class Game extends MMItems {
		
		private var CreatorTimer,TempTimer,EnemyTimer,UpdatorTimer:Timer;
		private var Container,Container_2,Container_3,map,end_line,in_line,
					_Boom,map1,map2,map3,e_l_1,e_l_2,e_l_3,i_l_1,i_l_2,i_l_3:MovieClip;
		private var AngleArray,AngleArray_2,Array_j,Array_b:Array;
		private var i,c,Level,HMBullets,HMEnemies,ETCounter,ThreeWaves,
					UpKeyCode,LeftKeyCode,RightKeyCode,DownKeyCode:int;
		private var UpKey,DownKey,RightKey,LeftKey,Enemy_fl,Crazy_fl:Boolean;
		private var Speed:Number;
		private var _Melonman:Melonman;
		private var BackUpInfo:BackupClass;
		private var Score, WhatBonus,Bonus1,Bonus2,Bonus3,CountBonuses:Number;
		
		public function Game( Parent: MainMenu ) {
			
			super(Parent);
			Bonus1 = 1;
			Bonus2 = 1;
			Bonus3 = 1;
			BackUpInfo = Parent.SeeBUClass();
			_Melonman = new Melonman();
			_Boom = new Boom();
			Container_3 = new MovieClip();
			map1 = new Map1();
			map2 = new Map2();
			map3 = new Map3();
			e_l_1 = new Map_1_End_Line();
			e_l_2 = new Map_2_End_Line();
			e_l_3 = new Map_3_End_Line();
			i_l_1 = new Map_1_In_Line();
			i_l_2 = new Map_2_In_Line();
			i_l_3 = new Map_3_In_Line();
			_Boom.x = 512;
			_Boom.y = 384;
			i = 0;
			c = 0;
			CountBonuses = 0;
			Container = new MovieClip();
			Container_2 = new MovieClip();
			Array_j = new Array();
			Array_b = new Array();
			AngleArray = new Array();
			AngleArray_2 = new Array();
			Enemy_fl = false;
			UpKey = false;
			DownKey = false;
			RightKey = false;
			LeftKey = false;
			Crazy_fl = true;
			Level = BackUpInfo.SeeLevel();
			HMBullets = -1; 
			HMEnemies = -1;
			ETCounter = BackUpInfo.SeeETCounter();
			Speed = 10;
			ThreeWaves = BackUpInfo.SeeTW();
			UpKeyCode = 38;
			LeftKeyCode = 37;
			RightKeyCode = 39;
			DownKeyCode = 40;
			Score = BackUpInfo.SeeScore();
		}
		
		public function StartGame() {
		
			UpdatorTimer = new Timer(100);
			CreatorTimer = new Timer(200);
			EnemyTimer = new Timer(1000,5);
			var ImPart: int;
			CreatorTimer.start();
			UpdatorTimer.start();
			EnemyTimer.start();
			if( Level == 1 )
			{
				map = map1;
				end_line = e_l_1;
				in_line = i_l_1;
			}
			if( Level == 2 ) 
			{
				map = map2;
				end_line = e_l_2;
				in_line = i_l_2;
			}
			if( Level == 3 ) 
			{
				map = map3;
				end_line = e_l_3;
				in_line = i_l_3;
			}
			map.x = 512;
			map.y = 450;
			end_line.x = 512;
			end_line.y = 384;
			in_line.x = 512;
			in_line.y = 384;
			var bonus:MovieClip = new Bonus();
			Container_3.addChildAt(bonus,0);
			bonus.x = -1000;
			bonus.y = -1000;
			while( !bonus.hitTestObject(in_line) )
			{
				bonus.x = _Random(100,1000);
				bonus.y = _Random(100,700);
				if( bonus.hitTestObject(_Melonman) )
				{
					if( _Random(0,1000) >= 500 )
						ImPart = 1;
					else ImPart = -1;
					bonus.x += _Random(100,150)*_Random(0,2)*ImPart;
					bonus.y += _Random(100,150)*_Random(0,2)*ImPart;
				}
			}
			CountBonuses ++;
			trace(CountBonuses,"CountBonuses");
			this.addChild(end_line);
			this.addChild(in_line);
			this.addChild(map);
			this.addChild(_Melonman);
			this.addChild(Container);
			this.addChild(Container_3);
			this.addChild(Container_2);
			map.addEventListener(KeyboardEvent.KEY_DOWN, moveMap);
			map.addEventListener(KeyboardEvent.KEY_UP, KeysUp);
			map.addEventListener(MouseEvent.MOUSE_DOWN, createBullet);
			map.addEventListener(MouseEvent.MOUSE_UP, MouseUp);
			UpdatorTimer.addEventListener(TimerEvent.TIMER, onUpdatorTick);
			EnemyTimer.addEventListener(TimerEvent.TIMER, ETChange);
			EnemyTimer.addEventListener(TimerEvent.TIMER_COMPLETE, ETComplete);
			this.addEventListener(MouseEvent.MOUSE_MOVE, MouseMove);
			
			stage.focus = map;
		}
		
		private function MouseMove(event:MouseEvent):void
		{
			_Melonman.Turn(mouseY,mouseX);
		}
		
		private function moveMap(event:KeyboardEvent):void
		{	
			if( Crazy_fl )
			{
				var _map_x:Number = map.x;
				var _map_y:Number = map.y; 
				var _in_line_x:Number = in_line.x;
				var _in_line_y:Number = in_line.y; 
				var _end_line_x:Number = end_line.x;
				var _end_line_y:Number = end_line.y; 
				var j,k:int;
				var _bonus:MovieClip;
				for( j = 0; j < CountBonuses; j++ )
				{
					Array_j[j] = [Container_3.getChildAt(j).x,Container_3.getChildAt(j).y];
					trace((Array_j[j])[0]);
				}
				for( j = 0; j <= HMBullets; j++ )
				{
					Array_b[j] = [Container.getChildAt(j).x,Container.getChildAt(j).y];
				}
				if( event.keyCode == UpKeyCode ) UpKey = true;
				if( event.keyCode == LeftKeyCode ) LeftKey = true;
				if( event.keyCode == RightKeyCode ) RightKey = true;
				if( event.keyCode == DownKeyCode ) DownKey = true;
		
				if( UpKey && LeftKey )
				{
					map.x++;
					map.y++;
					in_line.x++;
					in_line.y++;
					end_line.x++;
					end_line.y++;
					for( j = 0; j < CountBonuses; j++ )
					{
						Container_3.getChildAt(j).x++;
						Container_3.getChildAt(j).y++;
					}
					for( j = 0; j <= HMBullets; j++ )
					{
						Container.getChildAt(j).x++;
						Container.getChildAt(j).y++;
					}
				}
				if( UpKey && RightKey )
				{
					map.x--;
					map.y++;
					in_line.x--;
					in_line.y++;
					end_line.x--;
					end_line.y++;
					for( j = 0; j < CountBonuses; j++ )
					{
						Container_3.getChildAt(j).x--;
						Container_3.getChildAt(j).y++;
					}
					for( j = 0; j <= HMBullets; j++ )
					{
						Container.getChildAt(j).x--;
						Container.getChildAt(j).y++;
					}
				}
				if( RightKey && DownKey )
				{
					map.x--;
					map.y--;
					in_line.x--;
					in_line.y--;
					end_line.x--;
					end_line.y--;
					for( j = 0; j < CountBonuses; j++ )
					{
						Container_3.getChildAt(j).x--;
						Container_3.getChildAt(j).y--;
					}
					for( j = 0; j <= HMBullets; j++ )
					{
						Container.getChildAt(j).x--;
						Container.getChildAt(j).y--;
					}
				}
				if( DownKey && LeftKey )
				{
					map.x++;
					map.y--;
					in_line.x++;
					in_line.y--;
					end_line.x++;
					end_line.y--;
					for( j = 0; j < CountBonuses; j++ )
					{
						Container_3.getChildAt(j).x++;
						Container_3.getChildAt(j).y--;
					}
					for( j = 0; j <= HMBullets; j++ )
					{
						Container.getChildAt(j).x++;
						Container.getChildAt(j).y--;
					}
				}
				if( UpKey )
				{ 
					map.y += 1;
					in_line.y += 1;
					end_line.y += 1;
					for( j = 0; j < CountBonuses; j++ )
					{
						Container_3.getChildAt(j).y += 1;
					}
					for( j = 0; j <= HMBullets; j++ )
					{
						Container.getChildAt(j).y++;
					}
				}
				if( DownKey )
				{
					map.y -= 1;
					in_line.y -= 1;
					end_line.y -= 1;
					for( j = 0; j < CountBonuses; j++ )
					{
						Container_3.getChildAt(j).y -= 1;
					}
					for( j = 0; j <= HMBullets; j++ )
					{
						Container.getChildAt(j).y--;
					}
				}
				if( RightKey )
				{
					map.x -= 1;
					in_line.x -= 1;
					end_line.x -= 1;
					for( j = 0; j < CountBonuses; j++ )
					{
						Container_3.getChildAt(j).x -= 1;
					}
					for( j = 0; j <= HMBullets; j++ )
					{
						Container.getChildAt(j).x--;
					}
				}
				if( LeftKey )
				{
					map.x += 1;
					in_line.x += 1;
					end_line.x += 1;
					for( j = 0; j < CountBonuses; j++ )
					{
						Container_3.getChildAt(j).x += 1;
					}
					for( j = 0; j <= HMBullets; j++ )
					{
						Container.getChildAt(j).x++;
					}
				}
				
				if( end_line.hitTestObject(_Melonman) && !(in_line.hitTestObject(_Melonman)) )
				{
					map.x = _map_x;
					map.y = _map_y;
					in_line.x = _in_line_x;
					end_line.x = _end_line_x;
					in_line.y = _in_line_y;
					end_line.y = _end_line_y;
					for( j = 0; j < CountBonuses; j++ )
					{
						Container_3.getChildAt(j).x = (Array_j[j])[0];
						Container_3.getChildAt(j).y = (Array_j[j])[1];
					}
					for( j = 0; j <=HMBullets; j++ )
					{
						Container.getChildAt(j).x = (Array_b[j])[0];
						Container.getChildAt(j).y = (Array_b[j])[1];
					}
				}
				j = 0;
				while( j < CountBonuses )
				{
					if( Container_3.getChildAt(j).hitTestObject(_Melonman) )
					{
						Container_3.swapChildrenAt(j,CountBonuses-1);
						_bonus = Container_3.getChildAt(CountBonuses-1);
						Container_3.removeChildAt(CountBonuses-1);
						_bonus.Destructor();
						_bonus = null;
						CountBonuses --;
						k = _Random(1,3);
						if( k == 1 )
						{
							k = _Random(10,100);
							if( k > 55 )
							{
								Bonus1 = Math.random();
							}
							else
							{
								Bonus1 = _Random(2,4);
							}
						}
						if( k == 2)
						{
							k = _Random(10,100);
							if( k > 55 )
							{
								Bonus2 = Math.random();
							}
							else
							{
								Bonus2 = _Random(2,4);
							}
						}
						if( k == 3)
						{
							Score += _Random(100,2000);
						}
					}
					j++;
				}
				_Melonman.Melonman_render();
			}
		}
		
		private function KeysUp(event:KeyboardEvent):void
		{
			if( event.keyCode == UpKeyCode ) UpKey = false;
			if( event.keyCode == LeftKeyCode ) LeftKey = false;
			if( event.keyCode == RightKeyCode ) RightKey = false;
			if( event.keyCode == DownKeyCode ) DownKey = false;
		}
		
		public function ChangeUpKeyCode( KeyCode: int ):void
		{
			UpKeyCode = KeyCode;
		}
		
		public function ChangeDownKeyCode( KeyCode: int ):void
		{
			DownKeyCode = KeyCode;
		}
		
		public function ChangeRightKeyCode( KeyCode: int ):void
		{
			RightKeyCode = KeyCode;
		}
		
		public function ChangeLeftKeyCode( KeyCode: int ):void
		{
			LeftKeyCode = KeyCode;
		}
		
		private function createBullet(event:MouseEvent):void
		{
			CreatorTimer.addEventListener(TimerEvent.TIMER, CTEvent);
		}
		
		private function CTEvent(event:TimerEvent):void
		{
			var bullet:MovieClip = new Bullet();
			var cy:Number = mouseY - 384; 
			var cx:Number = mouseX - 512;
			var Angle:Number = Math.atan2(cy,cx);
			bullet.x = 512+20*Math.cos(Angle);
			bullet.y = 384+20*Math.sin(Angle);
			bullet.rotation = Angle*180/Math.PI+180;
			AngleArray.push(Angle);
			HMBullets++;
			Container.addChildAt(bullet,HMBullets);
			
		}
		
		private function MouseUp(event:MouseEvent):void
		{
			CreatorTimer.removeEventListener(TimerEvent.TIMER,CTEvent);
		}
		
		private function onUpdatorTick(event:TimerEvent):void
		{
			var _hmEnemies:Enemy;
			var ImPart: int;
			var Angle:Number;
			var Temp_Flag:Boolean;
			i = 0;
			Temp_Flag = true;
			while( i <= HMBullets )
			{
				Angle = AngleArray[i];
				Container.getChildAt(i).x += Bonus1*Speed*Math.cos(Angle);
				Container.getChildAt(i).y += Bonus1*Speed*Math.sin(Angle);
				if( ( Container.getChildAt(i).x > 1200 ) || ( Container.getChildAt(i).y > 900 )
				   || ( Container.getChildAt(i).x < -100 ) || ( Container.getChildAt(i).y < -100 ) )
				{
					Container.swapChildrenAt(i,HMBullets);
					Container.removeChildAt(HMBullets);
					AngleArray[i] = AngleArray[HMBullets];
					AngleArray.pop();
					HMBullets--;
					i--;
				}
				i++;
			}
			var flag:Boolean;
			var Angle_2:Number;
			c = 0;
			while( ( c <= HMEnemies ) && Temp_Flag )
			{
				Angle_2 = AngleArray_2[c];
				Container_2.getChildAt(c).x -= Bonus2*Speed*ETCounter/10*Math.cos(Angle_2);
				Container_2.getChildAt(c).y -= Bonus2*Speed*ETCounter/10*Math.sin(Angle_2);
				i = 0;
				flag = true;
				while( ( i <= HMBullets ) && flag )
				{
					if( Container.getChildAt(i).hitTestObject(Container_2.getChildAt(c)) )
					{
						Score += Math.round( Math.sqrt (
									((Container_2.getChildAt(c)).x)*((Container_2.getChildAt(c)).x) +
									((Container_2.getChildAt(c)).y)*((Container_2.getChildAt(c)).y) ));
						Container.swapChildrenAt(i,HMBullets);
						Container.removeChildAt(HMBullets);
						AngleArray[i] = AngleArray[HMBullets];
						AngleArray.pop();
						HMBullets--;
						Container_2.swapChildrenAt(c,HMEnemies);
						Container_2.removeChildAt(HMEnemies);
						AngleArray_2[c] = AngleArray_2[HMEnemies];
						AngleArray_2.pop();
						HMEnemies--;
						c--;
						flag = false;
					}
					i++;
				}
				if( flag ) if( Container_2.getChildAt(c).hitTestObject(_Melonman) )
				{
					Temp_Flag = false;
				}
				c++;
				if( Container_2.numChildren == 0 && Enemy_fl )
			{
				Enemy_fl = false;
				trace(ThreeWaves);
				ThreeWaves++;
				BackUpInfo.UpdateTW(ThreeWaves);
				if( ThreeWaves == 3 )
				{
					Level++;
					BackUpInfo.UpdateLevel(Level);
					map.x = 512;
					map.y = 450;
					end_line.x = 512;
					end_line.y = 384;
					in_line.x = 512;
					in_line.y = 384;
					Useful();
					StartGame();
				}
				else
				{
					Crazy_fl = false;
					Bonus1 = 1;
					Bonus2 = 1;
					Bonus3 = 1;
					var _Bonus:MovieClip = new Bonus();
					if( ThreeWaves == 1 )
					{
						Container_3.addChildAt(_Bonus,CountBonuses);
						_Bonus.x = -1000;
						_Bonus.y = -1000;
						while( !_Bonus.hitTestObject(in_line) )
						{
							_Bonus.x = _Random(100,1000);
							_Bonus.y = _Random(100,700);
							if( _Bonus.hitTestObject(_Melonman) )
							{
								if( _Random(0,1000) >= 500 )
									ImPart = 1;
								else ImPart = -1;
								_Bonus.x += _Random(100,150)*_Random(0,2)*ImPart;
								_Bonus.y += _Random(100,150)*_Random(0,2)*ImPart;
							}
						}
					}
					if( ThreeWaves == 2 )
					{
						Container_3.addChildAt(_Bonus,CountBonuses);
						_Bonus.x = -1000;
						_Bonus.y = -1000;
						while( !_Bonus.hitTestObject(in_line) )
						{
							_Bonus.x = _Random(100,1000);
							_Bonus.y = _Random(100,700);
							if( _Bonus.hitTestObject(_Melonman) )
							{
								if( _Random(0,1000) >= 500 )
									ImPart = 1;
								else ImPart = -1;
								_Bonus.x += _Random(100,150)*_Random(0,2)*ImPart;
								_Bonus.y += _Random(100,150)*_Random(0,2)*ImPart;
							}
						}
					}
					CountBonuses ++;
					c = 0;
					HMEnemies = -1;
					while( Container_2.numChildren ) Container_2.removeChildAt(0);
					Crazy_fl = true;
					EnemyTimer.start();
				}   
				
			}
			if( !Temp_Flag )
			{
				Level = 1;
				Useful();
				this.addChild(_Boom);
				_Boom.gotoAndPlay(1);
				setTimeout(this.TemptTComplete,3000);
			}
			if( Level == 4 )
			{
				Useful();
				setTimeout(this.TemptTComplete,3000);
			}
			else
				stage.focus = map;
			}
			
		}
		
		private function Useful():void
		{
			i = 0;
			c = 0;
			AngleArray.length = 0;
			AngleArray_2.length = 0;
			HMBullets = -1;
			HMEnemies = -1;
			Bonus1 = 1;
			Bonus2 = 1;
			Bonus3 = 1;
			ETCounter = 0;
			CountBonuses = 0;
			ThreeWaves = 0;
			BackUpInfo.UpdateLevel(Level);
			BackUpInfo.UpdateETCounter(ETCounter);
			BackUpInfo.UpdateTW(ThreeWaves);
			BackUpInfo.UpdateScore(Score);
			Enemy_fl = false;
			UpdatorTimer.stop();
			CreatorTimer.stop(); 
			if( TempTimer.running ) TempTimer.stop();
			this.removeChild(_Melonman);
			while( Container.numChildren) Container.removeChildAt(0);
			while( Container_2.numChildren) Container_2.removeChildAt(0);
			while( Container_3.numChildren) Container_3.removeChildAt(0);
			this.removeChild(Container);
			this.removeChild(Container_2);
			this.removeChild(Container_3);
			this.removeEventListener(MouseEvent.MOUSE_MOVE, MouseMove);
			map.removeEventListener(KeyboardEvent.KEY_DOWN, moveMap);
			map.removeEventListener(KeyboardEvent.KEY_UP, KeysUp);
			map.removeEventListener(MouseEvent.MOUSE_DOWN, createBullet);
			map.removeEventListener(MouseEvent.MOUSE_UP, MouseUp);
			TempTimer.removeEventListener(TimerEvent.TIMER, GTCE);
			UpdatorTimer.removeEventListener(TimerEvent.TIMER, onUpdatorTick);
			EnemyTimer.removeEventListener(TimerEvent.TIMER, ETChange);
			EnemyTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, ETComplete);
		}
		
		private function TemptTComplete():void
		{
			this.removeChild(map);
			if( this.contains(_Boom) ) this.removeChild(_Boom);
			this._Parent.removeChild(this);
			//_Parent.ShowMenu();
			(_Parent.SeeMMResults()).DisableBB();
			(_Parent.SeeMMResults()).AddItem("lol",Score);
			_Parent.AcessTable();
			Score = 0;
		}
		
		private function ETChange(event:TimerEvent):void
		{
			ETCounter++;
			BackUpInfo.UpdateETCounter(ETCounter);
		}
		
		private function ETComplete(event:TimerEvent):void
		{
			var TempValue1:Number = 500;
			var TempValue2:int = ETCounter / 5 * 10;
			TempTimer = new Timer(TempValue1,TempValue2);
			TempTimer.start();
			TempTimer.addEventListener(TimerEvent.TIMER, GTCE);
		}
		
		private function GTCE(event:TimerEvent):void
		{
			var A:Number = _Random(200,600);
			setTimeout(createEnemy,A);
		}
		
		private function createEnemy():void
		{
			Enemy_fl = true;
			var Ang:Number = _Random(1,360) * Math.PI / 180;
			var Dist:Number = _Random(660,740);
			var enemy:MovieClip = new Enemy();
			enemy.x = 512+Dist*Math.cos(Ang);
			enemy.y = 384+Dist*Math.sin(Ang);
			if( enemy.x > 512 )
				enemy.rotationY = 180;
			AngleArray_2.push(Ang);
			Container_2.addChildAt(enemy,c);
			c++;
			HMEnemies++;
		}
		
		private function _Random(low:Number=0, high:Number=1):Number
		{
			return Math.floor(Math.random() * (1+high-low)) + low;
		}
		
		override public function Destructor():void
		{
			
			super.Destructor();
			_Boom = null;
			_Melonman.Destructor();
			_Melonman = null;
			Array_j.length = 0;
			Array_b.length = 0;
			AngleArray.length = 0;
			AngleArray_2.length = 0;
			BackUpInfo = null;
		}

	}
}
