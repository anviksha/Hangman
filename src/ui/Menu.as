package ui
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import utils.Assets;
	
	import interfaces.IGameState;

	public class Menu extends Sprite implements IGameState
	{
		private var game:Game;
		private var menuContainer:Sprite;
		
		public function Menu(game:Game)
		{
			this.game = game;
			
			menuContainer = Assets.getSprite(Assets.MENU_SCREEN);
			addChild(menuContainer);
			
			var sprite:Sprite = menuContainer.getChildByName(Assets.PLAY_BTN) as Sprite;
			sprite.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(e:MouseEvent):void {
			game.changeState(Game.PLAY_STATE);
		}
		
		public function update():void {
			
		}
		
		public function destroy():void {
			menuContainer.parent.removeChildren();
			menuContainer = null;
		}
	}
	
}