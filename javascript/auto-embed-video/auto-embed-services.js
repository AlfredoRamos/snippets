/**
 * Services for auto-embed videos script
 * https://github.com/AlfredoRamos/snippets/tree/master/javascript/auto-embed-videos
 * @author Alfredo Ramos <alfredo.ramos@yandex.com>
 * @version 0.1.0
 * @copyright (c) 2016 Alfredo Ramos
 * @license GNU GPL-3.0+
 */
var $services = {
	youtube: {
		regex: /(?:http?s?:\/\/)?(?:www\.)?(?:youtube\.com|youtu\.be)\/(?:watch\?v=|embed\/)?(\w+)/i,
		embed: 'https://www.youtube-nocookie.com/embed/%2$s?rel=0'
	},
	vimeo: {
		regex: /(?:http?s?:\/\/)?(?:www\.)?vimeo\.com\/(\d+)/i,
		embed: 'https://player.vimeo.com/video/%2$s'
	},
	vkontakte: {
		regex: /(?:http?s?:\/\/)?(?:www\.)?vk\.com\/video_ext\.php\?oid=([-\w]+)&id=([-\w]+)&hash=([-\w]+)(?:&hd=\w+)?/i,
		embed: 'https://vk.com/video_ext.php?oid=%2$s&id=%3$s&hash=%4$s&hd=1'
	},
	dailymotion: {
		regex: /(?:http?s?:\/\/)?(?:www\.)?(?:dailymotion\.com|dai\.ly)\/(?:video\/)?(\w+)/i,
		embed: 'https://www.dailymotion.com/embed/video/%2$s'
	},
	twitch: {
		regex: /(?:http?s?:\/\/)?(?:www\.)?twitch\.tv\/([A-Za-z0-9]+)(?:\/v\/)?(\d+)?/i,
		embed: 'https://player.twitch.tv/?%1$s=%2$s&autoplay=false'
	},
	video: {
		regex: /(.+)\.(mp4|webm|ogv)/i,
		embed: '%1$s'
	}
};
