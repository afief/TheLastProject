package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import pages.Page_Game;
	//import flash.desktop.NativeApplication;+/
	import pages.Page_Splash;
	import pages.Page_Menu;
	import pages.Page_LevelSelect;
	import pages.Page_Summary;
	import pages.Page_Story;
	import pages.Page_Endless;
	
	
	public class TheLastProject extends MovieClip {
		
		private var pSplash:Page_Splash;
		private var pMenu:Page_Menu;
		private var pLevelSelect:Page_LevelSelect;
		private var pGame:Page_Game;
		private var pSummary:Page_Summary;
		private var pStory:Page_Story;
		private var pEndless:Page_Endless;
		
		private var current:String = "Splash";
		
		public function TheLastProject() {
			// constructor code
					
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event) {
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			this["show" + current]();
		}
		
		public function showPage(_to:String) {
			Tracer.log(this, "From " + current + " to " + _to);
			
			switch (current) {
				case "Splash":
					this.removeChild(pSplash);
					pSplash = null;
					break;
				case "Menu":
					this.removeChild(pMenu);
					pMenu = null;
					break;
				case "LevelSelect":
					this.removeChild(pLevelSelect);
					pLevelSelect = null;
					break;
				case "Game" :
					this.removeChild(pGame);
					pGame = null;
					break;
				case "Summary" :
					this.removeChild(pSummary);
					pSummary = null;
					break;
				case "Story":
					this.removeChild(pStory);
					pStory = null;
					break;
				case "Endless":
					this.removeChild(pEndless);
					pEndless = null;
					break
				default:
					break;
					
			}
			
			//SoundBCA.instance.playBGM(BGM_Menu);
			
			current = _to;
			this["show" + current]();
			
			//this.setChildIndex(hitam, this.numChildren-1);
		}
		
		private function showGame() {
			pGame = new Page_Game();
			this.addChild(pGame);
		}
		private function showSplash() {
			pSplash = new Page_Splash();
			this.addChild(pSplash);
		}
		private function showMenu() {
			pMenu = new Page_Menu();
			this.addChild(pMenu);
		}
		private function showLevelSelect() {
			pLevelSelect = new Page_LevelSelect();
			this.addChild(pLevelSelect);
		}
		private function showSummary() {
			pSummary = new Page_Summary();
			this.addChild(pSummary);
		}
		private function showStory() {
			pStory = new Page_Story();
			this.addChild(pStory);
		}
		private function showEndless() {
			pEndless = new Page_Endless();
			this.addChild(pEndless);
		}
	}
	
}
