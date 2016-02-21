//User Controller

(function(){

  'use strict';

  var todoApp = angular.module('todoApp');

  todoApp.controller('userController', function($http, $window, $state, userService) {

    var userCtrl = this;

    userCtrl.user = {};
    userCtrl.currentListIndex = 0;
    
    userCtrl.init = function() {
      $http.get('/api/v1/users/' + $window.localStorage.token)
        .success(function(data) {
          console.log(data);
          userCtrl.user = data.user;
        });
    };

    userCtrl.init();


    userCtrl.changeList = function(index) {
      userCtrl.currentListIndex = index;
      console.log(userCtrl.currentListIndex);
    };

    userCtrl.addTask = function(task) {
      task.list_id = userCtrl.currentListIndex;
      $http.post('/api/v1/tasks', {task: task})
        .success(function(data){
          console.log(data);
        });
    };

  });
  
})();