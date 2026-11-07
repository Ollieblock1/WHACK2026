extends Control

func setText(object):
	$Temperature.text = "Temperature: around " + object.lower_temp + 10
	$Aliens.text =  "Aliens: " + ("yes - Docile" if object.aliens == true else "no")
	
