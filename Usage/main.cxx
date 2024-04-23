#include <fstream>
#include <sstream>
#include <iostream>
#include <boost/iostreams/filtering_streambuf.hpp>
#include <boost/iostreams/copy.hpp>
#include <boost/iostreams/filter/zlib.hpp>
#include <zlib.h>

int main(int argc, char *argv[])
{

  std::cout << zlibVersion() << std::endl;
  
  {
    std::ofstream file("a.z", std::ios_base::out | std::ios_base::binary);
    boost::iostreams::filtering_streambuf<boost::iostreams::output> out;
    out.push(boost::iostreams::zlib_compressor());
    out.push(file);
    std::stringstream sstr{"nihao"};
    boost::iostreams::copy(sstr, out);
  }

  {
    std::ifstream file("a.z", std::ios_base::in | std::ios_base::binary);
    boost::iostreams::filtering_streambuf<boost::iostreams::input> in;
    in.push(boost::iostreams::zlib_decompressor());
    in.push(file);
  }

  
  return 0;
}
