package utils
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;

	public class Assets
	{
		// ASSETS SWF FILE
		public static const SWF_ASSETS:String = "assets/HangmanAssets.swf";
		
		// SYMBOLS
		public static const MENU_SCREEN:String = "menuScreen";
		public static const PLAY_SCREEN:String = "playScreen";
		public static const LETTER_BG:String = "letterCell";
		
		// CHILDREN
		public static const KEYBOARD:String = "keyboard";
		public static const GIBBET:String = "gibbet";
		public static const PLAY_BTN:String = "playBtn";
		
		// SOUNDS
		public static const CLICK:String = "assets/click.mp3";
		public static const WIN:String = "assets/win.mp3";
		public static const LOSE:String = "assets/lose.mp3";
		
		// WORDLIST
		public static const WORDLIST:String = "wordList.txt";
		
		
		public static var applicationDomain:ApplicationDomain;
		
		public static function init(onInit:Function):void {
			var ldr:Loader = new Loader();
			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, swfLoaded);
			var context:LoaderContext = new LoaderContext();
			context.applicationDomain = ApplicationDomain.currentDomain;
			ldr.load(new URLRequest(SWF_ASSETS), context);
			
			function swfLoaded(e:Event):void {
				applicationDomain = ldr.contentLoaderInfo.applicationDomain;
				ldr.contentLoaderInfo.removeEventListener(Event.COMPLETE, swfLoaded);
				
				if(onInit is Function) {
					onInit();
				}
			}
		}
		
		public static function getSprite(name:String):Sprite {
			var spriteClass:Class = applicationDomain.getDefinition(name) as Class;
			return new spriteClass() as Sprite;
		}
		
		private static var _soundChannel:SoundChannel;
		public static function playSound(soundUrl:String):void {
			var request:URLRequest = new URLRequest(soundUrl);
			var clickSound:Sound = new Sound();
			clickSound.load(request);
			_soundChannel = clickSound.play();
		}
		
		public static function stopSound():void {
			if(_soundChannel) {
				_soundChannel.stop();
			}
		}
	}

}