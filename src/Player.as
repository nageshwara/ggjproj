package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	import org.flixel.FlxG;
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
			
			speed = 50;
			maxspeed = speed * 2;

		}
		
		override public function update(): void
		{
			move();
			
			super.update();
		}
		
		public function move(): void
		{
			var d_x:Number = 0;
			var d_y:Number = 0;
			if (FlxG.keys.W)
			{
				--d_y;
			}
			if (FlxG.keys.S)
			{
				++d_y;
			}
			if (FlxG.keys.A)
			{
				--d_x;
			}
			if (FlxG.keys.D)
			{
				++d_x;
			}
			
			
		}
		
		
	}

}