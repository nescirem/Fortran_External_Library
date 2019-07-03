#ifdef _WIN64
#define __WINDOWS
#elif _WIN32
#define __WINDOWS
#else //GNU Linux
#define __UNIX
#endif
