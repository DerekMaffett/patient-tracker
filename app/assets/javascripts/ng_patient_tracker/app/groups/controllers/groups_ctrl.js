(function() {
  var app = angular.module('CounterApp');

  app.controller('GroupsCtrl', ['$scope', '$http', function($scope, $http) {
    $scope.groups = {};

    $scope.index = function() {
      $http.get('api/v1/groups')
        .success(function(data) {
          $scope.groups = data['groups']
        })
        .error(function(data, status) {
          $scope.errors.push(data);
          console.log(data);
          console.log(status);
        });
    };
  }]);
})();
