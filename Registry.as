package  {
	
	public class Registry {
		
		public var score:Number = 0;
		public var gameMode:String = GameMode.SINGLEPLAYER;
		public var withStory:Boolean = true;
		public var isGameOver:Boolean = false;
		
		/* Game Mechanic
		1: Programmer
		2: Desainer
		3: Administator
		*/
		public var mechanic:Number = 3;

		private static var _instance:Registry = null;
		public function Registry() {
			// constructor code
			
		}
		public static function get instance():Registry {
			if (_instance == null)
				_instance = new Registry();
			return _instance;
		}
		
		public function get isEndless():Boolean {
			return (gameMode == GameMode.SINGLEPLAYER_ENDLESS);
		}

	}
	
}
