bestMap = ->
	scope = mapModel: '='
	
	map = {}
	
	isNewMarkerNotSet = true
	isAddPosible = false
	longLatt = []

	colorSettings =
		min:
			R: 94
			G: 174
			B: 158
		max:
			R: 220
			G: 237
			B: 234

	getColor = (likes) -> 
		multiplier = 1 - likes / colorSettings.maxLikes
		max = colorSettings.max
		min = colorSettings.min
		rgbToHex( Math.round( multiplier * (max.R - min.R) + min.R), Math.round( multiplier * (max.G - min.G) + min.G), Math.round( multiplier * (max.B - min.B) + min.B))

	componentToHex = (c) ->
		hex = c.toString 16 
		hex.length == 1 ? "0" + hex : hex


	rgbToHex = (r, g, b) ->
		"#" + ((1 << 24) + (r << 16) + (g << 8) + b).toString(16).slice(1);

	toObject = (arr) ->
		rv = {}
		for i in [0...arr.length]
			rv[i] = arr[i];
		rv;
	
	onMapClick = (e) ->
		if isAddPosible and isNewMarkerNotSet
			console.log e.latlng
			lattLong = [e.latlng.lat, e.latlng.lng]
			console.log lattLong
			isNewMarkerNotSet = false
			L.marker( e.latlng,
				draggable:true
				icon: L.divIcon
					className: 'count-icon'
					iconSize: [40, 40]
				).on('dragend', (event) ->
						lattLong = [event.target._latlng.lat, event.target._latlng.lng]
						console.log('dragend', lattLong)
					).addTo(map)

		#if !isNewMarkerNotSet



	initMap = (element, maxLikes, markers) ->
		console.log 'initMap'

		for i in [0...2]
			console.log getColor(markers[i].likes_count)
			L.marker(markers[i].long_latt, 
				icon: L.divIcon
					className: 'count-icon',
					html: markers[i].likes_count,
					iconSize: [40, 40]
				).bindPopup(L.popup()
						.setContent(markers[i].description)
						).addTo(map)
		map.on('click', onMapClick)
		#L.marker([-37.7772, 175.2606]).bindLabel('Look revealing label!').addTo(map);

	configureMap = () =>
		console.log 'configureMap'

	link: (scope, element, attrs) ->
		markers = scope.mapModel

		console.log attrs.id
		maxLikes = 1000
		map = L.map attrs.id 
			.setView [ 50.438265372826606, 30.517272949218754], 6

		L.Icon.Default.imagePath = 'images'

		initialMapSettings =
			maxZoom: 18
			attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
						'<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
						'Imagery © <a href="http://mapbox.com">Mapbox</a>'
			id: 'thymajesty.kbp9jbaa'

		L.tileLayer 'https://{s}.tiles.mapbox.com/v3/thymajesty.kbp9jbaa/{z}/{x}/{y}.png', configureMap
		.addTo(map)
		markers = for i in [0...2]
					{likes_count: i*100, long_latt: [50.438265372826606, 30.517272949218754], description:'description: Lorem ipsum Sed tempor Ut minim fugiat ea sed quis ad eiusmod sed proident non Duis'}
		
		markers.isAddPosible = true

		isAddPosible = markers.isAddPosible
		configureMap
		initMap attrs, maxLikes, markers
		console.log 'directive bestMap'
		


angular.module 'best.directives'
	.directive 'bestMap', bestMap