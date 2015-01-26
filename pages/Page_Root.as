package pages {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Page_Root extends MovieClip {

		public function Page_Root() {
			// constructor code
			this.addEventListener(Event.ADDED_TO_STAGE, init);
			this.removeEventListener(Event.REMOVED_FROM_STAGE, removed);
		}
		
		protected function init(e:Event = null) {
			Tracer.log(this, "Init");
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
		}
		protected function removed(e:Event = null) {
			Tracer.log(this, "Removed");
			this.removeEventListener(Event.REMOVED_FROM_STAGE, removed);
		}
		public function showPage(_to:String) {
			try {
				var par:TheLastProject = parent as TheLastProject;
				par.showPage(_to);
			} catch (e:*) {
				Tracer.log(this, "Error Show Page");
			}
		}

	}
	
}
