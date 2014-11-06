//= require_self
//= require_tree ./ng_patient_tracker

(function() {
  var app = angular.module(
    'CounterApp',
    ['LayoutDirectives', 'EncounterDirectives', 'EncounterFilters', 'ngRoute']);
})();
