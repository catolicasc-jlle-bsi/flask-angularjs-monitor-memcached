(function() {
  'use strict';
  angular.module('app.chart.ctrls', []).controller('chartController', [
    '$scope', function($scope) {
      return $scope.assertiveness = {
        percent: 80,
        options: {
          animate: {
            duration: 1000,
            enabled: true
          },
          barColor: '#1C7EBB',
          lineCap: 'round',
          size: 180,
          lineWidth: 20
        }
      };
    }
  ]);

}).call(this);

//# sourceMappingURL=ChartController.js.map
