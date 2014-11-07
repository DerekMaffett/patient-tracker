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
    return function(input, label) {
      var encounterType = label.toLowerCase();
      console.log('Encounter Type: ' + encounterType)
      return input.filter(function(encounter) {
        return encounter.encounter_type == encounterType;
      });
    };
  });
})();
