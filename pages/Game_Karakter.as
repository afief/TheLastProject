package pages {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class Game_Karakter extends MovieClip {
		
		public var karakter:Karakter_Class;
		
		public function Game_Karakter() {
			// constructor code
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event = null) {
			switch (Registry.instance.mechanic) {
				case 1:
					karakter = new Game_Karakter_Programmer();
					break;
				case 2:
					karakter = new Game_Karakter_Artis();
					break;
				case 3:
					karakter = new Game_Karakter_Composer();
					break;
				case 4:
					karakter = new Game_Karakter_Designer();
					break;
				case 5:
					karakter = new Game_Karakter_Composer();
					break;
				default:
					karakter = new Game_Karakter_Composer();
					break;
			}
			this.addChild(karakter);
		}
		
	}
	
}
