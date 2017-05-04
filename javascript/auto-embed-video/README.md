### Info

A script to auto-embed videos using the *lazy loading* technique

A live demo is located at [Auto Embed Video](https://alfredoramos.github.io/auto-embed-video)

### Dependencies

- jQuery [[info](https://jquery.com/download/)]
- sprintf [[info](https://github.com/alexei/sprintf.js)]

### Usage

Add `auto-embed-services.js` and `auto-embed.js` scripts before `</body>` tag and after `jquery` and `sprintf` lib

**test.html**
```html
...
<head>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.slim.min.js"></script>
</head>
...
<body>
	<div id="responsive-media" data-url"https://www.youtube.com/watch?v=XXXXXXXXXXXX"></div>

	<!-- Scripts -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/sprintf/1.0.3/sprintf.min.js"></script>
	<script src="auto-embed-services.js"></script>
	<script src="auto-embed.js"></script>
	<script>
		$(function() {
			$('.responsive-media').generateEmbedHtml({
				itemClass: 'responsive-media-item',
				showUrl: true
			});
		});
	</script>
</body>
...
```
