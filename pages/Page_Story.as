package pages {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	public class Page_Story extends Page_Root {
		
		
		public function Page_Story() {
			// constructor code
			
		}
		protected override function init(e:Event = null) {
			stop();
			
			SoundBCA.instance.stopBGM();
			SoundBCA.instance.playBGM(BGM_InGame);
			
			this.addEventListener(MouseEvent.CLICK, onClick);
		}
		protected function onClick(e:MouseEvent) {
			if (this.currentFrame < this.totalFrames) {
				this.nextFrame();
			} else {
				showPage("Game");
			}
		}
	}
	
}
