package ui
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import utils.Assets;
	import utils.Utils;
	
	public class LetterCell extends Sprite {
		
		public var key:String;
		public var tf:TextField;
		public var keyVisible:Boolean;
		
		public function LetterCell(key:String) {
			this.key = key;
			
			var bgSprite:Sprite = Assets.getSprite(Assets.LETTER_BG);
			bgSprite.width = 30;
			bgSprite.height = 35;
			addChild(bgSprite);
			
			tf = new TextField();
			var textFormat:TextFormat = new TextFormat("Verdana", 24, 0x000000);
			textFormat.align = TextFormatAlign.CENTER;
			
			tf.defaultTextFormat = textFormat;
			tf.text = key;
			tf.width = 30;
			tf.height = 35;
			tf.visible = keyVisible;
			
			addChild(tf);
			Utils.centerXandYToParent(tf);
		}
		
		override public function set visible(value:Boolean):void {
			tf.visible = value;
		}
		
		override public function get visible():Boolean {
			return tf.visible;
		}
	}
}