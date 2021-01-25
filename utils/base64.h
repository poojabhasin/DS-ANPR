#ifndef __BASE64_H__
#define __BASE64_H__

#include <string>
#include <iostream>

namespace b64 {
    class base64convertor {
        
        public:
            std::string base64_encode(unsigned char const* , unsigned int len);
            std::string base64_decode(std::string const& s);
        
        private:
            const std::string base64_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";;
            inline bool is_base64(unsigned char c);
    };
}

#endif
