'use strict';

describe('Controller:ReservationCtrl', function () {
  beforeEach(module('openLibraryApp'));

  var scope, controller, httpBackend, userFactory;
  beforeEach(inject(function ($rootScope, $controller, $httpBackend, User) {
    httpBackend = $httpBackend;
    scope = $rootScope.$new();
    userFactory = User;

    controller = $controller('ReservationCtrl', {
      $scope: scope,
      User: userFactory
    });
  }));

  it('should find user for a given id', function () {
      scope.employeeId = '1';
      var user_mock = {id: 1};

      httpBackend.expectGET('http://localhost:9292/users/'+scope.employeeId).respond(user_mock);
      scope.userFound();
      httpBackend.flush();
    }
  );
});