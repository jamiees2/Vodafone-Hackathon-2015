$(function() {
	// Low fuel limit
	var lowFuel = 15;
	
	// Animate the progress bars
	$('.progress-fuel').each(function() {
		$(this).css('width', $(this).data('pct')+'%');
		if(Number($(this).data('pct')) <= lowFuel) {
			$(this).css('background', '#f00');
		}
	});
});