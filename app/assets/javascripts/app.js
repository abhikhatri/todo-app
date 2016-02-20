(function(){

  'use strict';

  var todoApp = angular.module('todoApp', ['ui.router']);

  todoApp.run(function($rootScope, $state) { 

    //Exposing the state to all views for conditional elements
    $rootScope.$state = $state;

  });

  todoApp.config(function($stateProvider, $urlRouterProvider, $locationProvider) {
      
    $urlRouterProvider.otherwise('/404');
    
    $stateProvider
        
      .state('app', {
        url: '',
        abstract: true,
        controller: "applicationController",
        templateUrl: '/templates/index.html'
      })
      
      .state('app.home', {
        url: "/",
        views: {
          "app": {
            templateUrl: "/templates/home.html"
          }
        }
      })

      .state('app.login', {
        url: "/login",
        views: {
          "app": {
            templateUrl: "/templates/login.html"
          }
        }
      });

      // use the HTML5 History API
      $locationProvider.html5Mode(true);
          
  });

})();
