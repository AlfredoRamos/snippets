/**
 * Auto-embed video
 * https://github.com/AlfredoRamos/snippets/tree/master/javascript/auto-embed-video
 * @author Alfredo Ramos <alfredo.ramos@yandex.com>
 * @version 0.1.0
 * @copyright (c) 2016 Alfredo Ramos
 * @license GNU GPL-3.0+
 */
$(function() {
	// Get embed HTML
	$.fn.generateEmbedHtml = function($options) {
		// Debug
		console.log(this.length);
		console.log(typeof($services));

		// Exit if there's no videos to process or if the
		// $services object is not declared
		if (!this.length || typeof($services) === 'undefined') {
			return;
		}

		// Overwrite settings
		$options = $.extend({
			itemClass: '',
			loadClass: 'load',
			urlClass: 'video-info',
			showUrl: false
		}, $options);

		// Iterate videos
		$.each(this, function() {
			var $video = {
				object: $(this),
				url: $(this).attr('data-url'),
				embed: ''
			};

			// Iterate services
			$.each($services, function($key, $value) {
				var $matches = $video.url.match($value.regex);
				var $html = '<iframe%2$s src="%1$s" frameborder="0" scrolling="no" allowfullscreen="true"></iframe>';
				var $info = '<pre%2$s>%1$s</pre>';

				if ($matches) {
					// Get embed URL
					$video.embed = vsprintf($value.embed, $matches);

					// Service-specific fixes
					switch($key) {
						case 'twitch':
							$video.embed = vsprintf($value.embed, [
								(typeof($matches[2]) !== 'undefined' ? 'video' : 'channel'),
								(typeof($matches[2]) !== 'undefined' ? sprintf(
									'v%s',
									$matches[2]
								) : $matches[1])
							]);
							break;
						case 'video':
							$html = '<video%2$s controls="true"><source src="%1$s" /></video>';
							break;
					}

					// Add .load class
					$video.object.addClass(function() {
						return $(this).hasClass($options.loadClass) ? false : $options.loadClass;
					});

					// Generate HTML
					$video.object.one('mouseover', function() {
						// Remove .load class
						$(this).removeClass(function() {
							return $(this).hasClass($options.loadClass) ? $options.loadClass : false;
						});

						$video.object.html(vsprintf($html, [
							$video.embed,
							(!$options.itemClass.length ? '' : sprintf(
								' class="%s"',
								$options.itemClass.replace(/[\.#]/g, '')
							))
						]));
					});

					// Show video URL
					if ($options.showUrl) {
						$(vsprintf($info, [
							$video.url,
							(!$options.urlClass.length ? '' : sprintf(
								' class="%s"',
								$options.urlClass.replace(/[\.#]/g, '')
							))
						])).insertAfter($video.object);
					}
				}
			});
		});

	};
});
