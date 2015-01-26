package obj {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	
	public class Bar extends MovieClip {
		
		private var bar:MovieClip;
		private var tween:TweenLite = null;
		public var duration:Number = 10;
		public var playing:Boolean = false;
		
		public function Bar() {
			// constructor code
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event) {
			bar = mc_bar;
			bar.scaleX  = 0;
		}
		public function restart() {
			bar.scaleX = 0;
			
			if (tween != null)
				tween.kill();
			
			tween = TweenLite.to(bar, duration, {scaleX: 1, ease: Linear.easeNone, onComplete: tweenFinish});
			playing = true;
		}
		public function resume() {
			if (!playing && (tween != null)) {
				tween.resume();
				playing = true;
			}
		}
		public function pause() {
			Tracer.log(this, "PAUSE");
			if (playing && (tween != null) && !tween.paused) {
				Tracer.log(this, "PAUSE");
				tween.pause();
				playing = false;
			}
		}
		public function reset() {
			if (tween != null)
				tween.kill();
			
			bar.scaleX = 0;
			playing = false;
		}
		
		
		private function tweenFinish() {
			this.dispatchEvent(new Event("finish"));
		}
	}
	
}
