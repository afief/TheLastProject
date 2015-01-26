package pages {
	import flash.display.MovieClip;
	import flash.events.Event;
	import pages.Page_Game;
	
	public class Game_Mechanic extends MovieClip {
		
		public var gameMode:String = GameMode.SINGLEPLAYER;
		
		public var par:Page_Game;

		public function Game_Mechanic() {
			// constructor code
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		protected function init(e:Event = null) {
			this.addEventListener(Event.ADDED_TO_STAGE, init);
			
			par = parent as Page_Game;
		}
		
		public function get level():Number {
			return par.level;
		}
		public function set level(l:Number) {
			par.level = l;
		}
		public function get score():Number {
			return par.score;
		}
		public function set score(s:Number) {
			par.score = s;
		}
		public function get toleransi():Number {
			return par.toleransi;
		}
		public function set toleransi(t:Number) {
			par.toleransi = t;
		}
		
		public function prepare() {
			Tracer.log(this, "Prepare");
		}
		
		public function game_play() {
			Tracer.log(this, "Play");
		}
		public function game_pause() {
			Tracer.log(this, "Pause");
		}
		public function onPause() {
			
		}
		public function onResume() {
			
		}
		public function get isEndless():Boolean {
			return (Registry.instance.gameMode == GameMode.SINGLEPLAYER_ENDLESS);
		}

	}
	
}
