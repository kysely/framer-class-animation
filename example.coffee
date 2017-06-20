socialCard = new Layer

# Create a content in one layer's ›html‹ property
# with some classes
socialCard.html =
	"""
	<h2 class='className'>Paul Paulson</h2>
	<span class='differentClass'>Montessori Teacher</span>
	"""

# Create a new animation for "className" class
animationA = new ClassAnimation "className",
	color: "#ff00ff"
	fontSize: 60
	lineHeight: 70
	borderWidth: 5

# Start the animation
animationA.start()
