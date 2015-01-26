package pages {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	public class Pause_State extends MovieClip {
		
		private var btPlay:MovieClip;
		private var btReplay:MovieClip;
		private var btMenu:MovieClip;
		
		private var par:Page_Root;
		
		public function Pause_State() {
			// constructor code
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event) {
			this.removeEventListener(Event.REMOVED_FROM_STAGE, init);
			
			par = parent as Page_Root;
			
			btPlay = mc_play;
			btMenu = mc_menu;
			btReplay = mc_replay;
			
			btPlay.addEventListener(MouseEvent.CLICK, onPlay);
			btReplay.addEventListener(MouseEvent.CLICK, onReplay);
			btMenu.addEventListener(MouseEvent.CLICK, onMenu);
		}
		private function onPlay(e:MouseEvent) {
			this.dispatchEvent(new Event("resume"));
		}
		private function onMenu(e:MouseEvent) {
			par.showPage("Menu");
		}
		private function onReplay(e:MouseEvent) {
			par.showPage("Game");
		}
	}
	
}
