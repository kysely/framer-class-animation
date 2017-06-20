# VERSION 1.0.1
# HELPER METHODS AND FUNCTIONS ——————————————————————————
String::toCamel = () ->
	@replace( /([-_][a-z])/g, ($1) -> return $1.toUpperCase().replace(/[-_]/,'') )

String::toCss = () ->
	@replace( /([A-Z])/g, ($1) -> return "-"+$1.toLowerCase() );

point = (cl) -> if cl.indexOf(".") is 0 then cl else ".#{cl}"

getHex = (c) ->
	hexa = c.toString(16)
	return if hexa.length is 1 then "0#{hexa}" else hexa

rgb = ([r,g,b] = color) -> "##{getHex(r)}#{getHex(g)}#{getHex(b)}";

String::checkColor = () ->
	if @indexOf("rgb") != 0
		return @
	else
		color = [r,g,b] = @split("(")[1].split(",")
		return rgb( (parseInt(value) for value in color) )


renameKey = (obj, oldName, newName) ->
	if oldName is newName
		return obj

	if obj.hasOwnProperty oldName
		obj[newName] = obj[oldName]
		delete obj[oldName]

	return obj


# INCLUDE VELOCITY.JS LIBRARY ———————————————————————————
insertVelocity = (script, webscript, name) ->
	try
		Utils.domLoadScriptSync(script)
		Utils.domComplete ->
			console.log "%c#{script} Successfully Included", "background: #DDFFE3; color: #007814"
	catch e
		console.log "%cCouldn't load '#{script}' locally. Will try downloading from web.", "background: #FFF0DB; color: #D27B00"
		try
			Utils.domLoadScriptSync(webscript)
			Utils.domComplete ->
				console.log "%c#{name} Successfully Included from Web", "background: #DDFFE3; color: #007814"
		catch e
			throw Error("ClassAnimation: Sorry, I don't know how to animate without #{name} library")


insertVelocity("modules/velocity.min.js", "//cdn.jsdelivr.net/velocity/1.4/velocity.min.js", "Velocity.js")
#insertVelocity("modules/velocity.ui.min.js", "//cdn.jsdelivr.net/velocity/1.4/velocity.ui.min.js", "Velocity UI")



