// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function($) {
  $(".feedback_widget_opener").click(function(event) {
    $("#fdbk_tab").click();
    event.preventDefault();
  })
  $("#service_subscription_address").change(function() {
      $.ajax({url: '/addresses/lookup_zone',
      data: 'address=' + this.value,
      dataType: 'script'})
      $('#loading-image').show();
  });
});
// 
//
// ----- CUFON RULERS ----- //
Cufon.replace('h1, h2, h3, h4, h5, h6'); // Works without a selector engine
Cufon.replace('.main_content_wrapper #teaser h2', {textShadow: '1em 1.5em 0 rgba(255, 255, 255, 1)'});
Cufon.replace('.footer_box h4', {textShadow: '1em 1.5em 0 rgba(255, 255, 255, 1)'});
Cufon.replace('.box h2', {color: '#ff9b59'});
Cufon.replace('h3', {color: '#222222'});
Cufon.replace('.header_text_container h3', {color: '#666666'});
// ----- CUFON RULERS ----- //

// ---- DROPDOWN MENU ---- //
$(function(){
	$('.nav li').hover(function() {
		$(this)
		  .find('ul:first')
		  .stop(true, true)
		  .slideDown('fast');
		}, function(){
	  $(this)
		.find('ul:first')
		.stop(true, true)
		.fadeOut(50);
	  });
});
// ---- DROPDOWN MENU ---- //
 
 
// ----- 3D CAROUSEL ----- //
$(function() {
		$("#carousel").featureCarousel({
			carouselSpeed: 300,
			counterStyle:1
	});
});
// ----- 3D CAROUSEL ----- //

// ---- SIDE LIST ANIMATION ---- //
$(function(){
	$('.content_300 #fresh_services li a').hover(function() {
		$(this).stop().animate({ paddingLeft:"30px" }, {queue:false, duration:150 });
	}, function() {
		$(this).stop().animate({ paddingLeft:"15px" }, {queue:false, duration:150 });
	});
});
// ---- SIDE LIST ANIMATION ---- //

// ---- IMAGES PRELOADER ---- //

$(function () {
	$('.gallery img').hide();
});

var i = 0;
var int=0;
$(window).bind("load", function() {
	var int = setInterval("doThis(i)",200);
});

function doThis() {
	var images = $('.gallery img').length;
	if (i >= images) {
		clearInterval(int);
	}
	$('.gallery img:hidden').eq(0).fadeIn(300);
	i++;
}
// ---- IMAGES PRELOADER ---- //

// ---- IMAGES OPACITY ---- //
$(function() {	
	$(".gallery a img").hover(function(){
		$(this).stop().fadeTo('normal', 0.3);
		$('.gallery li').hover(function(){
			$(this).css({'background' : 'url(images/green_grey/icons/plus.png) no-repeat center center'});
		});
	}, function() {
		$(this).stop().fadeTo('fast', 1);
		});
});

// ---- IMAGES OPACITY ---- //
