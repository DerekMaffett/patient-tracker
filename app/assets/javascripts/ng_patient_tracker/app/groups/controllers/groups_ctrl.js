 (function() {
   var app = angular.module('CounterApp');

  app.controller('GroupsCtrl', ['$scope', '$http', '$rootScope',
    function($scope, $http, $rootScope) {

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
            $rootScope.setCurrentUserGroup(id);
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
            $rootScope.setCurrentUserGroup(null);
          })
          .error(function(data, status) {
            $scope.errors.push(data);
            console.log(data);
            console.log(status);
          });
      };
   }]);
 })();
