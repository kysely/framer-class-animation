{ClassAnimation} = require "ClassAnimation"
{Style} = require "ClassAnimation"

# DEMO SETUP

# Import Varela Round from Google Fonts
"@import url('https://fonts.googleapis.com/css?family=Varela+Round'); body {font-family: 'Varela Round', 'Varela', sans-serif}".css()

Screen.backgroundColor = "#00003C"
Canvas.backgroundColor = "#000000"

texts = new Layer
	width: Screen.width
	height: 280
	y: 260
	backgroundColor: null

stars = new Layer
	x: Screen.width/2 - 326 - 20
	y: 30
	width: 652
	height: 290
	backgroundColor: null

delivery = new Layer
	x: 0, y: 720
	width: 750
	height: 346
	backgroundColor: null



# STYLES ——————————————————————————————————————
# —————————————————————————————————————————————
# —————————————————————————————————————————————

# First, hide all elements in ›second‹ class
Style "second", 
	display: "none"

# Set styles for our headlines
Style "headline",
	fontSize: 88
	lineHeight: 100
	color: "#D3D3FF"
	fontWeight: 400
	textAlign: "center"

Style "status",
	fontSize: 24
	lineHeight: 60
	letterSpacing: 11
	fontWeight: 400
	color: "#5856D6"
	textTransform: "uppercase"
	textAlign: "center"



# LAYERS' CONTENTS ————————————————————————————
# —————————————————————————————————————————————
# —————————————————————————————————————————————

texts.html = 	"""
				<h2 class='status first'>Pssst!</h2>
				<h1 class='headline first'>Shipping<br>Dreams</h1>
				
				<h2 class='status second'>Yasss!</h2>
				<h1 class='headline second'>Dreams<br>on the way</h1>
				"""


# Import SVGs from files for cleaner code —————
# Individual objects (paths) in Sketch-generated SVGs
# will have ›id‹ attribute equal to the layer name
# in Sketch. You simply need to rewrite them from ›id‹ 
# to ›class‹ to make them work with the module

stars.html = Utils.domLoadDataSync("images/stars.svg")
delivery.html =	Utils.domLoadDataSync("images/delivery.svg")



# ANIMATIONS SETUP ————————————————————————————
# —————————————————————————————————————————————
# —————————————————————————————————————————————

# Since both wheel objects in SVG belong to one
# ›wheel‹ class, we can animate both with one animation
toWheel = new ClassAnimation "wheel",
	rotateZ: 360
	options:
		curve: "linear"
		repeat: true

# Add some bouncing effect for Dream Delivery truck
truckRumble = new ClassAnimation "truckBody",
	translateY: 5
	rotateZ: 0.2
	options:
		time: 0.3
		repeat: true

# Show off some driving skills
driveSlightly = new ClassAnimation "movingElements",
	translateX: 180
	options:
		time: 5
		curve: [0,0,.58,1] # Bezier Curve

# This will move truck out of screen
driveAway = new ClassAnimation "movingElements",
	translateX: 800
	options:
		time: 0.7

# Let's animate the stars... cause we can
starsGroupOne = new ClassAnimation "stars1",
	scale: 0.97
	rotateZ: -1
	fill: "#2E2C87"
	options:
		time: 2
		repeat: true

starsGroupTwo = new ClassAnimation "stars2",
	scale: 1.02
	rotateZ: 1
	options:
		time: 2
		repeat: true

# Add unnecessary pulsing effect to ›first‹ headers
pulseHead = new ClassAnimation "first",
	opacity: 0.5
	options:
		time: 0.5
		repeat: true



# START THE ANIMATIONS ————————————————————————
# —————————————————————————————————————————————
# —————————————————————————————————————————————

starsGroupOne.start()
starsGroupTwo.start()

pulseHead.start()

truckRumble.start()
toWheel.start()

driveSlightly.start()


# When ›driveSlightly‹ ends, lets ›driveAway‹
# and show the elements in ›second‹ class

driveSlightly.on Events.AnimationEnd, ->
	driveAway.start()
	pulseHead.fadeOut()
	
	pulseHead.onAnimationEnd ->
		"second".fadeIn()

