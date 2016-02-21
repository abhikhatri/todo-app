//Session Controller

(function(){

  'use strict';

  var todoApp = angular.module('todoApp');


  todoApp.factory('userService', function($http, $window, $state) {

    var serviceModule = {};

    serviceModule.login = function(user) {
      $http.post('api/v1/sessions', user)
        .success(function(data) {
          console.log(data);
          if(data.success) {
            $window.localStorage.token = data.login_token;
            $state.go('app.home');
          }
        });
    };

    serviceModule.register = function(userInfo) {
      $http.post('api/v1/users', {user: userInfo})
        .success(function(data) {
          console.log(data);
          if(data.success) {
            $window.localStorage.token = data.user.login_token;
            $state.go('app.home');
          }
        });
    };

    serviceModule.logout = function() {
      $http.delete('/api/v1/sessions/' + $window.localStorage.token)
        .success(function(data) {
          if(data.success) {
            $window.localStorage.clear();
          }
        });
    };

    return serviceModule;

  });
  
})();