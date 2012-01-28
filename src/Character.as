package  
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxGroup;
	import org.flixel.FlxG;
	import attributes.Attribute;
	/**
	 * ...
	 * @author Jason Hamilton
	 */
	public class Character extends FlxSprite
	{
		// Array of special attributes that modify stats
		public var attributes:Array;
		
		public static const FRAME_WIDTH:int = 0;
		public static const FRAME_HEIGHT:int = 0;
		protected var bulletGroup:FlxGroup;
		
		// ATTRIBUTE MODIFIABLE VARIABLES
		public var SPEED:Number;
		public var ATK:Number;
		public var DEF:Number;
		public var REGEN:Number;
		
		public var WEAPON_PISTOL:Number;
		public var WEAPON_SIDE:Number;
		public var WEAPON_REAR:Number;
				
		// WEAPONS
		protected var wpnPistol:Weapon;
		protected var wpnSide:Weapon;
		protected var wpnRear:Weapon;
		protected var weapons:FlxGroup;

		
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
			weapons = new FlxGroup();
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
		
		public function dropItem():void
		{
			var item:Item = new Item(x, y);
			transferAttributes(item);
			item.updateImage();
			PlayState.addToGroup(item, PlayState.items);
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
			// Getting weird compile errors if I don't cast to Array.
			// It'll do for now.
			(attributes as Array).push(attribute);
			attribute.onAdd(this);
		}
		
		/**
		 * Remove an attribute, and do whatever it does on removing
		 * 
		 * @param	attribute
		 */
		public function removeAttribute(attribute:Attribute):void
		{
			// Getting weird compile errors if I don't cast to Array.
			// It'll do for now.
			(attributes as Array).splice((attributes as Array).indexOf(attribute), 1);
			attribute.onRemove(this);
		}
		
		public function updateWeapon(attributeType:Number, value:Number): void
		{
			if (attributeType == Attribute.ATT_PISTOL && value > 0)
			{
				var newPistol:Weapon = new Weapon(this, bulletGroup, 1, 200 + 50 * WEAPON_PISTOL, 200 + 50 * WEAPON_PISTOL, 50);
				if (wpnPistol)
				{
					weapons.remove(wpnPistol)
				}
				weapons.add(newPistol);
				wpnPistol = newPistol;
			}
			else if (attributeType == Attribute.ATT_SIDE && value > 0)
			{
				var newSide:Weapon = new Weapon(this, bulletGroup, 2, 100 + 25 * WEAPON_SIDE, 100 + 25 * WEAPON_SIDE, 50);
				if (wpnSide)
				{
					weapons.remove(wpnSide);
				}
				weapons.add(newSide);
				wpnSide = newSide;
			}			
			else if (attributeType == Attribute.ATT_REAR && value > 0)
			{
				var newRear:Weapon = new Weapon(this, bulletGroup, 3, 100 + 25 * WEAPON_REAR, 100 + 25 * WEAPON_REAR, 50);
				if (wpnRear)
				{
					weapons.remove(wpnRear);
				}
				weapons.add(newRear);
				wpnRear = newRear;
			}
			
		}
	}

}