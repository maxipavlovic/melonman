package  {
	
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
    import flash.utils.*;
    import flash.net.FileFilter;
	import flash.filesystem.*;
	import flash.errors.IOError;
	import flash.events.IOErrorEvent;
	import flash.errors.EOFError;
	
	public class MMResults extends MMServeItems {
		
		private var _ToMenu_btn:MovieClip;
		private var CirclesContainer:MovieClip;
		private var _Forward_btn:MovieClip;
		private var _Backwards_btn:MovieClip;
		private var _ActiveSCircle:MovieClip;
		private var Counter:int;
		private var A_R_T_E_M:MovieClip;
		private var TableContainer:MovieClip;
		private var ResultsTable:Array;
		private var _Delete_btn:MovieClip;
		private var EOFFlag:Boolean;

		public function MMResults( Parent: MainMenu ) {
			
			super(Parent);
			Counter = 1;
			
			var i,j:int;
			ResultsTable = new Array(25);
			_ToMenu_btn = new ToMenu_btn();
			_Forward_btn = new Forward_btn();
			_Backwards_btn = new Backwards_btn();
			CirclesContainer = new MovieClip();
			TableContainer = new MovieClip();
			A_R_T_E_M = new Result_Table_Error_Message();
			A_R_T_E_M.x = 50;
			A_R_T_E_M.y = 75;
			_Delete_btn = new Delete_btn();
			for( i = 0; i < 5; i++)
			{
				CreateCircle(i);
				CreateString(i);
			}
			_ToMenu_btn.x = 512;
			_ToMenu_btn.y = 700;
			_ToMenu_btn.buttonMode = true;
			_ActiveSCircle = new ActiveSCircle();
			_ActiveSCircle.x = 450;
			_ActiveSCircle.y = 600;
			_Delete_btn.x = 970;
			_Delete_btn.y = 600;
			_Forward_btn.x = 500;
			_Forward_btn.y = 500;
			_Backwards_btn.x = 400;
			_Backwards_btn.y = 500;
			
			_Back_btn.addEventListener(MouseEvent.CLICK, ShowMenuEvent);
			_ToMenu_btn.addEventListener(MouseEvent.CLICK, ShowMenuEvent);
		}
		
		public function ShowTable():void
		{
			ReadTable();
			if( EOFFlag )
			{
				FillTable(Counter);
			
				_Forward_btn.buttonMode = true;
				_Backwards_btn.buttonMode = true;
				_Forward_btn.enabled = true;
				_Backwards_btn.enabled = false;
				_Backwards_btn.visible = false;
				
				this.addChild(CirclesContainer);
				this.addChild(_ActiveSCircle);
				this.addChild(_Forward_btn);
				this.addChild(_Backwards_btn);
				this.addChild(_Delete_btn);
				this.addChild(TableContainer);
				
				_Forward_btn.addEventListener(MouseEvent.CLICK, ForwardClicked);
				_ToMenu_btn.addEventListener(MouseEvent.CLICK, ShowMenuEvent);
				_Delete_btn.addEventListener(MouseEvent.CLICK, DeleteTable);
			}
			else
			{
				this.addChild(A_R_T_E_M);
			}
		}
		
		public function AddItem( Name: String, Score: Number ):void
		{
			if( !EOFFlag )
			{
				var i:int;
				for( i = 0; i < 25; i++)
				{
					ResultsTable[i] = ["",0];		
				}
			}
			if( Score > (ResultsTable[24])[1] )
			{
				var flag:Boolean = true;
				var i1:int;
				i = 0;
				while( flag )
				{
					if( (ResultsTable[i])[1] <= Score )
					{
						flag = false;
						i1 = i;
					}
					i++;
				}
				for( i = (i1 + 1) ; i < 25; i++)
				{
					ResultsTable[i] = [(ResultsTable[i-1])[0],(ResultsTable[i-1])[1]];
				}
				ResultsTable[i] = [Name,Score];
				WriteTable( Math.round(i/5) );
			}
		}
		
		private function DeleteTable(_event:MouseEvent):void
		{
			ResultsTable.length = 0;
		}
		
		private function CreateString( i: int ):void
		{
			var NameLabel:MovieClipLabel = new MovieClipLabel();
			var ScoreLabel:MovieClipLabel = new MovieClipLabel();
			NameLabel.x = 150;
			NameLabel.y = 100 + i*100;
			ScoreLabel.x = 400;
			ScoreLabel.y = 100 + i*100;
			TableContainer.addChildAt(NameLabel,i*2);
			TableContainer.addChildAt(ScoreLabel,i*2+1);
		}
		
		private function ReadTable():void
		{
			var TempArray:ArrayClass;
			var _ByteArray:ByteArray = new ByteArray();
			_ByteArray.position = 0;
			try
			{
				try
				{
					var inFile:File = File.userDirectory;
					inFile = inFile.resolvePath("AppData/Local/MELONMAN/Results.text");
					var inStream:FileStream = new FileStream();
					inStream.open(inFile,FileMode.READ);
					inStream.readBytes(_ByteArray,0,_ByteArray.length);
					inStream.close();
					//TempArray = _ByteArray.readObject();
				}
				catch( e:IOError )
				{
					EOFFlag = false;
				}
				
			}
			catch( e:EOFError )
			{
				EOFFlag = false;
			}
			if( EOFFlag )
			{
				var j:int;
				for( j = 0; j < 25; j++)
				{
					//ResultsTable[j] = [((TempArray.SeeArray())[j])[0],((TempArray.SeeArray())[j])[1]];		
				}
				TempArray.Destructor();
				TempArray = null;
			}
		}
		
		private function WriteTable(i:int):void
		{
			try
			{
				var TempArray:ArrayClass = new ArrayClass();
				var _ByteArray:ByteArray = new ByteArray();
				_ByteArray.writeObject(TempArray);
				_ByteArray.position = 0;
				var outFile:File = File.userDirectory;
				outFile = outFile.resolvePath("AppData/Local/MELONMAN/Results.text");
				var outStream:FileStream = new FileStream();
				outStream.open(outFile,FileMode.WRITE);
				outStream.writeBytes(_ByteArray,0,_ByteArray.length);
				outStream.close();
				EOFFlag = true;
			}
			catch( e:IOError )
			{
				EOFFlag = false;
			}
			//FillTable( i );
		}
	
		private function FillTable( i: int ):void
		{
			if( EOFFlag )
			{
				var j,k,temp:int;
				var TT:MovieClipLabel;
				temp = i*5;
				k = 0;
				for( j = temp; j < (temp + 5); j++)
				{
					TT = ( this.TableContainer.getChildAt(k*2) as MovieClipLabel );
					TT.ChangeText((ResultsTable[j])[0]) ;
					TT = ( this.TableContainer.getChildAt(k*2+1) as MovieClipLabel );
					TT.ChangeNumber(5);
					k++;
				}
			}
			
		}
		
		private function ForwardClicked(_event:MouseEvent):void
		{
			Counter++;
			FillTable(Counter);
			_ActiveSCircle.x += 20;
			if( Counter == 2 )
			{
				_Backwards_btn.addEventListener(MouseEvent.CLICK, BackwardsClicked);
				_Backwards_btn.enabled = true;
				_Backwards_btn.visible = true;
			}
			if( Counter == 5 )
			{
				_Forward_btn.removeEventListener(MouseEvent.CLICK, ForwardClicked);
				_Forward_btn.enabled = false;
				_Forward_btn.visible = false;
			}
		}
		
		private function BackwardsClicked(_event:MouseEvent):void
		{
			Counter--;
			FillTable(Counter);
			_ActiveSCircle.x -= 20;
			if( Counter == 4 )
			{
				_Forward_btn.addEventListener(MouseEvent.CLICK, ForwardClicked);
				_Forward_btn.enabled = true;
				_Forward_btn.visible = true;
			}
			if( Counter == 1 )
			{
				_Backwards_btn.removeEventListener(MouseEvent.CLICK, BackwardsClicked);
				_Backwards_btn.enabled = false;
				_Backwards_btn.visible = false;
			}
		}
		
		private function ShowMenuEvent(_event:MouseEvent):void
		{
			_Parent.removeChild(this);
			this.ShowMenu();
		}
		
		private function CreateCircle( i: int ):void
		{
			var _NotActiveSCircle:MovieClip = new NotActiveSCircle();
			_NotActiveSCircle.x = 450 + 20*i;
			_NotActiveSCircle.y = 600;
			CirclesContainer.addChild(_NotActiveSCircle);
		}
		
		public function DisableBB():void
		{
			this.addChild(_ToMenu_btn);
			this.removeChild(_Back_btn);
		}
		
		public function EnableBB():void
		{
			if( this.contains(_ToMenu_btn) )
				this.removeChild(_ToMenu_btn);
			if( !this.contains(_Back_btn) )
				this.addChild(_Back_btn);
		}
		
		override protected function ShowMenu():void
		{
			super.ShowMenu();
		}
		
		override public function Destructor():void
		{
			if( EOFFlag )
			{
				this.removeChild(CirclesContainer);
				this.removeChild(_ActiveSCircle);
				this.removeChild(_Delete_btn);
				this.removeChild(TableContainer);
				this.removeChild(_Forward_btn);
				this.removeChild(_Backwards_btn);
				this.removeChild(A_R_T_E_M);
			}
			
			while( CirclesContainer.numChildren ) CirclesContainer.removeChildAt(0);
			while( TableContainer.numChildren ) TableContainer.removeChildAt(0);
			
			if( _Forward_btn.enabled )
				_Forward_btn.removeEventListener(MouseEvent.CLICK, ForwardClicked);
			if( _Backwards_btn.enabled )
				_Backwards_btn.removeEventListener(MouseEvent.CLICK, BackwardsClicked);
				
			_ToMenu_btn.removeEventListener(MouseEvent.CLICK, ShowMenuEvent);
			_Back_btn.removeEventListener(MouseEvent.CLICK, ShowMenuEvent);
			_Delete_btn.removeEventListener(MouseEvent.CLICK, DeleteTable);
			TableContainer = null;
			_ToMenu_btn = null;
			CirclesContainer = null;
			_Forward_btn = null;
			_Backwards_btn = null;
			_ActiveSCircle = null;
			ResultsTable.length = 0;
			_Delete_btn = null;
			super.Destructor();
		}

	}
	
}
