package  
{
	import org.flixel.FlxSprite;
	import attributes.Attribute;
	
	/**
	 * ...
	 * @author Doug Macdonald
	 */
	public class Item extends Character
	{
		[Embed(source = '../data/item_pistol.png')] private var ImgItemPistol:Class;
		[Embed(source = '../data/item_side.png')] private var ImgItemSide:Class;
		[Embed(source = '../data/item_rear.png')] private var ImgItemRear:Class;
		[Embed(source = '../data/item_atk.png')] private var ImgItemATK:Class;
		[Embed(source = '../data/item_def.png')] private var ImgItemDEF:Class;
		[Embed(source = '../data/item_spd.png')] private var ImgItemSPD:Class;
		[Embed(source = '../data/item_regen.png')] private var ImgItemRegen:Class;
		
		public function Item(x:Number, y:Number) 
		{
			super(x, y);
		}
		
		public function updateImage(): void
		{
			// Only called after an item's attributes change (probably only immediately after creation)
			var attribute:Attribute;
			for each (attribute in attributes)
			{
				if (attribute.getType() == attribute.ATT_ATK)
				{
					loadGraphic(ImgItemATK);
				}
				else if (attribute.getType() == attribute.ATT_SPD)
				{
					loadGraphic(ImgItemSPD);
				}
			}
		}
	}

}