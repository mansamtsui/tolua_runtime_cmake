cmake_minimum_required(VERSION 3.0)
 
set(CMAKE_BUILD_TYPE Debug)
 
project(tolua)
 
set(LUA_SRC_FILES
    tolua.c
    int64.c
    uint64.c
    pb.c
    lpeg.c
    struct.c
    cjson/strbuf.c
    cjson/lua_cjson.c
    cjson/fpconv.c
    luasocket/auxiliar.c
    luasocket/buffer.c
    luasocket/except.c
    luasocket/inet.c
    luasocket/io.c
    luasocket/luasocket.c
    luasocket/mime.c
    luasocket/options.c
    luasocket/select.c
    luasocket/tcp.c
    luasocket/timeout.c
    luasocket/udp.c
    luasocket/wsocket.c
)
 
include_directories(
    luaJIT/src
    luasocket
)


add_subdirectory(LuaJIT)


add_compile_definitions(_WIN32_WCE)
add_compile_definitions(_WINSOCK_DEPRECATED_NO_WARNINGS)
add_compile_definitions(_CRT_SECURE_NO_WARNINGS)
add_compile_definitions(LUA_BUILD_AS_DLL)
add_compile_definitions(LUA_LIB)


add_library(tolua SHARED
    ${LUA_SRC_FILES}
)

target_link_libraries(tolua PRIVATE ws2_32 libluajit)
