(function() {
  var app = angular.module('CounterApp');

  app.controller('EncountersCtrl',
    ['$scope', '$http', function($scope, $http) {

      $scope.displayLabels = [
        "Adult Inpatient", "Adult ED", "Adult ICU", "Adult Inpatient Surgery",
        "Pediatric Inpatient", "Pediatric Newborn", "Pediatric ED",
        "Continuity Inpatient", "Continuity External"
      ];

      $scope.encounters = {};
      $scope.groupUsers = [{id: 1, name: 'Nick Manos'}, {id: 2, name: 'Nick Manos'}];
      $scope.totalNewEncounters = 0;
      $scope.newEncounters = {
        encountered_on: new Date(),
        encounter_types: {
          adult_inpatient: 0,
          adult_ed: 0,
          adult_icu: 0,
          adult_inpatient_surgery: 0,
          pediatric_inpatient: 0,
          pediatric_newborn: 0,
          pediatric_ed: 0,
          continuity_inpatient: 0,
          continuity_external: 0
        }
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
          });
      };

      $scope.create = function() {
        $http.post('api/v1/encounters', $scope.newEncounters)
          .success(function(data) {
            console.dir(data);
            data['encounters'].forEach(function(encounter) {
              $scope.encounters.push(encounter);
              resetEncounters();
            });
          })
          .error(function(data, status) {
            $scope.errors.push(data);
            console.log(data);
            console.log(status);
          });
      };

      $scope.addEncounterType = function(label) {
        $scope.newEncounters['encounter_types'][$scope.to_param(label)]++;
        $scope.totalNewEncounters++;
        $scope.has_items = true;
      };

      $scope.resetEncounters = function() {
        for (var type in $scope.newEncounters['encounter_types']) {
          $scope.newEncounters['encounter_types'][type] = 0;
          $scope.totalNewEncounters = 0;
        };
      };

      $scope.setTab = function(tab) {
        $scope.tab = tab;
      };

      $scope.currentTabIs = function(tab) {
        return $scope.tab == tab;
      };

      $scope.to_param = function(label) {
        return label.toLowerCase().replace(/ /g, '_');
      };

  }]);
})();
