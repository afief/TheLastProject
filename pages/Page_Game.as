package pages {
	import flash.events.Event;
	import flash.display.MovieClip;
	import pages.Game_Mechanic;
	import flash.events.MouseEvent;
	
	public class Page_Game extends Page_Root {
		
		private var _score:Number = 0;
		private var btPause:MovieClip;
		public var pauseState:Pause_State;
		
		public var toleransi:Number = 2;
		public var level:Number = 0;
		
		public var hud:HUD;
		public var karakter:Game_Karakter;
		
		private var mechanic:Game_Mechanic = null;

		public function Page_Game() {
			// constructor code
			
			
		}
		
		protected override function init(e:Event = null) {
			super.init();
			SoundBCA.instance.stopBGM();
			SoundBCA.instance.playBGM(BGM_InGame);
			
			Registry.instance.isGameOver = false;
			
			hud = mc_hud;
			score = Registry.instance.score;
			karakter = mc_karakter;
			btPause = mc_pause;
			
			btPause.addEventListener(MouseEvent.CLICK, onPause);
			
			prepareMechanic();
			this.setChildIndex(hud, this.numChildren-1);
		}
		public function onPause(e:MouseEvent = null) {
			pauseState = new Pause_State();
			this.addChild(pauseState);
			pauseState.addEventListener("resume", onResume);
			mechanic.onPause();
		}
		public function onResume(e:Event = null) {
			pauseState.removeEventListener("resume", onResume);
			this.removeChild(pauseState);
			pauseState = null;
			mechanic.onResume();
		}
		public function set score(nil:Number) {
			_score = nil;
			hud.setScore(nil);
			Registry.instance.score = _score;
		}
		public function get score():Number {
			return _score;
		}
		private function prepareMechanic() {
			switch (Registry.instance.mechanic) {
				case 1:
					mechanic = new Game_Programmer();
					break;
				case 2:
					mechanic = new Game_Artis();
					break;
				case 3:
					mechanic = new Game_Composer();
					break;
				case 4:
					mechanic = new Game_Designer();
					break;
			}
			this.addChild(mechanic);
			mechanic.prepare();
		}
		
	}
	
}
