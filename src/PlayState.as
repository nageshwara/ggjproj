package
{
	import attributes.*;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.plugin.photonstorm.BaseTypes.Bullet;
	
	public class PlayState extends FlxState
	{
		public var player:Player;
		public var playerBullets:FlxGroup;
		
		public var obstac:Obstac;
		
		public var enemies:FlxGroup;
		public var enemyBullets:FlxGroup;
		
		public var boss:Enemy;
		
		public static var items:FlxGroup;
		
		private var healthBar:FlxBar;
		private var bossHealthBar:FlxBar;
		
		private var debugText:FlxText;
		private var hud:Hud;
		
		public static function win():void
		{
			return PlayState(FlxG.state).resetLevel(true);
		}
		
		public static function lose():void
		{
			return PlayState(FlxG.state).resetLevel(false);
		}
		
		public static function getPlayer():Player
		{
			return PlayState(FlxG.state).player;
		}
		
		public static function dropText(x:Number, y:Number, text:String):void
		{
			PlayState(FlxG.state).add(new DropText(x, y, text));
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
			FlxG.width = 2000;
			FlxG.height = 2000;
			FlxG.worldBounds = new FlxRect(0, 0, 2000,2000);
			
			//Set the background color to light gray (0xAARRGGBB)
			FlxG.bgColor = 0xffaaaaaa;
			
			/// Create enviro
			obstac = new Obstac();
			add(obstac);
			
			//Create player
			playerBullets = new FlxGroup();
			player = new Player(FlxG.width/2, FlxG.height/2, playerBullets);
			add(player);
			add(playerBullets);
			
			var hudGroup:FlxGroup = new FlxGroup;
			add(hudGroup);
			hud = new Hud(hudGroup, player);
			
			FlxG.camera.follow(player, FlxCamera.STYLE_TOPDOWN);
			
			// Create health barwd
			healthBar = new FlxBar(16, 64, FlxBar.FILL_LEFT_TO_RIGHT, 64, 8, player, "health");
			healthBar.trackParent(0, -24);
			add(healthBar);
			
			enemies = new FlxGroup();
			enemyBullets = new FlxGroup();
			
			add(enemies);
			add(enemyBullets);
			
			items = new FlxGroup;
			add(items);
			
			debugText = new FlxText(0, 0, 100, "Attack: 0");
			add(debugText);
			
			resetLevel();
		}
		
		override public function update():void
		{
			FlxG.collide(player, enemies, collidePlayerEnemies);
			FlxG.collide(playerBullets, enemies, collidePlayerBulletsEnemies);
			FlxG.overlap(player, enemyBullets, collidePlayerEnemyBullets);
			FlxG.collide(player, items, collidePlayerItems);
			FlxG.collide(enemies, enemies);
			
			FlxG.collide(player, obstac);
			FlxG.collide(enemies, obstac);
			
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
			item.dropAttributeText();
			item.transferAttributesToPlayer();
			item.kill();
			
			hud.update();
		}
		
		public function resetLevel(advanceLevel:Boolean = false):void
		{
			var bossAttributes:Array = new Array();
			if (boss != null)
			{
				bossAttributes = boss.attributes;
			}
			
			player.clearAttributes();
			
			items.clear();
			enemies.clear();
			enemyBullets.clear();
			playerBullets.clear();
			
			for (var i:int = 0; i < 10; ++i)
			{
				var randomX:int = (FlxG.random() * FlxG.width);
				var randomY:int = (FlxG.random() * FlxG.height);
				
				var enemy:Enemy = new Enemy(randomX, randomY, enemyBullets);
				switch (Math.floor(FlxG.random() * 7))
				{
					default:
					case 0:
						enemy.addAttribute(new AttackAttribute());
						break;
					case 1:
						enemy.addAttribute(new DefenseAttribute());
						break;
					case 2:
						enemy.addAttribute(new RegenAttribute());
						break;
					case 3:
						enemy.addAttribute(new SpeedAttribute());
						break;
					case 4:
						enemy.addAttribute(new WeaponPistolAttribute());
						break;
					case 5:
						enemy.addAttribute(new WeaponSideAttribute());
						break;
					case 6:
						enemy.addAttribute(new WeaponRearAttribute());
						break;
				}
				enemies.add(enemy);
			}
			boss = new Enemy(300, 300, enemyBullets, true);
			boss.addAttributes(bossAttributes);
			enemies.add(boss);
			
			// Create boss health bar
			if (bossHealthBar)
			{
				bossHealthBar.kill();
			}
			bossHealthBar = new FlxBar(0, 64, FlxBar.FILL_LEFT_TO_RIGHT, 64, 16, boss, "health");
			bossHealthBar.createFilledBar(0xFF000000, 0xFFFF0000, true, 0xFF990000);
			bossHealthBar.trackParent(-8, -24);
			add(bossHealthBar);
			
			player.x = FlxG.width / 2;
			player.y = FlxG.height / 2;
			player.health = Player.INITIAL_HEALTH;
			player.addAttribute(new WeaponPistolAttribute);
			hud.update();
		}
	}
}