var initialMouse = 0;
var slideMovementTotal = 0;
var mouseIsDown = false;
var slider = $('#slider');

slider.on('mousedown touchstart', function(event){
	mouseIsDown = true;
	slideMovementTotal = $('#button-background').width() - $(this).width() + 10;
	initialMouse = event.clientX || event.originalEvent.touches[0].pageX;
});

$(document.body, '#slider').on('mouseup touchend', function (event) {
	if (!mouseIsDown)
		return;
	mouseIsDown = false;
	var currentMouse = event.clientX || event.changedTouches[0].pageX;
	var relativeMouse = currentMouse - initialMouse;

	if (relativeMouse < slideMovementTotal) {
		$('.slide-text').fadeTo(300, 1);
		slider.animate({
			left: "3px"
		}, 300);
		return;
	}
	slider.addClass('unlocked');
	$('#locker').text('done');
	setTimeout(function(){
		slider.on('click tap', function(event){
			if (!slider.hasClass('unlocked'))
				return;
			slider.removeClass('unlocked');
			$('#locker').text('keyboard_double_arrow_right');
			slider.off('click tap');
		});
	}, 0);
});

$(document.body).on('mousemove touchmove', function(event){
	if (!mouseIsDown)
		return;

	var currentMouse = event.clientX || event.originalEvent.touches[0].pageX;
	var relativeMouse = currentMouse - initialMouse;
	var slidePercent = 1 - (relativeMouse / slideMovementTotal);
	
	$('.slide-text').fadeTo(0, slidePercent);

	if (relativeMouse <= 3) { // Adjusted the value here
		slider.css({'left': '3px'}); // Adjusted the value here
		return;
	}
	if (relativeMouse >= slideMovementTotal + 3) {
		slider.css({'left': slideMovementTotal + 'px'});
		return;
	}
	slider.css({'left': relativeMouse});
});