# OBJECT WITH PROPERTIES AND THEIR OPTIONS ——————————————
# [UNITLESS, ANIMATABLE, SVG]
ANIMATABLES =
	fontWeight: [true, false]
	fontFamily: [true, false]
	textAlign: [false, false]
	opacity: [true, true, true]
	zIndex: [true, false]

	width: [false, true, true]
	height: [false, true, true]
	minWidth: [false, true]
	minHeight: [false, true]
	maxWidth: [false, true]
	maxHeight: [false, true]

	"\n— POSITIONING —": [false, true]
	padding: [false, true]
	paddingTop: [false, true]
	paddingRight: [false, true]
	paddingBottom: [false, true]
	paddingLeft: [false, true]

	top: [false, true]
	right: [false, true]
	bottom: [false, true]
	left: [false, true]

	margin: [false, true]
	marginTop: [false, true]
	marginRight: [false, true]
	marginBottom: [false, true]
	marginLeft: [false, true]

	"\n— BORDER DIMENSIONS —": [false, true]
	borderWidth: [false, true]
	borderTopWidth: [false, true]
	borderRightWidth: [false, true]
	borderBottomWidth: [false, true]
	borderLeftWidth: [false, true]
	borderRadius: [false, true]
	outlineWidth: [false, true]

	"\n— TEXT PROPERTIES —": [false, true]
	lineHeight: [false, true]
	fontSize: [false, true, true]
	letterSpacing: [false, true, true]
	wordSpacing: [false, true, true]

	"\n— TEXT COLORS —": [false, true]
	color: [false, true]
	colorRed: [true, true]
	colorGreen: [true, true]
	colorBlue: [true, true]
	colorAlpha: [true, true]

	"\n— BACKGROUND COLORS —": [false, true]
	backgroundColor: [false, true]
	backgroundColorRed: [true, true]
	backgroundColorGreen: [true, true]
	backgroundColorBlue: [true, true]
	backgroundColorAlpha: [true, true]

	"\n— BORDER COLORS —": [false, true]
	borderColor: [false, true]
	borderTopColor: [false, true]
	borderRightColor: [false, true]
	borderBottomColor: [false, true]
	borderLeftColor: [false, true]

	"\n— RED CHANNEL OF BORDERS —": [false, true]
	borderColorRed: [true, true]
	borderTopColorRed: [true, true]
	borderRightColorRed: [true, true]
	borderBottomColorRed: [true, true]
	borderLeftColorRed: [true, true]

	"\nGREEN:": [false, true]
	borderColorGreen: [true, true]
	borderTopColorGreen: [true, true]
	borderRightColorGreen: [true, true]
	borderBottomColorGreen: [true, true]
	borderLeftColorGreen: [true, true]

	"\nBLUE:": [false, true]
	borderColorBlue: [true, true]
	borderTopColorBlue: [true, true]
	borderRightColorBlue: [true, true]
	borderBottomColorBlue: [true, true]
	borderLeftColorBlue: [true, true]

	"\nALPHA:": [false, true]
	borderColorAlpha: [true, true]
	borderTopColorAlpha: [true, true]
	borderRightColorAlpha: [true, true]
	borderBottomColorAlpha: [true, true]
	borderLeftColorAlpha: [true, true]

	"\n— OUTLINE COLOR —": [false, true]
	outlineColor: [false, true]
	outlineColorRed: [true, true]
	outlineColorGreen: [true, true]
	outlineColorBlue: [true, true]
	outlineColorAlpha: [true, true]

	"\n— ADVANCED STYLES —": [false, true]
	backgroundPositionX: [false, true]
	backgroundPositionY: [false, true]
	textShadowX: [false, true]
	textShadowY: [false, true]
	textShadowBlur: [false, true]
	boxShadowX: [false, true]
	boxShadowY: [false, true]
	boxShadowBlur: [false, true]
	boxShadowSpread: [false, true]

	"\n— TRANSFORMATIONS —": [false, true]
	translateX: [false, true, true]
	translateY: [false, true, true]
	translateZ: [false, true, true]

	scale: [true, true, true]
	scaleX: [true, true, true]
	scaleY: [true, true, true]
	scaleZ: [true, true]

	rotateX: [true, true, true]
	rotateY: [true, true, true]
	rotateZ: [true, true, true]

	skewX: [true, true, true]
	skewZ: [true, true, true]

	transformPerspective: [false, true, true]
	perspective: [false, true]
	perspectiveOriginX: [false, true]
	perspectiveOriginY: [false, true]
	transformOriginX: [false, true, true]
	transformOriginY: [false, true, true]
	transformOriginZ: [false, true, true]

	clipTop: [false, true]
	clipRight: [false, true]
	clipBottom: [false, true]
	clipLeft: [false, true]

	blur: [false, true]

	"\n— SVG-only —": [false, true]
	x: [false, true]
	y: [false, true]
	cx: [false, true]
	cy: [false, true]
	r: [false, true]
	rx: [false, true]
	ry: [false, true]
	x1: [false, true]
	x2: [false, true]
	y1: [false, true]
	y2: [false, true]

	strokeDasharray: [false, true]
	strokeDashoffset: [false, true]
	strokeWidth: [false, true]
	strokeMiterlimit: [true, true]
	startOffset: [false, true]

	fill: [false, true]
	fillRed: [true, true]
	fillGreen: [true, true]
	fillBlue: [true, true]
	fillAlpha: [true, true]
	fillOpacity: [true, true]

	stroke: [false, true]
	strokeRed: [true, true]
	strokeGreen: [true, true]
	strokeBlue: [true, true]
	strokeAlpha: [true, true]
	strokeOpacity: [true, true]

	stopColor: [false, true]
	stopColorRed: [true, true]
	stopColorGreen: [true, true]
	stopColorBlue: [true, true]
	stopColorAlpha: [true, true]
	stopOpacity: [true, true]

	offset: [false, true]

isAnimatable = (property, thr) ->
	if typeof ANIMATABLES[property] is 'object' && ANIMATABLES[property][1]
		return true
	else
		moduleHelp() if thr
		print "›#{property}‹ is not animatable. Open console (Target icon bottom left) and Cmd+R to see animatable properties." if thr
		return false



# GET CSS DECLARATIONS FROM CLASS ———————————————————————
getCSS = (cl, checker) ->
	classes = document.getElementsByClassName(cl);
	cssDOM = window.getComputedStyle(classes[0], null)

	cssObject = {}

	for val in [0...cssDOM.length]
		currentVal = cssDOM[val]
		if currentVal.toCamel() of checker
			cssObject[currentVal.toCamel()] = cssDOM.getPropertyValue(currentVal)
			cssObject[currentVal.toCamel()] = cssDOM.getPropertyValue(currentVal).checkColor() if typeof cssDOM.getPropertyValue(currentVal) is "string"

	return cssObject


