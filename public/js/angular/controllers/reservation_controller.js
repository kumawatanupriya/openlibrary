'use strict';
angular.module('openLibraryApp').
  controller('ReservationCtrl', function ($scope, User) {
    $scope.employeeId = "";
    $scope.bookId = "";
    $scope.error = "";
    $scope.employeeFieldFocus = false;
    $scope.userInfo = null;

    $scope.userFound = function() {
      if($scope.employeeId == "") return;
      User.getDetails($scope.employeeId)
        .success(function (data) {
        })
        .error(function(error) {
          $scope.error = 'Unable to fetch details:' + error.message;
        });
    };
  });