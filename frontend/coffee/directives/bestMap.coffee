bestMap = ->
	scope: nodes: '='
		
		#L.marker([-37.7772, 175.2606]).bindLabel('Look revealing label!').addTo(map);

	link: (scope, element, attrs) ->

		scope.$on 'nodes.loadend.forMap', (e, data) ->
			nodes = data
			console.log 'nodes',nodes
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

			L.tileLayer 'https://{s}.tiles.mapbox.com/v3/thymajesty.kbp9jbaa/{z}/{x}/{y}.png', initialMapSettings
				.addTo(map)

			map.locate
				setView : true
				maxZoom : 10

			map.on 'lacationfound', (e) ->
				console.log e
				radius = e.accuracy / 2;
				L.marker(e.latlng).addTo(map)
					.bindPopup("You are within " + radius + " meters from this point").openPopup()
				L.circle(e.latlng, radius).addTo(map)
				return

			for i in [0...nodes.length]
				if nodes[i].lat? and nodes[i].lng?
					L.marker [nodes[i].lat, nodes[i].lng],
						icon: L.divIcon
							className: 'count-icon',
							html: nodes[i].likes,
							iconSize: [40, 40]
					.bindPopup L.popup().setContent(nodes[i].name)
					.addTo(map)
			console.log 'directive bestMap'

		


angular.module 'best.directives'
	.directive 'bestMap', bestMap