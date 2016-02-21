(function(){

  'use strict';

  var todoApp = angular.module('todoApp', ['ui.router']);

  todoApp.run(function($rootScope, $state, $window) { 

    //Exposing the state to all views for conditional elements
    $rootScope.$state = $state;

    //Authservice to check logged in user

    $rootScope.$on("$stateChangeStart", function(event, toState, toParams, fromState, fromParams){
      if (toState.authenticate && !$window.localStorage.token){
        $state.transitionTo("app.login");
        event.preventDefault(); 
      }
    });

  });

  todoApp.config(function($stateProvider, $urlRouterProvider, $locationProvider) {
      
    $urlRouterProvider.otherwise('/404');
    
    $stateProvider
        
      .state('app', {
        url: '',
        abstract: true,
        controller: "applicationController as appCtrl",
        templateUrl: '/templates/index.html'
      })
      
      .state('app.home', {
        url: "/",
        views: {
          "app": {
            templateUrl: "/templates/home.html"
          }
        },
        authenticate: true
      })

      .state('app.login', {
        url: "/login",
        views: {
          "app": {
            controller: 'sessionController as sessionCtrl',
            templateUrl: "/templates/login.html"
          }
        }
      })

      .state('app.signup', {
        url: "/register",
        views: {
          "app": {
            controller: 'sessionController as sessionCtrl',
            templateUrl: "/templates/login.html"
          }
        }
      });

      // use the HTML5 History API
      $locationProvider.html5Mode(true);
          
  });

})();
