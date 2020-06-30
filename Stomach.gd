extends Label

class_name Stomach

var content: Array = [] #array of items to be broken down
var gas_volume: float = 0
var max_volume: float = 2000 #maximum stomach volume
var volume: float = 0 #current stomach volume
var breakdown_rate: float = 0.1 #rate of item breakdown into chyme
var empty_rate: float = 10 #cm^3/minute may be affected by liquid content and caloric density
var digestion_strength: float = 0.5 #maximum item toughness that can be brokendown
var chyme = Chyme.new()

func add_item(item: Item):
	volume += item.volume
	content.append(item)

