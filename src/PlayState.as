package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.plugin.photonstorm.BaseTypes.Bullet;
	
	public class PlayState extends FlxState
	{
		public var player:Player;
		public var playerBullets:FlxGroup;
		
		public var enviro:Enviro;
		
		public var enemies:FlxGroup;
		public var enemyBullets:FlxGroup;
		
		public static var items:FlxGroup;
		
		private var healthBar:FlxBar;
		
		private var debugText:FlxText;
		
		public static function getPlayer():Player
		{
			return PlayState(FlxG.state).player;
		}
		
		public static function addToGroup(object:FlxObject, group:FlxGroup):void
		{
			if (!group)
			{
				group = new FlxGroup();
			}
			
			group.add(object);
		}
		
		override public function create():void
		{
			//Set the background color to light gray (0xAARRGGBB)
			FlxG.bgColor = 0xffaaaaaa;
			
			/// Create enviro
			enviro = new Enviro();
			add(enviro);
			
			//Create player
			playerBullets = new FlxGroup();
			player = new Player(FlxG.width/2, FlxG.height/2, playerBullets);
			add(player);
			add(playerBullets);
			
			// Create health bar
			healthBar = new FlxBar(16, 64, FlxBar.FILL_LEFT_TO_RIGHT, 64, 8, player, "health");
			healthBar.trackParent(0, -24);
			add(healthBar);
			
			enemies = new FlxGroup();
			enemyBullets = new FlxGroup();
			for (var i:int = 0; i < 10; ++i)
			{
				var randomX:int = (FlxG.random() * FlxG.width);
				var randomY:int = (FlxG.random() * FlxG.height);
				enemies.add(new Enemy(randomX, randomY, enemyBullets));
			}
			add(enemies);
			add(enemyBullets);
			
			items = new FlxGroup;
			add(items);
			
			debugText = new FlxText(0, 0, 100, "Attack: 0");
			add(debugText);
		}
		
		override public function update():void
		{
			FlxG.collide(player, enemies, collidePlayerEnemies);
			FlxG.collide(playerBullets, enemies, collidePlayerBulletsEnemies);
			FlxG.overlap(player, enemyBullets, collidePlayerEnemyBullets);
			FlxG.collide(player, items, collidePlayerItems);
			
			FlxG.collide(player, enviro);
			
			//Updates all the objects appropriately
			super.update();
			
			debugText.text = "Attack: " + player.ATK;
		}
		
		private function collidePlayerEnemies(player:Player, enemy:Enemy): void
		{
			player.hurt(enemy.ATK);
		}
		
		private function collidePlayerEnemyBullets(player:Player, bullet:Bullet): void
		{
			player.hurt(bullet.ATK);
			bullet.kill();
		}
		
		private function collidePlayerBulletsEnemies(bullet:Bullet, enemy:Enemy): void
		{
			enemy.hurt(bullet.ATK);
			bullet.kill();
		}
		
		private function collidePlayerItems(player:Player, item:Item): void
		{
			item.transferAttributesToPlayer();
			item.kill();
		}
	}
}
