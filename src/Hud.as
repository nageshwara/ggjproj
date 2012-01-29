package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxText;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;

	import attributes.*;
	
	/**
	 * ...
	 * @author 
	 */
	public class Hud extends FlxSprite
	{
		public var grpHud:FlxGroup;
		public var grpText:FlxGroup;
		public var grpItems:FlxGroup;
		public var player:Player;
		
		public var attributeValues:Array;
		
		[Embed(source = '../data/hudbg.png')] private var ImgBg:Class;
		
		public function Hud(hudGroup:FlxGroup, player:Player ) 
		{
			grpHud = hudGroup;
			this.player = player;

			
			var bg:FlxSprite = new FlxSprite(0, 0);
			bg.loadGraphic(ImgBg);
			bg.scrollFactor = new FlxPoint(0, 0);
			grpHud.add(bg);
						
			grpHud.add(grpText = new FlxGroup);
			grpHud.add(grpItems = new FlxGroup);
			attributeValues = new Array(0,0,0,0,0,0,0,0,0,0,0,0);
		}
		
		public override function update(): void
		{
			grpItems.clear();
			grpText.clear();
			
			attributeValues = new Array(0,0,0,0,0,0,0,0,0,0,0,0);
			var i:Number = 0;
			var attribute:Attribute;
			for each (attribute in player.attributes)
			{
				attributeValues[attribute.getType()] += (attribute.ISDEBUFF ? -1 : 1);
			}

			var itr:Number = 0;
			for (itr = 0; itr <= Attribute.LAST; itr++)
			{
				if (attributeValues[itr] != 0)
				{
					var itemIcon:Item = new Item(16 + i * 32, 16);
					itemIcon.updateImage(itr);
					itemIcon.scrollFactor = new FlxPoint(0, 0);
					grpItems.add(itemIcon);
					var itemText:FlxText = new FlxText(16 + 16 + i * 32, 16, 32);
					var attCount:Number = attributeValues[itr];
					itemText.text = attCount.toString();
					itemText.size = 8;
					itemText.color = 0xffffffff;
					itemText.scrollFactor = new FlxPoint(0, 0);
					grpText.add(itemText);
					++i;
				}
			}
		}
		
	}

}