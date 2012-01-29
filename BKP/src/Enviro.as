package
{
	
	/**
	 * ...
	 * @author emedine
	 */
	import org.flixel.*;
	// import flash.display.Sprite;
	
	public class Enviro extends FlxGroup
	{
		
	
		private var numBoxes:Number = 11;
		private var theBox:Box;
		
		public var theWidth:Number = FlxG.width;
		public var theHeight:Number = FlxG.height;
		
		public function Enviro():void
		{

			initEnviro();

			
			
		}
		private function initEnviro():void{
			/// build roof and floor
						
			/// get our rows and cols
			var theRoofLength:Number = Math.round(theWidth/20);
			var theWallHeight:Number = Math.round(theHeight/20);
			trace(theRoofLength);
			// build roof
			for(var r:Number = 0; r<2; r++){
				for (var i:Number = 0; i<theRoofLength; i++){
					theBox = new Box();
					theBox.immovable = true;
					theBox.x = i*20;
					if(r==1){ /// do floor
						theBox.y = theHeight-20;
					}
					add(theBox);
				}
			}
			/// build walls
			for(var w:Number = 0; w<2; w++){
				for (var j:Number = 0; j<theWallHeight; j++){
					theBox = new Box();
					theBox.immovable = true;
					theBox.y = j*20;
					if(w==1){ /// do floor
						theBox.x = theWidth-20;
					}
					add(theBox);
				}
			}
			
			
		}
		

		/////
	}
}
