//Session Controller

(function(){

  'use strict';

  var todoApp = angular.module('todoApp');

  todoApp.controller('sessionController', function($http, $window, userService) {

    var sessionCtrl = this;

    sessionCtrl.login = function(user) {
      userService.login(user);
    };

    sessionCtrl.register = function(user) {
      userService.register(user);
    };
    

  });
  
})();