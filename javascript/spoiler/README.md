### Info

A small script to mimic a BBS spoiler BBCode.

### Dependencies

- jQuery [[info](https://jquery.com/download/)]

### Usage

- Add `spoiler.js` script before `</body>` tag and after `jquery` lib
- Create the following `spoiler` structure:

```html
<div class="spoiler">
	<div class="spoiler-header spoiler-trigger">
		<span class="spoiler-title">Spoiler</span>
		<span class="spoiler-status">Show</span>
	</div>
	<div class="spoiler-body">
		Hidden text
	</div>
</div>
```

- Initialize the spoilers:

```html
	$(document).initSpoilers();
```

Check this [gist](https://gist.github.com/AlfredoRamos/6ec26124bf8d232e8126a5825c984950) for a code example.
