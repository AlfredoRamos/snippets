### Info

A small script to mimic a BBS spoiler BBCode. Check this [gist](https://gist.github.com/AlfredoRamos/6ec26124bf8d232e8126a5825c984950) for a code example

### Dependencies

- jQuery [[info](https://jquery.com/download/)]

### Usage

- Add `spoiler.js` script before `</body>` tag and after `jquery` lib
- Create the following `spoiler` structure

```html
<div class="spoiler">
	<div class="spoiler-header spoiler-trigger clearfix">Spoiler <span class="spoiler-status">Show</span></div>
		<div class="spoiler-body">
			 Hidden text :D
		</div>
</div>
```

- Initialize the spoilers with `initSpoilers()`

```html
...
		<!-- JavaScript -->
		<script src="spoiler.js"></script>
		<script>
			$(function() {
				$('.spoiler').initSpoilers();
			});
		</script>
	</body>
</html>
```
