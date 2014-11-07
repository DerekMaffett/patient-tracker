//= require_self
//= require_tree ./ng_patient_tracker

(function() {
  var app = angular.module(
    'CounterApp',
    [
      'LayoutDirectives',
      'EncounterDirectives',
      'GroupDirectives',
      'EncounterFilters',
      'ngRoute',
      'ngCookies'
    ]
  );

  app.run(['$rootScope', '$cookieStore', '$http', function($rootScope, $cookieStore, $http) {

    $rootScope.getCurrentUser = function() {
      $http.get('angular/get_current_user')
        .success(function(data) {
          $cookieStore.put('currentUser', data);
        })
        .error(function(data, status) {
          console.log("Not working, go replace with a better function");
        });
    };

    $rootScope.setCurrentUserGroup = function(groupId) {
      var data = $cookieStore.get('currentUser');
      data['user']['group_id'] = groupId;
      $cookieStore.put('currentUser', data);
    }

    $rootScope.currentUser = function() {
      return $cookieStore.get('currentUser');
    };
  }]);
})();
