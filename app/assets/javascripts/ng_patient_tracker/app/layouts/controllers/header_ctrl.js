(function() {
  var app = angular.module('CounterApp');

  app.controller('HeaderCtrl', [ '$scope', '$location', function($scope, $location) {

    $scope.getLocation = function() {
      return $location.path();
    };

    $scope.redirectToEncounters = function() {
      $location.path('/encounters');
    };

    $scope.redirectToProfile = function() {
      $location.path('/profile');
    };
  }]);
})();
