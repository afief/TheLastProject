package pages {
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.events.Event;
	import obj.Dot;
	import flash.events.MouseEvent;
	import com.greensock.TweenLite;
	import obj.Bar;
	import pages.Game_Mechanic;
	
	
	public class Game_Programmer extends Game_Mechanic {
		
		private var arena:MovieClip;
		private var bar:Bar;
		
		public var dimensi:Point = new Point(4, 4);
		public var dotArray:Vector.<Dot> = new Vector.<Dot>();
		
		public var className:String = "Game_Programmer";
		
		public function Game_Programmer() {
			// constructor code
		}
		protected override function init(e:Event = null) {
			super.init();
			
			arena = mc_arena;
			bar = mc_bar;
			bar.addEventListener("finish", barFinish);
		}
		
		public override function prepare() {
			super.prepare();
			
			level = 0;
			toleransi = 3;
			bar.duration = 5;
			prepareDot();
		}
		private function prepareDot() {
			var spacing:Number = 75;
			var np:Point = new Point(arena.width/2,arena.height/2);
			
			np.y -= (dimensi.y-1)/2 * spacing;
			np.x -= (dimensi.x-1)/2 * spacing;
			
			while (dotArray.length > 0) {
				if (arena.getChildIndex(dotArray[dotArray.length-1]) >= 0)
					arena.removeChild(dotArray[dotArray.length-1]);
				dotArray[dotArray.length-1].destroy();
				dotArray.splice(dotArray.length-1,1);
			}
			
			var dot:Dot;
			for (var i:Number = 0; i < dimensi.y; i++) {
				for (var j:Number = 0; j < dimensi.x; j++) {
					dot = new Dot();
					dot.x = np.x;
					dot.y = np.y;
					dot.standBy(Math.floor(Math.random() * 3));
					dot.addEventListener("dotClick", dotClick);
					np.x += spacing;
					
					arena.addChild(dot);
					dotArray.push(dot);
				}
				np.x = arena.width/2 - (dimensi.x-1)/2 * spacing;
				np.y += spacing;
			}
			
			//restart timer
			bar.duration = 5 - (2 * Math.abs(((level>0)?level:1)/10));
			bar.restart();
			
			function dotClick(e:Event) {
				var tdot:Dot = e.currentTarget as Dot;
				
				if (tdot.status == 1) {
					score += 5;
				} else {
					Tracer.log(className, "SALAH KLIK ", toleransi);
					barFinish(null);
				}
				
				tdot.destroy();
				tdot.mouseEnabled = false;
				
				TweenLite.to(tdot, 0.3, {alpha: 0, scaleX: 3, scaleY: 3});
				
				if (numGreen() <= 0) {
					level++;
					par.hud.bar.persen += 10;
					par.karakter.karakter.animasiBenar();
					if ((level > 10) && !isEndless) {
						//benar lalu lanjut
						bar.reset();
						par.showPage("Summary");
					} else {
						prepareDot();
					}
				}
			}
		}
		private function numGreen() {
			var num:Number = 0;
			for (var i:Number = 0; i  < dotArray.length; i++) {
				if ((dotArray[i].status == 1) && dotArray[i].isSet)
					num++;
			}
			//Tracer.log(className, "green > ", num);
			return num;
		}
		public override function onPause() {
			Tracer.log(this, "PAUSE");
			bar.pause()
		}
		public override function onResume() {
			bar.resume();
		}
		private function barFinish(e:Event) {
			//salah lalu lanjut
			bar.reset();
			toleransi--;
			score -= 8
			par.karakter.karakter.animasiSalah();
			par.karakter.karakter.setEmosi(par.karakter.karakter.current+1);
			if ((toleransi < 0) && (!isEndless)) {
				//Registry.instance.mechanic++;
				Registry.instance.isGameOver = true;
				par.showPage("Summary");
			} else {
				prepareDot();
			}
			if (isEndless)
				par.showPage("Summary");
		}
	}
	
}
