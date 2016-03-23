<?php
/**
 * Simple, small and useful function to
 * get thumbnail image from a URL using
 * http://s.wordpress.com/mshots/v1/
 */
function get_web_thumbnail ($url = null, $width = null, $height = null) {
	
	$mshots = 'http://s.wordpress.com/mshots/v1/';
	$thumbnail = '';
	
	if (isset($url)) {
	
		$clean_url = preg_replace('/^http(s)?\:\/\//i', '', $url);	
		$clean_url = preg_replace('/www\./i', '', $clean_url);
	
		$thumbnail .= $mshots.$clean_url.(isset($width) ? '?w='.rawurlencode($width) : '').(isset($height) ? '&h='.rawurlencode($height) : '');
		
	}
	
	return $thumbnail;
	
}