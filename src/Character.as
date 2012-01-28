package  
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import attributes.Attribute;
	/**
	 * ...
	 * @author Jason Hamilton
	 */
	public class Character extends FlxSprite
	{
		// Array of special attributes that modify stats
		public var attributes:Array;
		
		// ATTRIBUTE MODIFIABLE VARIABLES
		public var SPEED:Number;
		public var ATK:Number;
		public var DEF:Number;
		
		
		/**
		 * Constructor
		 * 
		 * @param	x
		 * @param	y
		 */
		public function Character(x:Number, y:Number):void
		{
			super(x, y);
			attributes = new Array();
		}
		
		/**
		 * Give attributes to another character
		 * 
		 * @param	character
		 */
		public function transferAttributes(character:Character):void
		{
			var attribute:Attribute;
			for each (attribute in attributes)
			{
				character.addAttribute(attribute);
				removeAttribute(attribute);
			}
		}
		
		/**
		 * Transfer attributes to the player character.
		 */
		public function transferAttributesToPlayer():void
		{
			transferAttributes(PlayState.getPlayer());
		}
		
		/**
		 * Copy attributes from another character.
		 * Currently uses the same instances, not copies,
		 * under the assumption that Attributes don't have
		 * any internal state that varies per character.
		 * 
		 * @param	character
		 */
		public function copyAttributes(character:Character):void
		{
			var attribute:Attribute;
			for each (attribute in character.attributes)
			{
				addAttribute(attribute);
			}
		}
		
		/**
		 * Copy the attributes of the player
		 */
		public function copyPlayerAttributes():void
		{
			copyAttributes(PlayState.getPlayer());
		}
		
		/**
		 * Clear all attributes
		 */
		public function clearAttributes():void
		{
			var attribute:Attribute;
			for each (attribute in attributes)
			{
				removeAttribute(attribute);
			}
		}
		
		/**
		 * Have the attributes do their thing on update
		 */
		override public function update():void
		{
			var attribute:Attribute;
			for each (attribute in attributes)
			{
				attribute.onUpdate(this);
			}
			super.update();
		}
		
		/**
		 * Get the position as a FlxPoint
		 */
		public function get position():FlxPoint
		{
			return new FlxPoint(x, y);
		}
		
		/**
		 * Add a new attribute, and do whatever it does on adding
		 * 
		 * @param	attribute
		 */
		public function addAttribute(attribute:Attribute):void
		{
			attribute.onAdd(this);
		}
		
		/**
		 * Remove an attribute, and do whatever it does on removing
		 * 
		 * @param	attribute
		 */
		public function removeAttribute(attribute:Attribute):void
		{
			attribute.onRemove(this);
		}
	}

}