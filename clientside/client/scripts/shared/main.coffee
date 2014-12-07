'use strict';

angular.module('app.controllers', [])

# overall control
.controller('AppCtrl', [
    '$scope', '$location'
    ($scope, $location) ->
        $scope.isSpecificPage = ->
            path = $location.path()
            return _.contains( ['/404', '/pages/500', '/pages/login', '/pages/signin', '/pages/signin1', '/pages/signin2', '/pages/signup', '/pages/signup1', '/pages/signup2', '/pages/lock-screen'], path )

        $scope.main =
            brand: 'Memcached Monitor'
            name: 'Lisa Doe' # those which uses i18n can not be replaced with two way binding var for now.

])

.controller('NavCtrl', [
    '$scope', 'taskStorage', 'filterFilter'
    ($scope, taskStorage, filterFilter) ->
        # init
        tasks = $scope.tasks = taskStorage.get()
        $scope.taskRemainingCount = filterFilter(tasks, {completed: false}).length

        $scope.$on('taskRemaining:changed', (event, count) ->
            $scope.taskRemainingCount = count
        )
])

.service('dataService', [
    '$http'
    ($http) ->
    
        delete $http.defaults.headers.common["X-Requested-With"]
        $http.defaults.headers.common["X-Custom-Header"] = "Angular.js"

        @getIndicators = (callbackFunc) ->
            
            $http.jsonp("http://localhost:5000/stats/last/?callback=JSON_CALLBACK")
            .success((data, status, headers, config) ->
                callbackFunc data
                return     
            ).error( () ->
                console.log("GET ERROR: /stats/last/")
                return     
            ).then (data, status, headers, config) ->
                callbackFunc data.data
                return
            return
        
        @getCacheIndicators = (callbackFunc) ->
            $http(
                method: "JSONP"
                url: "http://localhost:5000/stats/?callback=JSON_CALLBACK"
            ).success((data, status, headers, config) ->
                callbackFunc data
                return
            ).error( () ->
                console.log("GET ERROR: /stats/")
                return
            ).then (data, status, headers, config) ->
                callbackFunc data.data
                return
            return
        return
])

.controller('DashboardCtrl', [
    '$scope', '$http', 'dataService'
    ($scope, $http, dataService) ->
    
        $scope.indicators = null;
        $scope.itensInCache = null;
        
        $scope.assertivenessReadWrite = 
            percent: 0
            options:
                animate:
                    duration: 1000
                    enabled: true
                barColor: '#2EC1CC'
                lineCap: 'square'
                size: 180
                lineWidth: 20
    
        getAssertivenessReadWritePercentual = ->
            right = $scope.indicators.get_hits
            error = $scope.indicators.get_misses
            value = 0
            if right > 0
                value = (100 * right) / (right + error)
            Math.ceil value
            
        dataService.getIndicators (dataResponse) ->
            $scope.indicators = dataResponse
            #angular.element('.easypiechart').data('easyPieChart').update(getAssertivenessReadWritePercentual())
                
        dataService.getCacheIndicators (dataResponse) ->    
            $scope.itensInCache = dataResponse
            


])
