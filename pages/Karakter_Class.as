package pages {
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.greensock.TweenLite;
	
	public class Karakter_Class extends MovieClip{
		
		private var cn:Number = 1;
		protected var kepala:MovieClip;

		public function Karakter_Class() {
			// constructor code
			
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		protected function init(e:Event = null) {
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			kepala.gotoAndStop(1);
		}
		
		public function setEmosi(n:Number) {
			if ((n >= 1) && (n <= kepala.totalFrames)) {
				kepala.gotoAndStop(n);
				cn = n;
			}
		}
		public function animasiBenar() {
			TweenLite.to(kepala, 0.2, {rotation: -2, onComplete: animasi1});
			function animasi1() {
				TweenLite.to(kepala, 0.2, {rotation: 0, onComplete: animasi3});
			}
			function animasi2() {
				TweenLite.to(kepala, 0.2, {rotation: 0, onComplete: animasi3});
			}
			function animasi3() {
				TweenLite.to(kepala, 0.14, {rotation: -2, onComplete: animasi4});
			}
			function animasi4() {
				TweenLite.to(kepala, 0.2, {rotation: 0});
			}
		}
		public function animasiSalah() {
			TweenLite.to(kepala, 0.2, {rotation: 10, onComplete: animasi1});
			function animasi1() {
				TweenLite.to(kepala, 1, {onComplete: animasi2});
			}
			function animasi2() {
				TweenLite.to(kepala, 0.4, {rotation: 0});
			}
		}
		public function get current():Number {
			return cn;
		}

	}
	
}
