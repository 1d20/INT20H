mapInput = () ->
    scope:
        'mapModel': '='
        'onMapClicked': '&'
    link: (scope, element, attrs) ->
        map = L.map "#{attrs.id}"
            .setView [51.505, -0.09], 13

        L.tileLayer 'https://{s}.tiles.mapbox.com/v3/{id}/{z}/{x}/{y}.png',
            maxZoom: 18
            attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
                '<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
                'Imagery © <a href="http://mapbox.com">Mapbox</a>'
            id: 'examples.map-i875mjb7'
        .addTo map

        map.on 'click', (e) ->
            scope.onMapClicked data: e.latlng

        scope

angular.module 'best.directives'
    .directive 'mapInput', mapInput