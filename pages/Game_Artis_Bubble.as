package pages {
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	
	public class Game_Artis_Bubble extends MovieClip {
		
		private var line:MovieClip = null;
		private var spacing:Number = 25;
		
		public function Game_Artis_Bubble() {
			// constructor code
			
		}
		public function draw(ar:Array, dimensi:Point) {
			//ar = [[0,0],[0,2],[2,2],[2,0], [1,1]];
			var nextPos:Point;
			if (line != null) {
				if (this.getChildIndex(line) >= 0)
					this.removeChild(line);
				line = null;
			}
			line = new MovieClip();
			//drawDots(dimensi);
			
			line.graphics.lineStyle(3, 0x3193AA, 1, false, "normal", "round");
			
			nextPos = new Point((ar[0][0] - dimensi.x/2 + 0.5) * spacing, (ar[0][1] - dimensi.x/2 + 0.5) * spacing);
			
			line.graphics.moveTo(nextPos.x, nextPos.y);
			for (var i:Number = 1; i < ar.length; i++) {
				nextPos = new Point((ar[i][0] - dimensi.x/2 + 0.5) * spacing, (ar[i][1] - dimensi.x/2 + 0.5) * spacing);
				line.graphics.lineTo(nextPos.x, nextPos.y);
			}
			this.addChild(line);
		}
		private function drawDots(dimensi:Point) {
			var nextPos:Point;
			line.graphics.beginFill(0x3193AA);
			for (var i:Number = 0; i < dimensi.y; i++) {
				for (var j:Number = 0; j < dimensi.y; j++) {
					nextPos = new Point((j - dimensi.x/2 + 0.5) * spacing, (i - dimensi.x/2 + 0.5) * spacing);
					line.graphics.drawCircle(nextPos.x, nextPos.y, 2);
				}
			}
			line.graphics.endFill();
		}
		
		public function clear() {
			line.graphics.clear();
		}
	}
	
}
