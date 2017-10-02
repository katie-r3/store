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
//= require jquery2
//= require jquery-ui
//= require jquery.raty
//= require foundation
//= require rails-ujs
//= require_tree .

$(function(){ $(document).foundation();
  $('.review-rating').raty({
    readOnly: true,
    score: function() {
      return $(this).attr('data-score');
    },
    path: '/assets'
  });

  $('#rating-form').raty({
    path: '/assets',
    scoreName: 'review[rating]'
  });

  $('.average-review-rating').raty({
    readOnly: true,
    path: '/assets',
    score: function() {
      return $(this).attr('data-score');
    }
  });
});
