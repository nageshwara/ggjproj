package  
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	import org.flixel.FlxG;
	import org.flixel.plugin.photonstorm.FlxBar;
	
	
	/**
	 * ...
	 * @author 
	 */
	public class Player extends FlxSprite
	{
		[Embed(source = '../data/shark_blue.png')] private var ImgSprite:Class;
		
		public var speed:Number;
		public var maxspeed:Number;
		
		public var direction:Number;
		
		public var EAST:Number = 0;
		public var SOUTHEAST:Number = 45;
		public var SOUTH:Number = 90;
		public var SOUTHWEST:Number = 135;
		public var WEST:Number = 180;
		public var NORTHWEST:Number = 225;
		public var NORTH:Number = 270;
		public var NORTHEAST:Number = 315;
		
		public function Player(X:Number, Y:Number): void
		{
			super(X, Y);
			loadGraphic(ImgSprite, true, false, 57, 34);
			addAnimation("default", [0]);
			
			speed = 100;
			maxspeed = speed * 3;
			maxVelocity = new FlxPoint(maxspeed, maxspeed);
			drag.x = drag.y = 30
			
			health = 100;
		}
		
		public function get position():FlxPoint
		{
			return new FlxPoint(x, y);
		}
		
		override public function update(): void
		{
			move();
			
			super.update();
		}
		
		public function move(): void
		{
			var direction:FlxPoint = new FlxPoint(0, 0);
			if (FlxG.keys.W)
			{
				--direction.y;
			}
			if (FlxG.keys.S)
			{
				++direction.y;
			}
			if (FlxG.keys.A)
			{
				--direction.x;
			}
			if (FlxG.keys.D)
			{
				++direction.x;
			}
			
			// Debug keys
			if (FlxG.keys.NINE)
			{
				health = Math.min(health += 10, 100);
			}
			if (FlxG.keys.EIGHT)
			{
				health = Math.max(health -= 10, 0);
			}
			
			acceleration = new FlxPoint(speed * direction.x, speed * direction.y);
			
			if (direction.x || direction.y)
			{
				angle = FlxU.getAngle(velocity, new FlxPoint(0, 0)) + 90;
			}
			
		}
		
		
	}

}