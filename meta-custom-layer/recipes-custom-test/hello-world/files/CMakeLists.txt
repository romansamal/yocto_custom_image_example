cmake_minimum_required(VERSION 3.20)
project(test)

enable_language(CXX)

find_package(PkgConfig REQUIRED)

# Use results of pkg_check_modules() call.
include_directories(${DBUS_INCLUDE_DIRS})
link_directories(${DBUS_LIBRARY_DIRS})

set(CMAKE_CXX_STANDARD 20)

set(SRC_server server.cpp)
set(SRC_client client.cpp)

add_executable(hello-world-server ${SRC_server})
add_executable(hello-world-client ${SRC_client})

target_link_libraries(hello-world-server ${DBUS_LIBRARIES} zmq)
target_link_libraries(hello-world-client ${DBUS_LIBRARIES} zmq)

install(TARGETS hello-world-server hello-world-client DESTINATION bin)

