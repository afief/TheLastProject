package pages {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.greensock.TweenLite;
	
	
	public class Page_Splash extends Page_Root {
		
		
		public function Page_Splash() {
			// constructor code
		}
		protected override function init(e:Event = null) {
			super.init();
			
			TweenLite.to(this, 3, {onComplete: splashFinish});
		}
		private function splashFinish() {
			showPage("Menu");
		}
	}
	
}
