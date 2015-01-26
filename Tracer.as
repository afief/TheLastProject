package  {
	import flash.utils.getQualifiedClassName;

	public class Tracer {
		
		public static var isShow:Boolean = true;
		public static var allowAll:Boolean = true;
		public static var allow:Array = ["Main", "Registry", "Page_Level", "CountingMoney_Tarikan", "SceneClass", "CredentialDocs"]; //CredentialDocs

		public function Tracer() {
			// constructor code
		}
		
		public static function log(... args) {
			if (!isShow) return;			
			
			if (args.length <= 0) {
				trace("");
				return;
			}
			
			var className:String = "";;	
			if (typeof(args[0]) == "string") {
				className = args[0];
			} else {
				className = getQualifiedClassName(args[0]);
				className = className.split(":")[className.split(":").length-1];
			}
			if ((allow.indexOf(className) < 0) && !allowAll) {
				return;
			}
			
			if (className.length < 15) {
				className += repeatString(" ", 20 - className.length);
			}
			className += "> ";
			
			args.splice(0, 1);
			trace(className, args);
		}
		public static function repeatString(str, num):String {
			var output:String = "";
			for(var i:uint = 0; i < num; i++)
				output += str;
			return output;
		}
		
	}
	
}
