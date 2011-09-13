// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function($) {
    $("#service_subscription_address").change(function() {
        $.ajax({url: '/addresses/lookup_zone',
        data: 'address=' + this.value,
        dataType: 'script'})
        $('#loading-image').show();
    });
});
// 
