package ui
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import utils.Assets;
	import utils.Utils;
	
	import interfaces.IGameState;

	public class Play extends Sprite implements IGameState
	{
		private static const WON_MSG:String = "Congratulations\n you guessed the word!";
		private static const LOST_MSG:String = "Oops! you lost the game!";
		
		private var game:Game;
		
		private var playContainer:Sprite;
		private var gibbet:Sprite;
		
		private var wordList:Vector.<String>;
		private var foundCount:int;
		private var errorCount:int;
		private var guessLetterCells:Vector.<LetterCell>;

		
		public function Play(game:Game)
		{
			this.game = game;
			
			playContainer = Assets.getSprite(Assets.PLAY_SCREEN);
			addChild(playContainer);
			
			hideGibbet();
			
			var keyboard:Sprite = playContainer.getChildByName(Assets.KEYBOARD) as Sprite;
			keyboard.addEventListener(MouseEvent.CLICK, onKeyPress);
			
			Utils.loadWordList(onWordsLoaded);
		}
		
		private function hideGibbet():void {
			gibbet = playContainer.getChildByName(Assets.GIBBET) as Sprite;
			gibbet.visible = false;
			
			for(var i:int; i < gibbet.numChildren; i++) {
				gibbet.getChildAt(i).visible = false;
			}
		}
		
		private function onWordsLoaded(words:Vector.<String>):void {
			wordList = words;
			addLetterCells(getRandomWord());
		}
		
		private function addLetterCells(word:String):void {
			var cellsSprite:Sprite = new Sprite();
			var runningW:int;
			
			guessLetterCells = new Vector.<LetterCell>;
			for(var i:int; i < word.length; i++) {
				var cell:LetterCell = new LetterCell(word.charAt(i));
				cellsSprite.addChild(cell);
				cell.x = runningW;
				runningW += cell.width + 10;
				
				guessLetterCells.push(cell);
			}
			
			addChild(cellsSprite);
			Utils.centerXToParent(cellsSprite);
			cellsSprite.y = 50;
		}
		
		private function getRandomWord():String {
			var randIndex:int = Math.random() * wordList.length;
			return wordList[randIndex].toUpperCase();
		}
		
		private function onKeyPress(e:MouseEvent):void {
			Assets.playSound(Assets.CLICK);
			e.stopImmediatePropagation();
			
			var key:String = e.target.name;
			
			var found:Boolean;
			for each(var cell:LetterCell in guessLetterCells) {
				
				// Correct Guess
				if(cell.visible == false && cell.tf.text == key) {
					cell.visible = true;
					found = true;
					foundCount ++;
				}
			}
			
			// Full word guessed
			if(foundCount >= guessLetterCells.length) {
				winRound();
			}
			
			// Wrong Guess
			if(!found) {
				wrongGuess();
			}
		}
		
		private function wrongGuess():void {
			errorCount ++;
			gibbet.visible = true;
			
			var newGibbet:Sprite = gibbet.getChildByName(Assets.GIBBET + errorCount) as Sprite;
			newGibbet.visible = true;
			
			if(errorCount >= 7) {
				loseRound();
				return;
			}
		}
		
		private function winRound():void {
			game.wonCount++;
			gameOver(WON_MSG);
			
			Assets.playSound(Assets.WIN);
		}
		
		private function loseRound():void {
			game.lostCount++;
			gameOver(LOST_MSG);
			
			Assets.playSound(Assets.LOSE);
		}
		
		public function update():void {
		}
		
		public function destroy():void {
			playContainer.parent.removeChildren();
			playContainer = null;
			gibbet = null;
			wordList.length = 0;
			guessLetterCells.length = 0;
		}
		
		private function gameOver(str:String):void {
			var keyboard:Sprite = playContainer.getChildByName(Assets.KEYBOARD) as Sprite;
			keyboard.visible = false;
			
			var message:TextField = new TextField();
			var textFormat:TextFormat = new TextFormat("Verdana", 24, 0xFFFFFF);
			textFormat.align = TextFormatAlign.CENTER;
			message.defaultTextFormat = textFormat;
			message.text = str;
			message.width = 310;
			message.height = 100;
			addChild(message);
			Utils.centerXToParent(message);
			message.y = 150;
			message.filters = Utils.OUTLINE;
			
			var scoreCount:TextField = new TextField();
			var scoreTextFormat:TextFormat = new TextFormat("Verdana", 20, 0xFFFFFF);
			scoreTextFormat.align = TextFormatAlign.CENTER;
			scoreCount.defaultTextFormat = scoreTextFormat;
			scoreCount.text = "Won: " + game.wonCount + " , Lost: " + game.lostCount;
			addChild(scoreCount);
			scoreCount.width = 250;
			scoreCount.height = 40;
			Utils.centerXToParent(scoreCount);
			Utils.alignBottomToParent(scoreCount, 0);
			scoreCount.filters = Utils.OUTLINE;
			
			this.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void{
				game.changeState(Game.MENU_STATE);
			});
		}
	}

}
