bestMap = ->
	scope = mapModel: '='
	
	map = {}
	longLatt = []

	initMap = (element, maxLikes, markers) ->
		console.log 'initMap'
		
		map.locate
			setView : true	


		map.on 'lacationfound', (e) ->
			console.log e
			radius = e.accuracy / 2;
			L.marker(e.latlng).addTo(map)
				.bindPopup("You are within " + radius + " meters from this point").openPopup()
			L.circle(e.latlng, radius).addTo(map)
			return

		for i in [0...2]
			L.marker(markers[i].long_latt, 
				icon: L.divIcon
					className: 'count-icon',
					html: markers[i].likes_count,
					iconSize: [40, 40]
				).bindPopup(L.popup()
						.setContent(markers[i].description)
						).addTo(map)
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

		configureMap
		initMap attrs, maxLikes, markers
		console.log 'directive bestMap'
		


angular.module 'best.directives'
	.directive 'bestMap', bestMap