setTimeout(function() {

	var text = getUrlVars()['q'],
		links = document.querySelectorAll('.bia.uh_rl');

	for (var i = 0; i < links.length; i++) {
		links[i].href = 'https://yandex.ru/images/search?text=' + text + '&source=z-google-images';
	}
	
	// console.log('updated links', links.length);

	function getUrlVars() {
		var vars = {};
		var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi,
			function(m, key, value) {
				vars[key] = value;
			});
		return vars;
	}
}, 1000);