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
	
	public class Game_Composer extends Game_Mechanic {
		
		private var arena:MovieClip;
		private var bar:Bar;
		
		private var mic:Microphone;
		private var soundBar:MovieClip = null;
		private var soundBarTarget:MovieClip = null;
		private var isListen:Boolean = false;
		private var kuning:MovieClip = null;
		private var kuningTween:TweenLite;
		
		private var ukuranTarget:Number = 0;
		private var lebarTarget:Number = 30;
		
		private var lagiPas:Boolean = false;
		private var hitPas:Number = 0;
		private var hitTimer:Number = 2;
		private var tTimer:TextField;
		
		public function Game_Composer() {
			// constructor code
		}
		protected override function init(e:Event = null) {
			super.init();
			
			SoundBCA.instance.stopBGM();
			
			arena = mc_arena;
			bar = mc_bar;
			bar.addEventListener("finish", barFinish);
			
			tTimer = arena.txtTimer;
			tTimer.visible = false;
			
			mic = Microphone.getMicrophone();
			mic.gain = 60;
			mic.rate = 10;
			mic.setUseEchoSuppression(true); 
			mic.setLoopBack(true); 
			mic.setSilenceLevel(5, 1); 
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			mic.addEventListener(ActivityEvent.ACTIVITY, onMicActivity);
			mic.addEventListener(StatusEvent.STATUS, onMicStatus);
		}
		public override function prepare() {
			super.prepare();
			
			toleransi = 3;
			prepareMusic();
		}
		private function prepareMusic() {
			Tracer.log(this, "Prepare Music");
			if (soundBar != null) {
				arena.removeChild(soundBar);
				arena.removeChild(soundBarTarget);
			}
			soundBar = new MovieClip();
			soundBarTarget = new MovieClip();
			
			soundBar.graphics.clear();
			soundBarTarget.graphics.clear();
			
			soundBar.x = arena.width/2;
			soundBar.y = arena.height/2;
			soundBarTarget.x = soundBar.x;
			soundBarTarget.y = soundBar.y;
			
			arena.addChild(soundBar);
			arena.addChild(soundBarTarget);
			
			graphicTarget(soundBarTarget.graphics, Math.random() * 90 + 30);
			
			isListen = true;
			bar.restart();
		}
		private function graphicTarget(gr:Graphics, num:Number) {
			ukuranTarget = num * 1.2;
			
			gr.lineStyle(lebarTarget, 0xff3300, 0.8, false);
			gr.drawCircle(0,0, ukuranTarget);
		}
		private function kuningComplete() {
			level++;
			score += 15;
			par.hud.bar.persen += 10;
			par.karakter.karakter.animasiBenar();
			if (kuningTween)
				kuningTween.kill();
			
			if ((level > 10) && !isEndless) {
				//benar lalu lanjut
				bar.reset();
				par.showPage("Summary");
			} else {
				prepareMusic();
			}
		}
		private function barFinish(e:Event) {
			bar.reset();
			toleransi--;
			score -= 8;
			par.karakter.karakter.animasiSalah();
			par.karakter.karakter.setEmosi(par.karakter.karakter.current+1);
			if ((toleransi < 0) && (!isEndless)) {
				//Registry.instance.mechanic++;
				Registry.instance.isGameOver = true;
				par.showPage("Summary");
			} else {
				prepareMusic();
			}
			if (isEndless)
				par.showPage("Summary");
		}
		private function onEnterFrame(e:Event) {
			if (isListen) {
				var acLevel:Number = mic.activityLevel*1.5;
				
				soundBar.graphics.clear();
				soundBar.graphics.beginFill(0x3193AA);
				soundBar.graphics.drawCircle(0,0,acLevel);
				soundBar.graphics.endFill();
				
				if ((acLevel > (ukuranTarget - (lebarTarget/2))) && (acLevel < (ukuranTarget + (lebarTarget/2)))) {
					//tTimer.visible = true;
					//arena.setChildIndex(tTimer, arena.numChildren-1);
					
					if (hitPas <= 0) {
						kuning = new MovieClip();
						arena.addChild(kuning);
						kuning.x = soundBar.x;
						kuning.y = soundBar.y;
						kuning.graphics.beginFill(0xffcc00, 1);
						kuning.graphics.drawCircle(0,0,50);
						kuning.graphics.endFill();
						kuning.scaleX = 0;
						kuning.scaleY = 0;
						kuningTween = TweenLite.to(kuning, 0.4, {scaleX: (ukuranTarget + lebarTarget/2)/100, scaleY: (ukuranTarget + lebarTarget/2)/100, onComplete: kuningComplete});
					}
					hitPas = 3;
					
				} else {
					if (hitPas > 0) {
						hitPas--;
						if (hitPas <= 0) {
							if (kuning != null) {
								arena.removeChild(kuning);
							}
							if (kuningTween)
								kuningTween.kill();
							kuning = null;
							
						}
					}
				}
			}
		}
		private function onMicActivity(e:ActivityEvent) {
			//trace(mic.activityLevel); 
		}
		private function onMicStatus(e:StatusEvent) {
			trace("status: level=" + e.level + ", code=" + e.code); 
		}
		public override function onPause() {
			bar.pause()
		}
		public override function onResume() {
			bar.resume();
		}
	}
	
}
