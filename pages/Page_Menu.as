package pages {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	public class Page_Menu extends Page_Root {
		
		public function Page_Menu() {
			// constructor code
		}
		protected override function init(e:Event = null) {
			SoundBCA.instance.stopBGM();
			SoundBCA.instance.playBGM(BGM_Menu);
			
			btStory.addEventListener(MouseEvent.CLICK, onStoryMode);
			btEndless.addEventListener(MouseEvent.CLICK, onEndlessMode);
		}
		private function onEndlessMode(e:MouseEvent) {
			Registry.instance.gameMode = GameMode.SINGLEPLAYER_ENDLESS;
			
			showPage("Endless");
		}
		private function onStoryMode(e:MouseEvent):void {
			
			Registry.instance.gameMode = GameMode.SINGLEPLAYER;
			Registry.instance.mechanic = 1;
			
			showPage("LevelSelect");
			
		}
	}
	
}
