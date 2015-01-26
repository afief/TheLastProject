package pages {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	
	public class Page_Endless extends Page_Root {
		
		
		
		public function Page_Endless() {
			// constructor code
		}
		protected override function init(e:Event = null) {
			Registry.instance.withStory = false;
			
			btProgrammer.addEventListener(MouseEvent.CLICK, onProgrammer);
			btArtis.addEventListener(MouseEvent.CLICK, onArtis);
			btComposer.addEventListener(MouseEvent.CLICK, onComposer);
			btDesigner.addEventListener(MouseEvent.CLICK, onDesigner);
		}
		private function onProgrammer(e:MouseEvent) {
			Registry.instance.mechanic = 1;
			showPage("Game");
		}
		private function onArtis(e:MouseEvent) {
			Registry.instance.mechanic = 2;
			showPage("Game");
		}
		private function onComposer(e:MouseEvent) {
			Registry.instance.mechanic = 3;
			showPage("Game");
		}
		private function onDesigner(e:MouseEvent) {
			Registry.instance.mechanic = 4;
			showPage("Game");
		}
	}
	
}
