(function() {
  var app = angular.module('CounterApp');

  app.controller('GroupsCtrl', ['$scope', '$http', function($scope, $http) {
    $scope.groups = {};

    $scope.index = function() {
      $http.get('api/v1/groups')
        .success(function(data) {
          $scope.groups = data['groups'];
        })
        .error(function(data, status) {
          $scope.errors.push(data);
          console.log(data);
          console.log(status);
        });
    };

    $scope.join = function(id, index) {
      $http.post('api/v1/groups/' + id + '/join')
        .success(function(data) {
          $scope.groups = data['groups'];
        })
        .error(function(data, status) {
          $scope.errors.push(data);
          console.log(data);
          console.log(status);
        });
    };

    $scope.withdraw = function(id, index) {
      $http.post('api/v1/groups/' + id + '/withdraw')
        .success(function(data) {
          $scope.groups = data['groups'];
        })
        .error(function(data, status) {
          $scope.errors.push(data);
          console.log(data);
          console.log(status);
        });
    };
  }]);
})();
