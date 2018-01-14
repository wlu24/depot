// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require_tree .




// We need to tell Rails to serve up the translations that i18n-js provides and
// make the I18n object available.
//
// These directives tell Rails to include the referenced JavaScript libraries
// when serving up pages. Since the JavaScript files that come with i18n-js are
// inside a gem, we have to do this explicitly.
//= require i18n
//= require i18n/translations
