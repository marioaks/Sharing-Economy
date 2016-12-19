$(function() {
	$('.btn').on('click', function(e) {
		e.preventDefault();
		$('html, body').animate({
        scrollTop: $(document).height()
    }, 'slow');
    return false;
	});
});
