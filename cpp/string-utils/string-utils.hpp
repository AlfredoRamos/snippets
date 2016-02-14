#ifndef _STRINGUTILS_H
#define _STRINGUTILS_H

#include <string>
#include <algorithm>
#include <functional> 
#include <cctype>
#include <locale>

class StringUtils {
	public:
		static std::string &ltrim(std::string &str);
		static std::string &rtrim(std::string &str);
		static std::string &trim(std::string &str);
};

#endif //_STRINGUTILS_H