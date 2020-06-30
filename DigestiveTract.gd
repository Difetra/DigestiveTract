extends Control

var stomach = null
var intestine = null

func create_intestines(num_seg):
	pass
	


func digest() -> void:
	#Start breaking down stomach contents
	for i in stomach.content.size():
		var item = stomach.content[i]
		
		if item.toughness < stomach.digestion_strength:
			var breakdown_volume = stomach.volume - (stomach.volume*item.toughness) * item.integrity
			item.integrity = max(0, item.integrity - stomach.breakdown_rate)
			item.volume = item.volume - breakdown_volume
			
			#volume after converting broken down material to preset chyme density while retaining mass. Items less dense then water should shrink, while denser technically expand?
			var breakdown_chyme_volume = (item.density - stomach.chyme.density) * stomach.chyme.density
			var water_volume = breakdown_volume * item.fluid_content
			var solid_volume = breakdown_chyme_volume - water_volume
			stomach.Chyme.solid_volume = solid_volume
			stomach.Chyme.water_volume = water_volume
			stomach.Chyme.kcal = ((breakdown_volume / 100) * item.density) * item.caloric_density
			#remove the item after fully broken down
			if item.volume <= 0:
				stomach.content.remove(i)
				item.queue_free()
	#Start emptying Chyme from stomach to intestines
	#liquid/kcal + liquid volume
	var liquid_empty_rate = stomach.chyme.water_volume
	Chyme
# Called when the node enters the scene tree for the first time.
func _ready():
	stomach  = Stomach.new()
	intestine = Intestine.new()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
