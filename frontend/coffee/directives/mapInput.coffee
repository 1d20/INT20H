mapInput = () ->
	scope:
		'onMapClicked': '&'
	link: (scope, element, attrs) ->
		isNewMarkerNotSet = true
		console.log 'mapInput'
		map = L.map "#{attrs.id}"
			.setView [50.438265372826606, 30.517272949218754]

		L.Icon.Default.imagePath = 'images'

		initialMapSettings =
			maxZoom: 18
			attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
						'<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
						'Imagery © <a href="http://mapbox.com">Mapbox</a>'
			id: 'thymajesty.kbp9jbaa'

		L.tileLayer 'https://a.tiles.mapbox.com/v3/{id}/{z}/{x}/{y}.png',
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
		map.locate
			setView : true	


		map.on 'lacationfound', (e) ->
			console.log e
			radius = e.accuracy / 2;
			L.marker e.latlng
				.addTo(map)
				.bindPopup("You are within " + radius + " meters from this point").openPopup()
			L.circle(e.latlng, radius).addTo(map)
			return
		




angular.module 'best.directives'
	.directive 'mapInput', mapInput