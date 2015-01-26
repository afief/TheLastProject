package obj {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import com.greensock.TweenLite;
	
	
	public class DesignerBox extends MovieClip {
		
		/*tipe
		0 : untuk arena
		1 : untuk digeser
		*/
		private var tipe:Number = 0;
		/* 
		jenis
		0: segitiga
		1: kotak
		2: bulat
		3: x
		*/
		
		public var jenis:Number = 0;
		private var posAwal:Point = new Point(325,-200);
		public var isDown:Boolean = false;
		
		public function DesignerBox(_tipe:Number = 0, _jenis:Number = 0) {
			// constructor code
			tipe = _tipe;
			jenis = _jenis;
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event) {
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			switch(jenis) {
				case 0:
					mc_jenis.gotoAndStop(1);
					break;
				case 1:
					mc_jenis.gotoAndStop(2);
					break;
				case 2:
					mc_jenis.gotoAndStop(3);
					break;
				case 3:
					mc_jenis.gotoAndStop(4);
					break;
				default :
					mc_jenis.gotoAndStop(1);
					break;
			}
			
			if (tipe == 0) {
				gotoAndStop(1);
			} else {
				gotoAndStop(2);
				buttonDrag();
			}
		}
		private function buttonDrag() {
			x = posAwal.x - 100;
			y = posAwal.y;
			alpha = 0.2;
			rotation = 0;
			scaleX = 0.5;
			scaleY = 0.5;
			
			TweenLite.to(this, 0.25, {alpha: 1, x: posAwal.x, rotation: 15, scaleX: 2, scaleY: 2});
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			this.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
			//this.addEventListener(MouseEvent.MOUSE_OUT, onUp);
			this.addEventListener(MouseEvent.MOUSE_UP, onUp);
			
			this.addEventListener(Event.REMOVED_FROM_STAGE, removed);
		}
		
		
		private function onDown(e:MouseEvent) {
			isDown = true;
			this.startDrag(true);
			this.parent.setChildIndex(this, this.parent.numChildren-1);
			
			TweenLite.to(this, 0.4, {scaleX: 1, scaleY: 1, rotation: 0});
		}
		private function onMove(e:MouseEvent) {
			
		}
		private function onUp(e:MouseEvent) {
			if (isDown) {
				isDown = false;
				this.stopDrag();
				this.dispatchEvent(new Event("boxUp"));
			}
		}
		public function wrong() {
			this.gotoAndStop(3);
		}
		public function back() {
			TweenLite.to(this, 1, {x: posAwal.x, y: posAwal.y, scaleX: 2, scaleY: 2, rotation: 15});
		}
		public function done() {
			isDown = false;
			this.removeEventListener(MouseEvent.MOUSE_DOWN, onDown);
			this.removeEventListener(MouseEvent.MOUSE_MOVE, onMove);
			//this.removeEventListener(MouseEvent.MOUSE_OUT, onUp);
			this.removeEventListener(MouseEvent.MOUSE_UP, onUp);
		}
		private function removed(e:Event) {
			this.removeEventListener(Event.REMOVED_FROM_STAGE, removed);
			
			
		}
	}
	
}
