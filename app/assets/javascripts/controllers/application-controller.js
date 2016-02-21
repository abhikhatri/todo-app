//Application Controller
(function(){

  'use strict';

  var todoApp = angular.module('todoApp');

  todoApp.controller('applicationController', function($http, $window, $state, userService) {

    var appCtrl = this;

    appCtrl.logout = function() {
      userService.logout();
      $state.go('app.login');
    };


  });
  
})();