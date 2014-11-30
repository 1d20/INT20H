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
