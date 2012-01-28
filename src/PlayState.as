package
{
	import Actors.BaseBoss;
	import Actors.Hero;
	
	import org.flixel.*;

	
	public class PlayState extends FlxState
	{
		public var level:FlxTilemap;
		public var exit:FlxSprite;
		public var coins:FlxGroup;
		
		
		[Embed(source = "Levels/second.txt", mimeType = "application/octet-stream")]
		public var mapString:Class;
		
		public var player:Hero;
		public var villain:BaseBoss;
		
		public var score:FlxText;
		public var status:FlxText;
		
		override public function create():void
		{
			//Set the background color to light gray (0xAARRGGBB)
			FlxG.bgColor = 0xffaaaaaa;
			
			//Create a new tilemap using our level data
			level = new FlxTilemap();
			level.loadMap(new mapString,FlxTilemap.ImgAuto,0,0,FlxTilemap.AUTO);
			add(level);
			
			//Create the level exit, a dark gray box that is hidden at first
			exit = new FlxSprite(35*8+1,25*8);
			exit.makeGraphic(14,16,0xff3f3f3f);
			exit.exists = false;
			add(exit);
			
			//Create coins to collect (see createCoin() function below for more info)
			coins = new FlxGroup();
			//Top left coins
			createCoin(18,4);
			createCoin(12,4);
			createCoin(9,4);
			createCoin(8,11);
			createCoin(1,7);
			createCoin(3,4);
			createCoin(5,2);
			createCoin(15,11);
			createCoin(16,11);
			
			
			//Create player (a red box)
			player = new Hero(FlxG.width/2 - 5);
			add(player);
			FlxG.camera.follow(player);
			FlxG.camera.bounds = new FlxRect(0, 0, level.width, level.height);
			
			
			villain = new BaseBoss(player, 2);
			add(villain);
			
			
			/*score = new FlxText(2,2,80);
			score.shadow = 0xff000000;
			score.text = "SCORE: "+(coins.countDead()*100);
			add(score);
			
			status = new FlxText(FlxG.width-160-2,2,160);
			status.shadow = 0xff000000;
			status.alignment = "right";
			switch(FlxG.score)
			{
				case 0: status.text = "Collect coins."; break;
				case 1: status.text = "Aww, you died!"; break;
			}
			add(status);*/
		}
		
		//creates a new coin located on the specified tile
		public function createCoin(X:uint,Y:uint):void
		{
			var coin:FlxSprite = new FlxSprite(X*8+3,Y*8+2);
			coin.makeGraphic(2,4,0xffffff00);
			coins.add(coin);
		}
		
		override public function update():void
		{
			//Player movement and controls
			
			//Updates all the objects appropriately
			super.update();

			//Check if player collected a coin or coins this frame
			FlxG.overlap(coins,player,getCoin);
			
			//Check to see if the player touched the exit door this frame
			FlxG.overlap(exit,player,win);
			
			//Finally, bump the player up against the level
			FlxG.collide(level,player);
			FlxG.collide(level,villain);
			
			
			//Check for player lose conditions
			if(player.y > FlxG.height)
			{
				FlxG.score = 1; //sets status.text to "Aww, you died!"
				FlxG.resetState();
			}
		}
		
		//Called whenever the player touches a coin
		public function getCoin(Coin:FlxSprite,Player:FlxSprite):void
		{
			Coin.kill();
			/*score.text = "SCORE: "+(coins.countDead()*100);
			if(coins.countLiving() == 0)
			{
				status.text = "Find the exit.";
				exit.exists = true;
			}*/
		}
		
		//Called whenever the player touches the exit
		public function win(Exit:FlxSprite,Player:FlxSprite):void
		{
			status.text = "Yay, you won!";
			score.text = "SCORE: 5000";
			Player.kill();
		}
	}
}
