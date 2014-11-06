(function() {
  var app = angular.module('EncounterFilters', []);

  app.filter('firstWord', function() {
    return function(input) {
      return input.split(' ')[0];
    };
  });

  app.filter('lastWords', function() {
    return function(input) {
      return input.split(' ').slice(1).join(' ');
    };
  });

  app.filter('serverTypes', function() {
    return function(input) {
      var lowerCase = input.toLowerCase();
      return lowerCase.charAt(0).toUpperCase() + lowerCase.slice(1);
    };
  });
})();
