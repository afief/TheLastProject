package pages {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import obj.HudBar;
	
	
	public class HUD extends MovieClip {
		
		public var bar:HudBar;
		
		public function HUD() {
			// constructor code
			
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event) {
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			bar = mc_bar;
			bar.persen = 0;
			
			if (Registry.instance.gameMode == GameMode.SINGLEPLAYER_ENDLESS)
				bar.visible = false;
		}
		public function setScore(sc:Number) {
			txtScore.text = sc.toString() + " K";
		}
	}
	
}
