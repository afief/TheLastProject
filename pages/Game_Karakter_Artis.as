package pages {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class Game_Karakter_Artis extends Karakter_Class {
		
		
		public function Game_Karakter_Artis() {
			// constructor code
		}
		protected override function init(e:Event = null) {
			kepala = mc_kepala;
			super.init();
		}
	}
	
}
