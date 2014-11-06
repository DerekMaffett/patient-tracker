(function() {
  var app = angular.module('CounterApp');

  app.controller('EncountersCtrl',
    ['$scope', '$http', function($scope, $http) {

      $scope.encounters = {};
      $scope.newEncounters = {
        encountered_on: new Date()
      };

      $scope.index = function() {
        $http.get('api/v1/encounters')
          .success(function(data) {
            $scope.encounters = data['encounters'];
          })
          .error(function(data, status) {
            $scope.errors.push(data);
            console.log(data);
            console.log(status);
          })
      };

  }]);
})();
