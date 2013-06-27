project(kqueue)

cmake_minimum_required(VERSION 2.4.0)


include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/src)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/src/common)

set(sources
	src/common/filter.c
	src/common/kevent.c
	src/common/knote.c
	src/common/kqueue.c
	src/common/map.c
	src/linux/platform.c
	src/linux/read.c
	src/linux/signal.c
	src/linux/timer.c
	src/linux/user.c
	src/linux/vnode.c
	src/linux/write.c
	)


add_library(kqueue SHARED ${sources})
set_target_properties(kqueue PROPERTIES VERSION 0.0.0 SOVERSION 0.0)
#set_target_properties(kqueue PROPERTIES COMPILE_FLAGS "-fvisibility=hidden")
target_link_libraries(kqueue -lpthread -lrt)

install(TARGETS kqueue LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/libkqueue.pc DESTINATION "${CMAKE_INSTALL_LIBDIR}/pkgconfig")
install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/include/sys/event.h DESTINATION "include/kqueue/sys/")
