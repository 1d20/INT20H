mapInput = () ->
	scope:
		'onMapClicked': '&'

	link: (scope, element, attrs) ->
		isNewMarkerNotSet = true
		console.log 'mapInput'
		map = L.map "#{attrs.id}"
			.setView [ 50.438265372826606, 30.517272949218754], 6
		console.log 'map', map
		L.Icon.Default.imagePath = 'images'

		initialMapSettings =
			maxZoom: 18
			attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
						'<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
						'Imagery © <a href="http://mapbox.com">Mapbox</a>'
			id: 'thymajesty.kbp9jbaa'

		L.tileLayer 'https://{s}.tiles.mapbox.com/v3/{id}/{z}/{x}/{y}.png',
			initialMapSettings
		.addTo map

		map.on 'click', (e) ->
			console.log(e.latlng)
			if isNewMarkerNotSet
				console.log('clicked', e.latlng)
				isNewMarkerNotSet = false

				scope.onMapClicked data: e.latlng
				L.marker( e.latlng,
					draggable:true
					icon: L.divIcon
						className: 'count-icon'
						iconSize: [40, 40]
					).on('dragend', (event) ->
							scope.onMapClicked data: event.target._latlng
							console.log('dragend', event.target._latlng)
						).addTo(map)




angular.module 'best.directives'
	.directive 'mapInput', mapInput