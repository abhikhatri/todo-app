//User Controller

(function(){

  'use strict';

  var todoApp = angular.module('todoApp');

  todoApp.controller('userController', function($http, $window, $state, userService) {

    var userCtrl = this;

    userCtrl.user = {};
    userCtrl.newTask = {};
    userCtrl.currentListIndex = 1;
    userCtrl.currentTasks = null;
    
    userCtrl.init = function() {
      $http.get('/api/v1/users/' + $window.localStorage.token)
        .success(function(data) {
          userCtrl.user = data.user;
          console.log(data.user);
        });
    };

    userCtrl.init();

    userCtrl.changeList = function(listId) {
      userCtrl.currentListIndex = listId;

      $http.get('/api/v1/tasks', {params: {list_id: listId}})
        .success(function(data) {
          userCtrl.currentTasks = data.tasks.reverse();
        });
    };

    userCtrl.addTask = function(task) {
      task.list_id = userCtrl.currentListIndex;

      $http.post('/api/v1/tasks', {task: task})
        .success(function(data){
          userCtrl.init();
          userCtrl.newTask = {};
        });
    };

    userCtrl.updateTask = function(task) {
      $http.put('/api/v1/tasks/' + task.id, {task: task})
        .success(function(data) {
            console.log(data);
        });
    };

    userCtrl.deleteTask = function(taskId) {
      $http.delete('/api/v1/tasks/' + taskId)
        .success(function(data) {
            userCtrl.init();
        });
    };

  });
  
})();