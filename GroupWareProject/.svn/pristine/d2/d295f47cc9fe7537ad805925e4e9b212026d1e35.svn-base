$(function() {
    let items = $('.accordion-button');
    let icons = $('.fa-active');

    items.on('mouseenter', function(e) {
        let span = $(this).children()[0];
        $(span).css('color', 'cadetblue');
    }).on('mouseleave', function(e) {
        let span = $(this).children()[0];
        $(span).css('color', 'black');
    });
    
    function toggleIconBeat(e) {
    	if($(e.currentTarget).find('.fa')) {
	    	$(e.currentTarget).children().eq(0).toggleClass('fa-beat');
    	}
    }
    
    icons.on('mouseenter', toggleIconBeat).on('mouseleave', toggleIconBeat);
});

