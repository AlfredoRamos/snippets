#include "stringutils.hpp"

std::string &StringUtils::ltrim(std::string &str) {
	str.erase(
		str.begin(),
		std::find_if(
			str.begin(),
			str.end(),
			std::not1(std::ptr_fun<int, int>(std::isspace))
		)
	);
	
	return str;
}

std::string &StringUtils::rtrim(std::string &str) {
	str.erase(
		std::find_if(
			str.rbegin(),
			str.rend(),
			std::not1(std::ptr_fun<int, int>(std::isspace))
		).base(),
		str.end()
	);
	
	return str;
}

std::string &StringUtils::trim(std::string &str) {
	return StringUtils::ltrim(StringUtils::rtrim(str));
}