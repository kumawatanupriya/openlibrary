'use strict';

angular.module('openLibraryApp', [
]).config( [
  '$compileProvider',
  function( $compileProvider )
  {
    $compileProvider.aHrefSanitizationWhitelist(/^\s*(https?|smb|file|chrome-extension):/);
  }
]).constant('openLibraryServiceConfig', {
  'baseUrl': 'http://localhost:9292'
});