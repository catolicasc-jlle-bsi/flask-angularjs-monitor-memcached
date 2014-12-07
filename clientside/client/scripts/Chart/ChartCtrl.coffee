'use strict'

angular.module('app.chart.ctrls', [])

.controller('charCacheCtrl', [
    '$scope', '$http', '$compile', 'dataService'
    ($scope, $http, $compile, dataService) ->
    
        dataService.getCacheIndicators (dataResponse) ->
            
            angular.element(document.getElementById("curr-items-area-bar")).html('')
            
            Morris.Area
                element: "curr-items-area-bar"
                data: dataResponse,
                xkey: "created_at"
                ykeys: [
                    "curr_items"
                ]
                labels: [
                    "Items in cache"
                ]
            
            angular.element(document.getElementById("read-versus-written-area-bar")).html('')
            
            Morris.Area
                element: "read-versus-written-area-bar"
                data: dataResponse,
                xkey: "created_at"
                ykeys: [
                    "bytes_read"
                    "bytes_written"
                ]
                labels: [
                    "Bytes Read"
                    "Bytes Written"
                ]
])
            
.controller('chartCtrl', [
    '$scope', '$http', '$compile', 'dataService'
    ($scope, $http, $compile, dataService) ->
        
        dataService.getIndicators (dataResponse) ->
        
            getAssertivenessItemsFoundPercentual = ->
                if $scope.indicators != null
                    right = dataResponse.get_hits
                    error = dataResponse.get_misses
                    value = 0
                    if right > 0
                        value = (100 * right) / (right + error)
                    Math.ceil value

            getAssertivenessReadWritePercentual = ->
                if $scope.indicators != null
                    right = dataResponse.bytes_read
                    error = dataResponse.bytes_written
                    value = 0
                    if right > 0
                        value = (100 * right) / (right + error)
                    Math.ceil value
                
            $scope.assertivenessReadWrite = 
                percent: getAssertivenessReadWritePercentual()
                options:
                    animate:
                        duration: 1000
                        enabled: true
                    barColor: '#2EC1CC'
                    lineCap: 'square'
                    size: 180
                    lineWidth: 20

            $scope.assertivenessItemsFound = 
                percent: getAssertivenessItemsFoundPercentual()
                options:
                    animate:
                        duration: 1000
                        enabled: true
                    barColor: '#23AE89'
                    lineCap: 'square'
                    size: 180
                    lineWidth: 20

])
.controller('flotChartCtrl.realtime', [
    '$scope', '$http', 'dataService'
    ($scope, $http, dataService) ->
        
        dataService.getIndicators (dataResponse) ->
             $scope.realtimeIndicator = dataResponse.total_connections
                    
])