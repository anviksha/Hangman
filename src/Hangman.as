package
{
	import flash.display.Sprite;
	
	import ui.Game;
	
	[SWF(width=310, height=450, frameRate=30, backgroundColor="0x000000")]
	public class Hangman extends Sprite
	{
		public function Hangman()
		{
			super();
			var game:Game = new Game();
			addChild(game);
		}
	}
}