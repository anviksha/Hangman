package utils
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class Utils
	{
		public static const OUTLINE:Array = [new GlowFilter(0x000000)];

		public static function centerXToParent(obj:DisplayObject, padding:Number = 0):void {
			obj.x = (obj.parent.width - obj.width) * 0.5 + padding;
		}

		public static function centerYToParent(obj:DisplayObject, padding:Number = 0):void {
			obj.x = (obj.parent.height - obj.height) * 0.5 + padding;
		}
		
		public static function centerXandYToParent(obj:DisplayObject, padding:Number = 0):void {
			centerXToParent(obj, padding);
			centerYToParent(obj, padding);
		}

		public static function alignBottomToParent(obj:DisplayObject, padding:Number = 0):void {
			obj.y = obj.parent.height - obj.height - padding;
		}
		
		private static var _readWordCB:Function;
		
		public static function loadWordList(loadedCB:Function):void {
			_readWordCB = loadedCB;
			
			var loader:URLLoader = new URLLoader();
			
			loader.addEventListener(Event.COMPLETE, onLoaded);
			loader.load(new URLRequest(Assets.WORDLIST));
		}
		
		private static function onLoaded(event:Event):void {
			(event.currentTarget as URLLoader).removeEventListener(Event.COMPLETE, onLoaded);
			
			var text:String = event.target.data;
			var wordArr:Array = text.split(/\r\n/);
			
			var wordVec:Vector.<String> = new Vector.<String>();
			for each(var word:String in wordArr) {
				wordVec.push(word);
			}
			
			if(_readWordCB != null) {
				_readWordCB(wordVec);
				_readWordCB = null;
			}
		}
	}
}