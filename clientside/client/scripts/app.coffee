'use strict';

angular.module('app', [
    # Angular modules
    'ngRoute'
    'ngAnimate'

    # 3rd Party Modules
    'ui.bootstrap'
    'easypiechart'
    'mgo-angular-wizard'
    'textAngular'
    'angular-loading-bar'

    # Custom modules
    'app.ui.ctrls'
    'app.ui.directives'
    'app.ui.services'
    'app.controllers'
    'app.directives'
    'app.form.validation'
    'app.ui.form.ctrls'
    'app.ui.form.directives'
    'app.tables'
    'app.task'
    'app.localization'
    'app.chart.ctrls'
    'app.chart.directives'
])
    
.config([
    '$httpProvider',
    ($httpProvider) ->
        $httpProvider.defaults.useXDomain = true
        delete $httpProvider.defaults.headers.common['X-Requested-With']
])

.config([
    '$routeProvider'
    ($routeProvider) ->
        $routeProvider
            .when(
                '/'
                redirectTo: '/dashboard'
            )
            .when(
                '/dashboard'
                templateUrl: 'views/dashboard.html'
            )
    
            .when(
                '/404'
                templateUrl: 'views/pages/404.html'
            )
            .when(
                '/pages/500'
                templateUrl: 'views/pages/500.html'
            )

            .otherwise(
                redirectTo: '/404'
            )
])


