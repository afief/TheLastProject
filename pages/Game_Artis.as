package pages {
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.events.Event;
	import obj.Dot;
	import flash.events.MouseEvent;
	import com.greensock.TweenLite;
	import obj.Bar;
	import pages.Game_Mechanic;
	
	
	
	public class Game_Artis extends Game_Mechanic {
		
		private var arena:MovieClip;
		private var bar:Bar;
		private var bubble:Game_Artis_Bubble;
		
		public var dimensi:Point = new Point(3,3);
		public var dotArray:Vector.<Dot> = new Vector.<Dot>();
		
		public var className:String = "Game_Artis";
		
		private var isDown:Boolean = false;
		private var line:MovieClip = null;
		private var lineDot:Vector.<Dot> = new Vector.<Dot>();
		
		private var lineAnswer:Array;
		private var lineLength:Number = 4;
		
		public function Game_Artis() {
			// constructor code
		}
		protected override function init(e:Event = null) {
			super.init();
			
			level = 0;
			
			arena = mc_arena;
			bubble = mc_bubble;
			bar = mc_bar;
			bar.addEventListener("finish", barFinish);
		}
		
		public override function prepare() {
			super.prepare();
			
			toleransi = 3;
			bar.duration = 5;
			
			prepareDot();
		}
		private function prepareAnswer() {
			lineAnswer = new Array();
			
			var px:Number = 0;
			var py:Number = 0;			
			
			if (level >= 5)
				dimensi = new Point(4,4);
			else
				dimensi = new Point(3,3);
			
			px = Math.floor(Math.random() * dimensi.x);
			py = Math.floor(Math.random() * dimensi.y);
			
			lineAnswer.push([px,py]);
			
			var p:Point;
			var sisaRand:Number = 5;
			for (var i:Number = 1; i < lineLength; i++) {
				p = randomFrom(new Point(px,py));
				Tracer.log(this, "random ", p, " exist", lineAnswer);
				sisaRand = 5;
				while ((!p || isPointExist(lineAnswer, [p.x, p.y])) && (sisaRand > 0)) {
					p = randomFrom(new Point(px,py));
					sisaRand--;
				}
				if (sisaRand <= 0) Tracer.log(this, "duh random ", sisaRand);
				px = p.x;
				py = p.y;
				lineAnswer.push([px,py]);
			}
			Tracer.log(this, lineAnswer);
			bubble.draw(lineAnswer, dimensi);
			
			function randomFrom(p:Point):Point {
				var poss:Array = [];
				if (posible(new Point(p.x-1, p.y)))
					poss.push(new Point(p.x-1, p.y));
				if (posible(new Point(p.x+1, p.y)))
					poss.push(new Point(p.x+1, p.y));
				if (posible(new Point(p.x, p.y-1)))
					poss.push(new Point(p.x, p.y-1));
				if (posible(new Point(p.x, p.y+1)))
					poss.push(new Point(p.x, p.y+1));
				if (poss.length <= 0) trace("KOSONG RANDOM");
				return poss[Math.floor(Math.random() * poss.length)];
			}
			function posible(p:Point) {
				if ((p.x >= 0) && (p.x < dimensi.x) && (p.y >= 0) && (p.y < dimensi.y)) {
					if (isPointExist(lineAnswer, [p.x, p.y]))
						return false;
					return true;
				}
				return false;
			}
		}
		private function prepareDot() {
			prepareAnswer();
			
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
					dot.path.x = j;
					dot.path.y = i;
					dot.standBy(1);
					dot.addEventListener("dotDown", dotDown);
					dot.addEventListener("dotOver", dotOver);

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
					
			function dotDown(e:Event) {
				//Tracer.log(className, "dot down");
				var tdot:Dot = e.currentTarget as Dot;
				isDown = true;
				
				if (line != null)
					arena.removeChild(line);
				
				line = new MovieClip();
				arena.addChild(line);
				line.mouseEnabled = false;
					
				lineDot = new Vector.<Dot>();
				tdot.used = true;
				
				lineDot.push(tdot);
				
				stage.addEventListener(MouseEvent.MOUSE_UP, stageUp);
			}
			function dotOver(e:Event) {
				var tdot:Dot = e.currentTarget as Dot;
				
				if (isDown && !tdot.used && (lineDot.indexOf(tdot) < 0)) {
					//Tracer.log(className, "dot over");
					
					lineDot.push(tdot);
					tdot.used = true;
					
					draw();
				}
			}
			function draw() {
				line.graphics.clear();
				line.graphics.lineStyle(10, 0x3193AA);
				line.graphics.moveTo(lineDot[0].x, lineDot[0].y);
				
				for (var i:Number = 1; i < lineDot.length; i++) {
					line.graphics.lineTo(lineDot[i].x, lineDot[i].y);
				}
			}
			function stageUp(e:Event) {
				stage.removeEventListener(MouseEvent.MOUSE_UP, stageUp);
				if (isDown) {
					//Tracer.log(className, "dot up");
					isDown = false;
					
					if (line != null)
						lineIlang();
						
					if (cekAnswer()) {
						//jawaban benar
						level++;
						score += 15;
						par.hud.bar.persen += 10;
						par.karakter.karakter.animasiBenar();
						if ((level > 10) && !isEndless) {
							//Registry.instance.mechanic++;
							par.showPage("Summary");
						} else {
							prepareDot();
						}
					} else {
						barFinish(null);
					}
					while (lineDot.length > 0) {
						lineDot[lineDot.length-1].used = false;
						lineDot.splice(lineDot.length-1, 1);
					}
				}
				
				function lineIlang() {
					arena.removeChild(line);
					line = null;
				}
			}
		}
		private function cekAnswer():Boolean {
			//Tracer.log(this, "Answer Length ", lineDot.length);
			var dariAwal:Boolean = false;
			if ((lineAnswer[0][0] == lineDot[0].path.x) && (lineAnswer[0][1] == lineDot[0].path.y))
				dariAwal =true;
				
			var hasil:Boolean = true;
			var i:Number;
			if (dariAwal) {
				Tracer.log(this,"dari depan");
				for (i = 0; i < lineDot.length; i++) {
					Tracer.log(this, "Answer ", lineDot[i].path.x, lineDot[i].path.y);
					if ((lineAnswer[i][0] != lineDot[i].path.x) || (lineAnswer[i][1] != lineDot[i].path.y)) {
						hasil = false;
						Tracer.log(this, "salah ", lineAnswer[i][0], lineDot[i].x, lineAnswer[i][1], lineDot[i].y);
					}
				}
			} else {
				Tracer.log(this,"dari belakang");
				for (i = lineDot.length-1; i >= 0; i--) {
					Tracer.log(this, "Answer ", lineDot[i].path.x, lineDot[i].path.y, " kunci ", lineAnswer[(lineDot.length-1)-i][0], lineAnswer[(lineDot.length-1)-i][1]);
					if ((lineAnswer[(lineDot.length-1)-i][0] != lineDot[i].path.x) || (lineAnswer[(lineDot.length-1)-i][1] != lineDot[i].path.y)) {
						hasil = false;
						Tracer.log(this, "salah ", lineAnswer[(lineDot.length-1)-i][0], lineDot[i].x, lineAnswer[(lineDot.length-1)-i][1], lineDot[i].y);
					}
				}
			}
			return hasil;
		}
		private function isPointExist(ar:Array, p:Array) {
			var res:Boolean = false;
			for (var i:Number = 0; i < ar.length; i++) {
				if ((ar[i][0] == p[0]) && (ar[i][1] == p[1]))
					res = true;
			}
			return res;
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
		private function barFinish(e:Event) {
			bar.reset();
			toleransi--;
			Tracer.log(className, "SALAH", toleransi);
			score -= 10;
			par.karakter.karakter.setEmosi(par.karakter.karakter.current+1);
			par.karakter.karakter.animasiSalah();
			prepareDot();
			
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
		public override function onPause() {
			bar.pause()
		}
		public override function onResume() {
			bar.resume();
		}
	}
	
}
