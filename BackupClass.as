package  {
	
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.utils.*;
	import flash.events.TimerEvent;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.filesystem.*;
	import flash.errors.IOError;
	import flash.events.IOErrorEvent;
	import flash.errors.EOFError;
	
	public class BackupClass extends MovieClip {
	
		private var Score:Number;
		private var Level,ETCounter,ThreeWaves:int;
		private var flag,flA,flB,flC,flD,CHANGED:Boolean;
		
		public function BackupClass( ) {
			
			CHANGED = false;
			flag = true;
			flA = false;
			flB = false;
			flC = false;
			flD = false;
			ThreeWaves = 0;
			ETCounter = 0;
			Level = 1;
			Score = 0;
			
			ReadBackupFile();
		}
		
		public function UpdateLevel( _Level: int ):void
		{
			Level = _Level;
			flA = true;
			this.UpdateBackupFile();
		}
		
		public function UpdateETCounter( _ETCounter: int ):void
		{
			ETCounter = _ETCounter;
			flB = true;
			this.UpdateBackupFile();
		}
		
		public function UpdateScore( _Score: Number ):void
		{
			Score = _Score;
			flC = true;
			this.UpdateBackupFile();
		}
		
		public function UpdateTW( _ThreeWaves: int ):void
		{
			ThreeWaves = _ThreeWaves;
			flD = true;
			this.UpdateBackupFile();
		}
		
		public function SeeLevel():int
		{
			return Level;
		}
		
		public function SeeETCounter():int
		{
			return ETCounter;
		}
		
		public function SeeScore():Number
		{
			return Score;
		}
		
		public function SeeTW():int
		{
			return ThreeWaves;
		}
		
		private function UpdateBackupFile():void
		{
			if( flA && flB && flC && flD && flag )
			{
				try
				{
					trace(Level);
					var _ByteArray:ByteArray = new ByteArray();
					_ByteArray.writeObject(this);
					_ByteArray.position = 0;
					var outFile:File = File.userDirectory;
					outFile = outFile.resolvePath("AppData/Local/MELONMAN/BackUp.text");
					var outStream:FileStream = new FileStream();
					outStream.open(outFile,FileMode.WRITE);
					outStream.writeBytes(_ByteArray,0,_ByteArray.length);
					outStream.close();
					
					flA = false;
					flB = false;
					flC = false;
					flD = false;
				}
				catch( e:IOError )
				{
					flag = false;
				}
				
			}
		}
		
		private function ReadBackupFile():void
		{
			try
			{
				var TempClass:BackupClass;
				var _ByteArray:ByteArray = new ByteArray();
				_ByteArray.position = 0;
				var inFile:File = File.userDirectory;
				inFile = inFile.resolvePath("AppData/Local/MELONMAN/BackUp.text");
				var inStream:FileStream = new FileStream();
				inStream.open(inFile,FileMode.READ);
				inStream.readBytes(_ByteArray,0,_ByteArray.length);
				inStream.close();
				try
				{
					TempClass = _ByteArray.readObject();
					if( TempClass != null )
						if( ( this.ETCounter == TempClass.SeeETCounter() ) && ( this.Level == TempClass.SeeLevel() )
				   			&& ( this.Score == TempClass.SeeScore()) )
								CHANGED = false;
						else
						{
							this.UpdateETCounter(TempClass.SeeETCounter());
							this.UpdateLevel(TempClass.SeeLevel());
							this.UpdateScore(TempClass.SeeScore());
							CHANGED = true;
						}
					else
					{
						CHANGED = false;
					}
				}
				catch( e: EOFError )
				{
					CHANGED = false;
				}
			}
			catch( e: IOError )
			{
				CHANGED = false;
			}
		}
		
		public function SeeChanged():Boolean
		{
			return CHANGED;
		}
	
	}
	
}
