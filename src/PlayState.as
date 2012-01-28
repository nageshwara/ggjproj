package
{
	import org.flixel.*;

	public class PlayState extends FlxState
	{
		public var level:FlxTilemap;
		public var exit:FlxSprite;
		public var coins:FlxGroup;
		public var player:Player;
		public var score:FlxText;
		public var status:FlxText;
		
		override public function create():void
		{
			//Set the background color to light gray (0xAARRGGBB)
			FlxG.bgColor = 0xffaaaaaa;
			
			//Create player
			player = new Player(FlxG.width/2, FlxG.height/2);
			add(player);
			
			
			var enemy:Enemy = new Enemy(FlxG.width / 4, FlxG.height / 4);
			add(enemy);
		}
			
		override public function update():void
		{			
			//Updates all the objects appropriately
			super.update();
		}
	}
}
