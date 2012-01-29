package  
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author emedine
	 */
	public class Rock extends FlxSprite
	{
		[Embed(source = '../data/rock.png')] private var RockSprite:Class;
		[Embed(source = '../data/rock2.png')] private var RockSprite2:Class;
		[Embed(source = '../data/rock3.png')] private var RockSprite3:Class;
		[Embed(source = '../data/rock4.png')] private var RockSprite4:Class;
	
		public static const FRAME_WIDTH:int = 96;
		public static const FRAME_HEIGHT:int = 96;
		
		
		/**
		 * Constructor
		 * 
		 * @param	X
		 * @param	Y
		 */
		public function Rock(): void
		{
			// (BoxImg);
			var rnd:Number =  Math.random()*20 +1;
			loadGraphic(RockSprite, true, false, FRAME_WIDTH, FRAME_HEIGHT);
			// /*
			if(rnd<5){
				loadGraphic(RockSprite, true, false, FRAME_WIDTH, FRAME_HEIGHT);
			} else if (rnd>=5 && rnd <10){
				loadGraphic(RockSprite2, true, false, FRAME_WIDTH, FRAME_HEIGHT);
			}else if(rnd>=10 && rnd<15){
				loadGraphic(RockSprite3, true, false, FRAME_WIDTH, FRAME_HEIGHT);
			}else if(rnd>=15 && rnd<20){
				loadGraphic(RockSprite4, true, false, FRAME_WIDTH, FRAME_HEIGHT);
			}
			// */
			
		}
		
		
/////////
	}

}