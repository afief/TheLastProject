package obj {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.greensock.TweenLite;
	import flash.geom.Point;
	
	
	public class Dot extends MovieClip {
		
		public var status:Number = 0;
		public var isSet:Boolean = false;
		public var isDown:Boolean = false;
		public var path:Point = new Point(0,0);
		public var used:Boolean = false;
		
		public function Dot() {
			// constructor code
	
			this.addEventListener(Event.ADDED_TO_STAGE, init);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removed);
		}
		private function init(e:Event) {
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function removed(e:Event) {
			this.removeEventListener(Event.REMOVED_FROM_STAGE, removed);
			destroy();
		}
		
		//status, 0 idle, 1 allow, 2 disallow
		public function standBy(_status:Number) {
			status = _status;
			if (status == 1) {
				gotoAndStop(2);
			} else if (status == 2) {
				gotoAndStop(3);
			} else {
				gotoAndStop(1);
			}
			if (isSet) return;
			isSet = true;
			
			this.addEventListener(MouseEvent.CLICK, onClick);
			this.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			this.addEventListener(MouseEvent.MOUSE_OVER, onOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, onUp)
			this.addEventListener(MouseEvent.MOUSE_UP, onUp);
		}
		private function onClick(e:MouseEvent) {
			if (status > 0) {
				this.dispatchEvent(new Event("dotClick"));
			}
		}
		private function onDown(e:MouseEvent) {
			if (status > 0) {
				TweenLite.to(this, 0.3, {scaleX: 2, scaleY: 2});
				this.dispatchEvent(new Event("dotDown"));
				isDown = true;
			}
		}
		private function onOver(e:MouseEvent) {
			if (status > 0) {
				TweenLite.to(this, 0.3, {scaleX: 2, scaleY: 2});
				this.dispatchEvent(new Event("dotOver"));
			}
		}
		private function onOut(e:MouseEvent) {
			if ((status > 0) && isDown) {
				TweenLite.to(this, 0.3, {scaleX: 1, scaleY: 1});
				this.dispatchEvent(new Event("dotOut"));
				isDown = false;
			}
		}
		private function onUp(e:MouseEvent) {
			if (status > 0) {
				TweenLite.to(this, 0.3, {scaleX: 1, scaleY: 1});
				this.dispatchEvent(new Event("dotUp"));
				isDown = false;
			}
		}
		public function destroy() {
			if (!isSet) return;
			isSet = false;
			
			this.removeEventListener(MouseEvent.CLICK, onClick);
			this.removeEventListener(MouseEvent.MOUSE_DOWN, onDown);
			this.removeEventListener(MouseEvent.MOUSE_OUT, onUp)
			this.removeEventListener(MouseEvent.MOUSE_UP, onUp);
			this.removeEventListener(MouseEvent.MOUSE_OVER, onOver);
		}
	}
	
}
