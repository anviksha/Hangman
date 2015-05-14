package ui
{
	import flash.display.Sprite;
	
	import utils.Assets;
	
	import interfaces.IGameState;
	
	public class Game extends Sprite
	{
		public static const MENU_STATE:int = 0;
		public static const PLAY_STATE:int = 2;
		
		public static var screenWidth:Number;
		public static var screenHeight:Number;
		
		public static var sound:Boolean = true;
		public static var music:Boolean = true;
		
		public var wonCount:int;
		public var lostCount:int;

		private var _currentState:IGameState;
		private var _destroyState:IGameState;
		
		public function Game()
		{
			Assets.init(onAssetLoaded);
		}
		
		public function onAssetLoaded():void {
			changeState(MENU_STATE);
		}

		public function changeState(state:int):void {
			if(_currentState != null) {
				_destroyState = _currentState;
				destroyState();
			}
			
			switch(state) {
				case MENU_STATE:
					_currentState = new Menu(this);
					break;
				case PLAY_STATE:
					Assets.stopSound();

					_currentState = new Play(this);
					break;
			}
			addChild(Sprite(_currentState));
		}
		
		private function destroyState():void {
			if(_destroyState) {
				_destroyState.destroy();
				_destroyState = null;
			}
		}
		
	}
}