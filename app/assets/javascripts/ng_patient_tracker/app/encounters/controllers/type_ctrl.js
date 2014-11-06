(function() {
  var app = angular.module('CounterApp');

  app.controller('TypeCtrl', ['$scope', function($scope) {
    $scope.has_items = false;

    $scope.setTypeHasItems = function() {
      $scope.has_items = true;
    };
  }]);
})();
