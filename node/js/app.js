'use strict';

var FT = angular.module('FT', [
    'ngRoute',
    'FTControllers'
]);

FT.config(['$routeProvider', function ($routeProvider) {
    $routeProvider.
        when('/', {
            templateUrl: 'partials/admin/idle.html',
            controller: 'FTidle'
        }).
        when('/game/menu', {
            templateUrl: 'partials/game/menu.html',
            controller: 'FTgameMenu'
        }).
        when('/game/action/', {
            templateUrl: 'partials/game/action.html',
            controller: 'FTgameAction'
        }).
        when('/game/action/:difficulty', {
            templateUrl: 'partials/game/action.html',
            controller: 'FTgameAction'
        }).
        when('/game/result', {
            templateUrl: 'partials/game/result.html',
            controller: 'FTgameResult'
        }).
        when('/test/menu', {
            templateUrl: 'partials/test/menu.html',
            controller: 'FTtestMenu'
        }).
        when('/test/action/', {
            templateUrl: 'partials/test/action.html',
            controller: 'FTtestAction'
        }).
        when('/test/result', {
            templateUrl: 'partials/test/result.html',
            controller: 'FTtestResult'
        }).
        when('/config', {
            templateUrl: 'partials/admin/config.html',
            controller: 'FTconfig'
        }).
        otherwise({
            redirectTo: '/'
        });
}]);