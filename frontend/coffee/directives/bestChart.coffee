bestChart = () ->
	scope:
		data: '=bestData'
		loadend: '=bestPromise'
	link: (scope, element, attrs) ->

		scope.$on 'nodes.loadend', (e, data) ->
			columns = data
				.filter (i) -> !!i.likes
				.map (i) -> [i.name, i.likes]

			chart = c3.generate
			    data:
			        columns: columns
			        type : 'donut'
			        # onclick: function (d, i) { console.log("onclick", d, i); }
			        # onmouseover: function (d, i) { console.log("onmouseover", d, i); }
			        # onmouseout: function (d, i) { console.log("onmouseout", d, i); }
			    donut:
			        title: ""
			
angular.module 'best.directives'
	.directive 'bestChart', bestChart