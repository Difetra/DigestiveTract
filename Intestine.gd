extends Label

class_name Intestine

var capacity: float = 200 #maximum segment volume, may be exceeded causing pain and potentially rupture. 
var chyme: Chyme = Chyme.new() #digestive matter
var contents: Array = [] #item contents of segment
var gas_volume: float = 0
var input: Object = null #stomach or previous segment
var output: Object = null #intestine or anus?

func content_volume() -> float:
	var total_volume = 0
	for item in contents:
		total_volume += item.volume
	return total_volume

func volume() -> float:
	var chyme_volume = chyme.solid_volume + chyme.water_volume
	return chyme_volume + content_volume() + gas_volume

func add_item(item: Item):
	pass

#full_segs(optional) - number of previous segments found to be full
func input_chyme(solid: float, liquid: float, kcal: float, full_segs: int):
	#amount allowed over capacity based on preceding full segements
	full_segs = full_segs or 0
	var o_capacity = capacity + (full_segs * (capacity * 0.1))
	var chyme_volume = solid + liquid
	var excess =  (volume() + chyme_volume) - o_capacity
	if excess > o_capacity:
		chyme.solid_volume += solid
		chyme.water_volume += liquid
		chyme.kcal += kcal
	else:
		#push excess to next segment
		var within_capacity = chyme_volume - excess 
		var ratio = liquid/solid
		var solid_volume = within_capacity/ratio
		var liquid_volume = within_capacity - solid_volume
		
		chyme.solid_volume += solid_volume
		chyme.liquid_volume += liquid_volume
		chyme.kcal += kcal/(chyme_volume/within_capacity)
		if output:
			output.input_chyme(solid - solid_volume, liquid - liquid_volume, kcal/(chyme_volume/excess), full_segs + 1)
