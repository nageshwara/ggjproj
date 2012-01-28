package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class PlayState extends FlxState
	{
		public var player:Player;
		public var playerBullets:FlxGroup;
		
		private var healthBar:FlxBar;
		
		public static function getPlayer():Player
		{
			return PlayState(FlxG.state).player;
		}
		
		override public function create():void
		{
			//Set the background color to light gray (0xAARRGGBB)
			FlxG.bgColor = 0xffaaaaaa;
			
			//Create player
			playerBullets = new FlxGroup();
			player = new Player(FlxG.width/2, FlxG.height/2, playerBullets);
			add(player);
			add(playerBullets);
			
			// Create health bar
			healthBar = new FlxBar(16, 64, FlxBar.FILL_LEFT_TO_RIGHT, 64, 8, player, "health");
			healthBar.trackParent(0, -24);
			add(healthBar);
			
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