# MAIN CSSANIMATION CLASS ———————————————————————————————
# ———————————————————————————————————————————————————————
# ———————————————————————————————————————————————————————
class exports.ClassAnimation
	constructor: (name, end = {}, init, options = {}, optionsFactor = 1000) ->
		@class = name
		@target = document.querySelectorAll(".#{@class}");

		@endState = end

		@options = @endState.options || options
		@options.time = @options.time*optionsFactor || 1000
		@options.delay = @options.delay*optionsFactor || 0
		@options.repeat = @options.repeat || false
		@options.curve = @options.curve || "ease-in-out"

		delete @endState.options

		for key, val of @endState
			@endState[key] = val.checkColor() if typeof val is "string"
			renameKey(@endState, key, key.toCamel())
			isAnimatable(key.toCamel(), true)

		@initState = init || getCSS(@class, @endState)

		return @


	# METHODS ———————————————————————————————————————————

	start: () ->
		_this = @
		Utils.domComplete ->
			Velocity	_this.target,
						_this.endState,
							duration: _this.options.time
							delay: _this.options.delay
							loop: _this.options.repeat
							easing: _this.options.curve
							begin: -> _this.onStart?()
							complete: -> _this.onEnd?()
							progress: (elements, complete, remaining, start) ->
								_this.onAnim?(complete, remaining)
		@notFirst = true
		return @

	stop: () ->
		@onStop?()
		Velocity(@target, "stop")
		return @

	reset: () ->
		Velocity	@target,
					@initState,
						duration: 0
						delay: 0
		return @

	restart: () ->
		@reset()
		@start()
		return @

	finish: () ->
		Velocity(@target, "finish")
		return @

	toggle: () ->
		_this = @
		if @notFirst
			Velocity	@target,
						"reverse",
						begin: -> _this.onStart?()
						complete: -> _this.onEnd?()
						progress: (elements, complete, remaining, start) ->
							_this.onAnim?(complete, remaining)
		else
			@start()
		return @

	reverse: () ->
		return new ClassAnimation(@class, @initState, @endState, @options, 1)

	fadeIn: () ->
		_this = @
		Velocity	@target,
					"fadeIn",
						begin: -> _this.onStart?()
						complete: -> _this.onEnd?()
						progress: (elements, complete, remaining, start) ->
							_this.onAnim?(complete, remaining)
		return @

	fadeOut: () ->
		_this = @
		Velocity	@target,
					"fadeOut",
						begin: -> _this.onStart?()
						complete: -> _this.onEnd?()
						progress: (elements, complete, remaining, start) ->
							_this.onAnim?(complete, remaining)
		return @

	help: () -> moduleHelp()


	# METHOD ALIASES ————————————————————————————————————

	switch: -> 			@toggle()
	stateSwitch: -> 	@toggle()
	revert: -> 			@reverse()
	inverse: -> 		@reverse()
	invert: -> 			@reverse()


	# EVENTS ————————————————————————————————————————————

	Events.Animation = "move"

	on: (eventName, cb) ->
		switch eventName
			when "end" 			then @onAnimationEnd(cb)
			when "stop" 		then @onAnimationStop(cb)
			when "start" 		then @onAnimationStart(cb)
			when "move" 		then @onAnimation(cb)
			else 				throw Error("Sorry, I'm too stupid to handle this event")

	onAnimationEnd: (cb) ->		@onEnd = @eventReturnData(cb)
	onAnimationStop: (cb) -> 	@onStop = @eventReturnData(cb)
	onAnimationStart: (cb) -> 	@onStart = @eventReturnData(cb)
	onAnimation: (cb) -> 		@onAnim = @eventReturnData(cb)

	eventReturnData: (cb) ->
		return (prog, rem) -> cb.call?(@, prog, rem)



# .ANIMATE METHOD ———————————————————————————————————————
String::animate = (props) ->
	(new exports.ClassAnimation @, props).start()

String::fadeIn = () -> @animate().fadeIn()

String::fadeOut = () -> @animate().fadeOut()



# STYLE INIT ————————————————————————————————————————————
String::css = () ->
	Utils.insertCSS(@)

addUnit = (value, key) ->
	if typeof value is 'number' && isAnimatable(key, false) && !ANIMATABLES[key][0] then "#{value}px" else value

exports.Style = (cl, css) ->
	insertableCss = "#{point(cl)} {border-style: solid; border-width: 0; "
	for key, val of css
		css[key] = addUnit( css[key], key.toCamel() )
		insertableCss += "#{key.toCss()}:#{css[key]}; "
	insertableCss += "}"

	Utils.insertCSS(insertableCss)

	return cl

exports.style = (cl, css) -> exports.Style(cl, css)



# HELP ——————————————————————————————————————————————————
moduleHelp = () ->
	console.log "\n"
	console.log "LIST OF ANIMATABLE PROPERTIES"
	for key, val of ANIMATABLES
		help = if ANIMATABLES[key][0] is true then "%c#{key} %cis unitless" else "%c#{key} %c"
		help += if ANIMATABLES[key][2] is true then " %c(works for SVG)" else " %c"
		console.log help, "color: #007AFF", "color: #000", "color: #007814" if ANIMATABLES[key][1] is true
	console.log "For full support, go to http://velocityjs.org/#cssSupport"
