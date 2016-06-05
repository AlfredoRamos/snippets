<?php

/**
 * Generate a web thumbnail using mshots
 * @param	string	$url		The URL to generate the thumbnail
 * @param	array	$options	Options for mshots
 * @return	string|bool
 */
function web_thumbnail($url = '', $options = []) {
	if (empty($url)) {
		return false;
	}

	$defaults = [
		'w' => null, // Image width
		'h' => null, // Image height
	];
	$options = array_merge($defaults, $options);

	$uri = 'https://www.wordpress.com/mshots/v1/%1$s%2$s';
	$tmp = [];

	// Clean URL
	$tmp['clean'] = preg_replace('/^http(s)?\:\/\//i', '', $url);
	$tmp['clean'] = preg_replace('/\?$/i', '', $tmp['clean']);

	// Build options query
	$tmp['query'] = http_build_query($options);
	$tmp['query'] = isset($options['w'], $options['h']) ? sprintf('?%s', $tmp['query']) : '';

	// Generate URI
	$uri = vsprintf($uri, [$tmp['clean'], $tmp['query']]);

	return $uri;
}
