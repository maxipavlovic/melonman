package  {
	
	public class ArrayClass {
		
		private var _Array:Array;
		
		public function ArrayClass() {
			
			var i:int;
			_Array = new Array(25);
			for( i = 0; i < 25; i++)
			{
				_Array[i] = ["",0];		
			}
		}
		
		public function ChangeArray( _array: Array ):void
		{
			var i:int;
			for( i = 0; i < 25; i++)
			{
				_Array[i] = [(_array[i])[0],(_array[i])[1]];		
			}
		}
		
		public function SeeArray():Array
		{
			return _Array;
		}
		
		public function Destructor()
		{
			_Array.length = 0;
		}

	}
	
}
