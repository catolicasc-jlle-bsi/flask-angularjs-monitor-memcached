(function() {
  'use strict';
  angular.module('app.controllers', []).controller('AppCtrl', [
    '$scope', '$location', function($scope, $location) {
      $scope.isSpecificPage = function() {
        var path;
        path = $location.path();
        return _.contains(['/404', '/pages/500', '/pages/login', '/pages/signin', '/pages/signin1', '/pages/signin2', '/pages/signup', '/pages/signup1', '/pages/signup2', '/pages/lock-screen'], path);
      };
      return $scope.main = {
        brand: 'Memcached Monitor',
        name: 'Lisa Doe'
      };
    }
  ]).controller('NavCtrl', [
    '$scope', 'taskStorage', 'filterFilter', function($scope, taskStorage, filterFilter) {
      var tasks;
      tasks = $scope.tasks = taskStorage.get();
      $scope.taskRemainingCount = filterFilter(tasks, {
        completed: false
      }).length;
      return $scope.$on('taskRemaining:changed', function(event, count) {
        return $scope.taskRemainingCount = count;
      });
    }
  ]).service('dataService', [
    '$http', function($http) {
      delete $http.defaults.headers.common["X-Requested-With"];
      $http.defaults.headers.common["X-Custom-Header"] = "Angular.js";
      this.getIndicators = function(callbackFunc) {
        $http.jsonp("http://localhost:5000/stats/last/?callback=JSON_CALLBACK").success(function(data, status, headers, config) {
          callbackFunc(data);
        }).error(function() {
          console.log("GET ERROR: /stats/last/");
        }).then(function(data, status, headers, config) {
          callbackFunc(data.data);
        });
      };
      this.getCacheIndicators = function(callbackFunc) {
        $http({
          method: "JSONP",
          url: "http://localhost:5000/stats/?callback=JSON_CALLBACK"
        }).success(function(data, status, headers, config) {
          callbackFunc(data);
        }).error(function() {
          console.log("GET ERROR: /stats/");
        }).then(function(data, status, headers, config) {
          callbackFunc(data.data);
        });
      };
    }
  ]).controller('DashboardCtrl', [
    '$scope', '$http', 'dataService', function($scope, $http, dataService) {
      var getAssertivenessReadWritePercentual;
      $scope.indicators = null;
      $scope.itensInCache = null;
      $scope.assertivenessReadWrite = {
        percent: 0,
        options: {
          animate: {
            duration: 1000,
            enabled: true
          },
          barColor: '#2EC1CC',
          lineCap: 'square',
          size: 180,
          lineWidth: 20
        }
      };
      getAssertivenessReadWritePercentual = function() {
        var error, right, value;
        right = $scope.indicators.get_hits;
        error = $scope.indicators.get_misses;
        value = 0;
        if (right > 0) {
          value = (100 * right) / (right + error);
        }
        return Math.ceil(value);
      };
      dataService.getIndicators(function(dataResponse) {
        return $scope.indicators = dataResponse;
      });
      return dataService.getCacheIndicators(function(dataResponse) {
        return $scope.itensInCache = dataResponse;
      });
    }
  ]);

}).call(this);

//# sourceMappingURL=main.js.map
