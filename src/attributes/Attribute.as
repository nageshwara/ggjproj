package attributes
{
	/**
	 * ...
	 * @author Jason Hamilton
	 */
	public class Attribute 
	{
		public const ATT_ATK:Number 		= 0;
		public const ATT_DEF:Number 		= 1;
		public const ATT_SPD:Number 		= 2;
		public const ATT_REGEN:Number 		= 3;
		public const ATT_PISTOL:Number 		= 4;
		public const ATT_SIDE:Number 		= 5;
		public const ATT_REAR:Number	 	= 6;
		
		protected var attributeType:Number;
		
		public function Attribute() 
		{
			
		}
		
		public function onAdd(character:Character):void
		{
		}
		
		public function onRemove(character:Character):void
		{
		}
		
		public function onUpdate(character:Character):void
		{
		}
		
		public function getType():Number
		{
			return attributeType;
		}
	}

}