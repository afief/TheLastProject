package pages {
	
	import flash.display.MovieClip;
	import pages.Page_Root;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	public class Page_LevelSelect extends Page_Root {
		
		
		public function Page_LevelSelect() {
			// constructor code
		
		}
		protected override function init(e:Event = null) {
			super.init();
			
			btLevel1.addEventListener(MouseEvent.CLICK, onLevelClick);
			btLevel2.addEventListener(MouseEvent.CLICK, onLevelClick);
		}
		private function onLevelClick(e:MouseEvent) {
			Registry.instance.isGameOver = false;
			
			switch (e.currentTarget.name) {
				case "btLevel1":
					Registry.instance.withStory = true;
					break;
				default:
					Registry.instance.withStory = false;
					break;
			}
			if (Registry.instance.withStory)
				showPage("Story");
			else
				showPage("Game");
		}
	}
	
}
