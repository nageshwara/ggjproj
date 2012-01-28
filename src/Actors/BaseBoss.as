package Actors
{
	import org.flixel.FlxSprite;
	
	public class BaseBoss extends FlxSprite
	{
		public function BaseBoss(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, SimpleGraphic);
			makeGraphic(15,15,0xff3f3f3f);
			/*maxVelocity.x = 80;
			maxVelocity.y = 200;
			acceleration.y = 200;
			drag.x = maxVelocity.x*4;*/						
		}
	}
}