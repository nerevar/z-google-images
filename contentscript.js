setTimeout(function() {
	var input = document.querySelector('.gsfi'),
		text = input && input.value,
		links = document.querySelectorAll('.bia.uh_rl');

	for (var i = 0; i < links.length && input; i++) {
		links[i].href = 'https://yandex.ru/images/search?text=' + text + '&source=z-google-images';
	}
}, 1000);