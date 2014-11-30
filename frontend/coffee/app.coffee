httpHeadersCongig = ($httpProvider) ->
    $httpProvider.defaults.transformRequest = (data) ->
        if data == undefined then data else $.param data

    $httpProvider.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded; charset=UTF-8'
    $httpProvider.defaults.xsrfCookieName = 'csrftoken'
    $httpProvider.defaults.xsrfHeaderName = 'X-CSRFToken'

locationConfig = ($locationProvider) ->
    $locationProvider.html5Mode(true)

routerConfig = ($routeProvider) -> 
    $routeProvider
        .when '/',
            templateUrl: '/static/templates/home.html'
        .when '/types',
            templateUrl: '/static/templates/types/index.html'
        .when '/types/:typeId',
            templateUrl: '/static/templates/types/show.html',
        .when '/types/:typeId/create',
            templateUrl: '/static/templates/types/create.html'
        .otherwise
            redirectTo: '/'

customInterpolation = ($interpolateProvider) ->
    $interpolateProvider.startSymbol('//');
    $interpolateProvider.endSymbol('//');

angular.module 'best', [
    'ngRoute'
    'best.filters'
    'best.services'
    'best.directives'
    'best.controllers'
]
    .config ['$interpolateProvider', customInterpolation]
    .config ['$locationProvider', locationConfig]
    .config ['$routeProvider', routerConfig]
    .config ['$httpProvider', httpHeadersCongig]
