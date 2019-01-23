var App = App || {};

(function(App) {
  "use strict";

  App.determinePhase = function() {
    var href = window.location.href;
    
    return href.match(/phase_[a-z]+/) ? href.match(/phase_[a-z]+/)[0] : "";
  };
})(App);
