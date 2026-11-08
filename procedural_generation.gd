extends Node

class generate:
	var random = RandomNumberGenerator.new()
	
	func rand_bool():
		'''80% chance of outputting true'''
		var x = random.randi_range(0,9)
		return false if x==0 else true

class planetAttributes extends generate:
	'''generates the planets qualities'''
	var aliens = rand_bool() #are there aliens
	var aliens_friendly = rand_bool()#are the aliens friendly
	var air = rand_bool()#is the air breathable
	var temp = generate_temp()#what is the temperature
	var magnet = random.randi_range(0,3)#is there a magnetic field (0 = no, 1-3 = directions)
	
	func generate_temp():
		'''chooses a temperature between -100 and 100c, weighted
		towards temperatures in the -10 to 40c range'''
		if rand_bool():
			return random.randf_range(-10,40)
		else:
			return random.randf_range(-100,100)

class colonyExpectations extends generate:
	'''generates the colonies expectations'''
	var lower_temp = random.randi_range(-10,20)
	var upper_temp = lower_temp + 20#expected temperature range
	var aliens = rand_bool()#are they ok with (friendly) aliens

func generate_planet():
	'''checks whether planet is habitable according to the colonies preferences,
	returns all data as a list'''
	var this_planet = planetAttributes.new()
	var colony_expectations = colonyExpectations.new()
	var is_habitable
	
	if (not this_planet.aliens or colony_expectations.aliens and this_planet.aliens_friendly)\
	and this_planet.air\
	and colony_expectations.lower_temp <= this_planet.temp\
	and this_planet.temp <= colony_expectations.upper_temp\
	and this_planet.magnet != 0:
		is_habitable = true
	else:
		is_habitable = false
	print(is_habitable)
	return [this_planet, colony_expectations, is_habitable]

func _ready() -> void:
	generate_planet()
