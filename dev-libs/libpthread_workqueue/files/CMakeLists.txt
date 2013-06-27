project(pthread_workqueue)

cmake_minimum_required(VERSION 2.4.0)


include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/src)

set(sources
	src/api.c
	src/witem_cache.c
	src/posix/manager.c
	src/posix/thread_info.c
	src/posix/thread_rt.c)


add_library(pthread_workqueue SHARED ${sources})
set_target_properties(pthread_workqueue PROPERTIES VERSION 0.0.0 SOVERSION 0.0)
set_target_properties(pthread_workqueue PROPERTIES COMPILE_FLAGS "-fvisibility=hidden")
target_link_libraries(pthread_workqueue -lpthread)

install(TARGETS pthread_workqueue LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
