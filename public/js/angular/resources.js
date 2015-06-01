'use strict';

var app = angular.module('openLibraryApp');

app.factory('User', ['$http', 'openLibraryServiceConfig', function($http, openLibraryServiceConfig) {
  var userFactory = {};
  userFactory.getDetails = function(empId) {
    return $http.get(openLibraryServiceConfig.baseUrl+'/users/'+empId);
  };
  return userFactory;
}]);