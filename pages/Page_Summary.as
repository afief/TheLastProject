package pages {
	
	import flash.display.MovieClip;
	import pages.Page_Root;
	import flash.events.Event;
	import flash.events.MouseEvent
	
	public class Page_Summary extends Page_Root {
		
		
		public function Page_Summary() {
			// constructor code
		}
		protected override function init(e:Event = null) {
			super.init();
			txtScore.text = Registry.instance.score.toString() + " K";
			
			btNext.addEventListener(MouseEvent.CLICK, onNext);
			btRetry.addEventListener(MouseEvent.CLICK, onRetry);
			btMenu.addEventListener(MouseEvent.CLICK, onMenu);
			
			if (Registry.instance.isEndless || Registry.instance.isGameOver) {
				btNext.visible = false;
			} else {
			}
		}
		private function onNext(e:MouseEvent) {
			Registry.instance.mechanic++;
			showPage("Game");
		}
		private function onRetry(e:MouseEvent) {
			if (Registry.instance.isEndless) {
				showPage("Game");
			} else {
				showPage("LevelSelect");
			}
		}
		private function onMenu(e:MouseEvent) {
			showPage("Menu");
		}
	}
	
}
