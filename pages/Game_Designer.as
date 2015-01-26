package pages {
	
	import flash.display.MovieClip;
	import obj.Bar;
	import flash.events.Event;
	import flash.media.Microphone;
	import flash.events.ActivityEvent;
	import flash.events.StatusEvent;
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.text.TextField;
	import com.greensock.TweenLite;
	import obj.DesignerBox;
	import flash.geom.Point;
	
	
	public class Game_Designer extends Game_Mechanic {
		
		private var arena:MovieClip;
		private var bar:Bar;
		private var boxArray:Vector.<DesignerBox> = new Vector.<DesignerBox>();
		private var randomPos:Array = new Array();
		private var dimensi:Point = new Point(3,3);
		
		private var box:DesignerBox = null;
		private var sampah:Vector.<DesignerBox> = new Vector.<DesignerBox>();
		
		private var arenaWidth:Number = 0;
		private var arenaHeight:Number = 0;
		
		public function Game_Designer() {
			// constructor code
		}
		protected override function init(e:Event = null) {
			super.init();
			
			toleransi = 3;
			
			arena = mc_arena;
			bar = mc_bar;
			
			arenaWidth = arena.width;
			arenaHeight = arena.height;
			
			bar.addEventListener("finish", barFinish);
		}
		public override function prepare() {
			super.prepare();
			
			bar.duration = 10;
			prepareBox();
		}
		private function prepareBox() {
			Tracer.log(this, "Prepare Box");
			
			if (level >= 8) {
				dimensi = new Point(4,4);
			}
			
			while (boxArray.length > 0) {
				arena.removeChild(boxArray[boxArray.length-1]);
				boxArray.splice(boxArray.length-1, 1);
			}
			while (sampah.length > 0) {
				arena.removeChild(sampah[sampah.length-1]);
				sampah.splice(sampah.length-1, 1);
			}
			
			setRandomPos();
			var spacing:Number = 80;
			var np:Point = new Point(240 - (40 * dimensi.x),240 - (40 * dimensi.y));
			
			//np.y -= (dimensi.y-1)/2 * spacing;
			//np.x -= (dimensi.x-1)/2 * spacing;
			
			//Tracer.log(this, "NPNX", np.x, np.y);
			
			var randomJenisTemp:Array = [0,1,2,3];
			var temp:DesignerBox;			
			for (var i:Number = 0; i < dimensi.y; i++) {
				for (var j:Number = 0; j < dimensi.x; j++) {
					if (isPointExist(randomPos, [j, i])) {
						if (randomJenisTemp.length <= 0)
							randomJenisTemp = [0,1,2,3];
						
						temp = new DesignerBox(0, randomJenisTemp[Math.floor(Math.random() * randomJenisTemp.length)]);
						temp.x = np.x;
						temp.y = np.y;
						arena.addChild(temp);
						boxArray.push(temp);
					}
					np.x += spacing;
				}
				np.x = arenaWidth/2 - (dimensi.x-1)/2 * spacing;
				np.y += spacing;
			}
			prepareDragBox();
			
			bar.duration = 10 - (2 * Math.abs(((level>0)?level:1)/10));
			bar.restart();
		}
		private function onBoxUp(e:Event) {
			Tracer.log(this, "Box Up");
			cekJawaban();
		}
		private function cekJawaban() {
			var i:Number = 0;
			var ketemu:Array = [];
			var boxKena:DesignerBox = null;
			
			while ((i < boxArray.length)) {
				trace(boxArray[i].x, boxArray[i].y, box.x, box.y);
				if (boxArray[i].hitTestObject(box)) {
					//trace("kena", boxArray[i].x, boxArray[i].y, box.x, box.y);
					ketemu.push(boxArray[i]);
				}
				i++;
			}
			var terdekat:Number = 10000;
			while (ketemu.length > 0) {
				if (jarak(ketemu[ketemu.length-1], box) < terdekat) {
					terdekat = jarak(ketemu[ketemu.length-1], box);
					boxKena = ketemu[ketemu.length-1];
				}
				ketemu.splice(ketemu.length-1, 1);
			}
			
			if (boxKena != null){
				if (boxKena.jenis == box.jenis) {
					score += 8;
					box.done();
					par.karakter.karakter.animasiBenar();
				} else {
					box.wrong();
					box.done();
					
					score -= 2;
					
					par.karakter.karakter.animasiSalah();
					par.karakter.karakter.setEmosi(par.karakter.karakter.current+1);
					
					barFinish(null);
				}
				TweenLite.to(box, 0.1, {x: boxKena.x, y: boxKena.y, onComplete: boxNempel});
			} else {
				box.back();
			}
			function boxNempel() {
				sampah.push(box);
				box = null;
				boxArray.splice(boxArray.indexOf(boxKena), 1);
				if (arena.getChildIndex(boxKena) >= 0) {
					arena.removeChild(boxKena);
				}
				prepareDragBox();
				
				if (boxArray.length <= 0) {
					level++;
					
					par.hud.bar.persen += 10;
					if ((level > 10) && !isEndless) {
						//benar lalu lanjut
						bar.reset();
						par.showPage("Summary");
					} else {
						prepareBox();
					}
				}
			}
		}
		private function jarak(mc:MovieClip, mc2:MovieClip):Number {
			function sqr(n:Number) {
				return n * n;
			}
			return Math.sqrt(sqr(mc2.x - mc.x) + sqr(mc2.y - mc.y));
		}
		private function setRandomPos() {
			randomPos = new Array();
			var jumlah:Number = 1 + Math.floor(Math.random() * Math.ceil(dimensi.x * dimensi.y * 3 / 4));
			
			var px:Number;
			var py:Number;
			for (var i:Number = 0; i < jumlah; i++) {
				px = Math.floor(Math.random() * dimensi.x);
				py = Math.floor(Math.random() * dimensi.y);
				while (isPointExist(randomPos, [px, py])) {
					px = Math.floor(Math.random() * dimensi.x);
					py = Math.floor(Math.random() * dimensi.y);
				}
				randomPos.push([px, py]);
			}
		}
		private function isPointExist(ar:Array, p:Array) {
			var res:Boolean = false;
			for (var i:Number = 0; i < ar.length; i++) {
				if ((ar[i][0] == p[0]) && (ar[i][1] == p[1]))
					res = true;
			}
			return res;
		}
		private function prepareDragBox() {
			if (box != null) {
				box.removeEventListener("boxUp", onBoxUp);
			
				arena.removeChild(box);
				box = null;
			}
			box = new DesignerBox(1, randomJenisBoxUtama());
			box.addEventListener("boxUp", onBoxUp);
			arena.addChild(box);
		}
		private function randomJenisBoxUtama():Number {
			var arJenis:Array = [];
			for (var i:Number = 0; i < boxArray.length; i++) {
				if (arJenis.indexOf(boxArray[i].jenis) < 0)
					arJenis.push(boxArray[i].jenis);
			}
			return arJenis[Math.floor(Math.random() * arJenis.length)];
		}
		private function barFinish(e:Event) {
			bar.reset();
			toleransi--;
			score -= 8;
			par.karakter.karakter.animasiSalah();
			par.karakter.karakter.setEmosi(par.karakter.karakter.current+1);
			if ((toleransi < 0) && !isEndless) {
				//Registry.instance.mechanic++;
				Registry.instance.isGameOver = true;
				par.showPage("Summary");
			} else {
				prepareBox();
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
