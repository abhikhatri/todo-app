var todoApp = angular.module('todoApp', ['ui.router']);

todoApp.config(function($stateProvider, $urlRouterProvider, $locationProvider) {
    
    $urlRouterProvider.otherwise('/home');
    
    $stateProvider
        
        // HOME STATES AND NESTED VIEWS ========================================
        .state('app', {
            url: '',
            abstract: true,
            controller: "mainController",
            templateUrl: '/templates/index.html'
        })
        
        // ABOUT PAGE AND MULTIPLE NAMED VIEWS =================================
        .state('app.home', {
            url: "/home",
            views: {
              "app": {
                controller: "mainController",
                templateUrl: "/templates/home.html"
              }
            }
        });

        // use the HTML5 History API
        $locationProvider.html5Mode(true);
        
});


todoApp.controller('mainController', function($http) {

    var main = this;
    console.log('Hello');

});