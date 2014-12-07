'use strict';

angular.module('app.controllers', [])

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

# overall control
.controller('AppCtrl', [
    '$scope', '$location'
    ($scope, $location) ->
        $scope.isSpecificPage = ->
            path = $location.path()
            return _.contains( ['/404', '/pages/500'], path )

        $scope.main =
            brand: 'Memcached Monitor'
            name:  'Logged User'

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
                
        $scope.assertivenessItemsFound = 
            percent: 0
            options:
                animate:
                    duration: 1000
                    enabled: true
                barColor: '#2EC1CC'
                lineCap: 'square'
                size: 180
                lineWidth: 20
                
        dataService.getIndicators (dataResponse) ->
            $scope.indicators = dataResponse
                
        dataService.getCacheIndicators (dataResponse) ->    
            $scope.itensInCache = dataResponse

])
