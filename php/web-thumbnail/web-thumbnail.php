<?php

/**
 * Generate a web thumbnail using mshots.
 *
 * @param string	$url		The URL to generate the thumbnail
 * @param array		$options	Options for mshots
 *
 * @return string
 */
function web_thumbnail($url = '', $options = []) {
	$uri = '';

	if (empty($url)) {
		return $uri;
	}

	// Merge options
	$options = array_merge([
		'w' => 150,
		'h' => 150
	], $options);

	// Cast values
	$options['w'] = (int) $options['w'];
	$options['h'] = (int) $options['h'];

	$format = 'https://s.wordpress.com/mshots/v1/%1$s%2$s';

	// Clean URL
	$url = preg_replace('/^http(?:s)?:\/\//i', '', $url);
	$url = preg_replace('/(?:\/)$/', '', $url);

	$url = rawurlencode($url);
	$args = '';

	if ($options['w'] > 0 && $options['h'] > 0) {
		$args = sprintf('?%s', http_build_query($options, null, '&', PHP_QUERY_RFC3986));
	}

	// Generate URI
	$uri = vsprintf($format, [$url, $args]);

	return $uri;
}
