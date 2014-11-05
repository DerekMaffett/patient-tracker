(function() {
  var app = angular.module('CounterApp');

  app.controller('FooterCtrl', ['$scope', function($scope) {
    $scope.currentYear = Date.now();
  }])
})();
