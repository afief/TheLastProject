package  {
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.events.Event;
	import flash.media.SoundTransform;
	
	public class SoundBCA {
		
		private var bgm:Sound = null;
		private var bgc:SoundChannel;
		private var bgmVolume:Number = 1;
		
		private var isMute:Boolean = false;
		
		private static var _instance:SoundBCA;
		public static function get instance():SoundBCA {
			if (_instance == null) {
				_instance = new SoundBCA();
			}
			return _instance;
		}
		
		public function SoundBCA() {
			// constructor code
			bgmVolume = 1;
		}
		public function playSFX(cls:Class, vol:Number = 1) {
			if (!isMute) {			
				var s:Sound = new cls;
				if (vol != 1)
					s.play(0, 0, new SoundTransform(vol));
				else 
					s.play(0, 0, new SoundTransform(1));
			}
		}
		public function playBGM(cls:Class) {
			/*
			if (bgm != null) {
				bgc.stop();
				bgc.removeEventListener(Event.SOUND_COMPLETE, bgcCompleteHandler);
			}*/
			if (bgm == null) {
				bgm = new cls;
				bgc = bgm.play();
				bgc.soundTransform = new SoundTransform(bgmVolume);
				
				bgc.addEventListener(Event.SOUND_COMPLETE, bgcCompleteHandler);
			}
		}
		private function bgcCompleteHandler(e:Event) {
			bgc = bgm.play();
			bgc.addEventListener(Event.SOUND_COMPLETE, bgcCompleteHandler);
		}
		public function set volumeBGM(num:Number) {
			bgmVolume = num;
			var st:SoundTransform = bgc.soundTransform;
			st.volume = num;
			bgc.soundTransform = st;
		}
		public function stopBGM() {
			if (bgc != null)
				bgc.stop();
			bgm = null;
			bgc = null;
		}
		public function mute() {
			if (bgc != null) {
				isMute = true;
				var st:SoundTransform = bgc.soundTransform;
				st.volume = 0;
				bgc.soundTransform = st;
			}
		}
		public function unmute() {
			if (bgc != null) {
				isMute = false;
				var st:SoundTransform = bgc.soundTransform;
				st.volume = bgmVolume;
				bgc.soundTransform = st;
			}
		}

	}
	
}
