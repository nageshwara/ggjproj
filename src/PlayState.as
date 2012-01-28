package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class PlayState extends FlxState
	{
		public var player:Player;
		public var playerBullets:FlxGroup;
		
		public var enemies:FlxGroup;
		
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
			
			enemies = new FlxGroup;
			enemies.add(new Enemy(FlxG.width / 4, FlxG.height / 4));
			add(enemies);
		}
		
		override public function update():void
		{
			FlxG.collide(player, enemies, collidePlayerEnemies);
			
			//Updates all the objects appropriately
			super.update();
		}
		
		private function collidePlayerEnemies(player:Player, enemy:Enemy): void
		{
			player.hurt(enemy.ATK);
		}
	}
}
