package obj {
	
	import flash.display.MovieClip;
	
	
	public class HudBar extends MovieClip {
		
		private var nilai:Number = 0;
		
		public function HudBar() {
			// constructor code
		}
		
		public function set persen(nil:Number) {
			masker.scaleY = nil/100;
			nilai = nil;
		}
		public function get persen():Number {
			return nilai;
		}
	}
	
}
