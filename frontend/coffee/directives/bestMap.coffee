bestMap = ->
	scope = markers: '='
	
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

	onEachFeature = (feature, layer) =>
			popupContent = '<p style="color:black">'
			console.log feature.properties.popupContent
			if feature.properties && feature.properties.popupContent
				popupContent += feature.properties.popupContent
			popupContent += '</p>'
			#console.log popupContent
			console.log layer
			layer.bindPopup(popupContent)
			##main-map(best-map, markers='main.markers', style="height: 600px;")

	initMap = (element, maxLikes, markers) ->

		console.log element.id, maxLikes, markers

		colorSettings.maxLikes = maxLikes

		map = L.map element.id
		.setView [ 49, 32], 8

		initialMapSettings =
			maxZoom: 18
			attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
						'<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
						'Imagery © <a href="http://mapbox.com">Mapbox</a>'
			id: 'thymajesty.kbp9jbaa'

		L.tileLayer 'https://{s}.tiles.mapbox.com/v3/thymajesty.kbp9jbaa/{z}/{x}/{y}.png', initialMapSettings
		.addTo(map)
		L.Icon.Default.imagePath = 'images'
		#likes_count
		#[lat, long]
		#description
		###"marker-symbol": "embassy"###
		geojsonFeaturesArray = for i in [0...2]
			type: "Feature"
			properties:
				"description": markers[i].description + ': ' + i
				"marker-color": getColor(markers[i].likes_count)
				"marker-size": "medium"
				q:''
				
			geometry:
				"type": "Point"
				"coordinates": 
						[markers[i].long_latt[0]+ i, markers[i].long_latt[1]+ i]
		geojsonFeatures = 
			features: geojsonFeaturesArray
			id: "thymajesty.kbp9jbaa"
			type: "FeatureCollection"


		console.log 'lol', JSON.stringify geojsonFeatures 
		L.geoJson(geojsonFeaturesArray,
				onEachFeature: onEachFeature
			).addTo(map)

	link: (scope, element, attrs) ->
		markers = scope.markers
		console.log attrs.id
		maxLikes = 1000

		markers = for i in [566...586] by 10
					{likes_count: i, long_latt: [32, 49], description:'ololo likes'}

		console.log markers[0].long_latt
		initMap attrs, maxLikes, markers
		console.log 'directive bestMap'
		


angular.module 'best.directives'
	.directive 'bestMap', bestMap