package
{
	
	/**
	 * ...
	 * @author emedine
	 */
	import org.flixel.*;
	import flash.net.*;
	import flash.events.*;
	// import flash.display.Sprite;
	import hexagonstar.util.debug.Debug;
	
	public class Obstac extends FlxGroup
	{
		
		private var numBoxes:Number = 1;
		private var numBorder:Number = 11;
		private var theSplat:Splat;
		
		/// game board info
		public var theWidth:Number = FlxG.width;
		public var theHeight:Number = FlxG.height;
		
		/// LEVEL IDS
		private var theLevelID:Number = 0;
		/// xml for the game data
		private var xmlData:XML;
		private var theXMLPath:String = "../data/worldMapData.xml";
		
		private var theXPos:XMLList;
		private var theYPos:XMLList;
		private var firstNames:XMLList;
		
		public function Obstac():void
		{

			loadObstacData();

			
			
		}
		
		 public function loadObstacData():void{
			Debug.trace("import xml");
			//// import xml
			var xmlLoader:URLLoader = new URLLoader();
			xmlLoader.addEventListener(Event.COMPLETE, parseWorldMapData);
			Debug.trace("I am the path" + theXMLPath);

			try {
				xmlLoader.load(new URLRequest(theXMLPath));
			} catch (e:Error) {
				Debug.trace(e);
			}
			/// check for the current game level
			
			/// spawn the blocks accordingly
				
		}
		
		private function parseWorldMapData(e:Event):void{
			xmlData = new XML(e.target.data);
			numBoxes  = xmlData.worldData[theLevelID].block.length();
			
			theXPos = xmlData.worldData[theLevelID].block.@xPos;
			theYPos = xmlData.worldData[theLevelID].block.@yPos;
			/// iterate thru the xml
			/// position the block according to the xml
			for(var i:int = 0; i<numBoxes; i++){
				
				// var tX:Number = Number(theXPos[i]));
				/// Debug.trace("x number: " + Number(theXPos[i]));
				Debug.trace("x: " + i + " : " + theXPos[i]);
				theSplat = new Splat();
				theSplat.immovable = true;
	
				theSplat.x = theXPos[i];
				theSplat.y = theYPos[i];
				//  theSplat.x =200;
				// theSplat.y -= 200;
				/// theSplat.width = theSplat.height= 40;
				add(theSplat);
			}
			/*
			firstNames = xmlData.player.fname;
			lastNames = xmlData.player.lname;
			playerScores = xmlData.player.high_score;
			playerLevel = xmlData.player.level;
			theDates = xmlData.player.gamedatetime;
			*/
			
			
		}
		
		////////////////// URL LOADER HANDLERS /////////////////
		
		private function httpStatusHandler( e:HTTPStatusEvent ):void {
			//trace("httpStatusHandler:" + e);
		}
		private function securityErrorHandler( e:SecurityErrorEvent ):void {
			trace("securityErrorHandler:" + e);
		}
		private function ioErrorHandler( e:IOErrorEvent ):void {
			trace("ioErrorHandler: " + e);
		}

		/////
	}
}
