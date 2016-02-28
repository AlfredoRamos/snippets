<?php

function rand_string($length = 10) {

	$chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
	$size = strlen($chars);
	$str = '';

	for($i = 0; $i < $length; $i++) {
		$str .= $chars[rand(0, $size - 1)];
	}

	return $str;

}