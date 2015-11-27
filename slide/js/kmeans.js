(function($) {
    $(document).ready(function() {
	
	$('#kmeans').scianimator({
	    'images': ['assets/fig/kmeans1.png', 'assets/fig/kmeans2.png', 'assets/fig/kmeans3.png', 'assets/fig/kmeans4.png', 'assets/fig/kmeans5.png', 'assets/fig/kmeans6.png', 'assets/fig/kmeans7.png', 'assets/fig/kmeans8.png', 'assets/fig/kmeans9.png', 'assets/fig/kmeans10.png', 'assets/fig/kmeans11.png', 'assets/fig/kmeans12.png', 'assets/fig/kmeans13.png', 'assets/fig/kmeans14.png', 'assets/fig/kmeans15.png'],
	    'width': 480,
	    'delay': 1000,
	    'loopMode': 'loop'
	});
	$('#kmeans').scianimator('play');
    });
})(jQuery);
