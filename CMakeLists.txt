cmake_minimum_required (VERSION 3.12.4)
project (AutoCenter)

set (CMAKE_PREFIX_PATH "C:\\Qt\\Qt5.11.1\\5.11.1\\msvc2017_64")

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

###############################################
## OUTPUT DIRECTORY SETUP
###############################################
SET (CMAKE_LIBRARY_OUTPUT_DIRECTORY
	${PROJECT_BINARY_DIR}/bin
	CACHE PATH
	"Single directory for all libraries"
	)
   
SET (CMAKE_RUNTIME_OUTPUT_DIRECTORY
	${PROJECT_BINARY_DIR}/bin
	CACHE PATH
	"Single directory for all executable and dll"
	)

SET (CMAKE_ARCHIVE_OUTPUT_DIRECTORY
	${PROJECT_BINARY_DIR}/lib
	CACHE PATH
	"Single directory for all static libraries"
	)

#####################################################
## CPP COMPILER
#####################################################
INCLUDE_DIRECTORIES(headers 
					${Qt5Core_INCLUDE_DIRS})

ADD_DEFINITIONS(-DQT_PLUGIN)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

find_package(Qt5 COMPONENTS 
				Quick 
				QuickControls2 
				Qml 
				Gui 
				Core 
				Charts
				Multimedia 
				WebEngine
				WebChannel
				CONFIG
				REQUIRED)

set(SRC_LIST src/main.cpp
	 		 resources/resources.qrc
	 		 src/utils/rand.cpp)

add_executable(AutoCenter  ${SRC_LIST})

target_link_libraries(AutoCenter 
						Qt5::Gui 
						Qt5::Quick 
						Qt5::QuickControls2 
						Qt5::Qml 
						Qt5::Charts
						Qt5::Core 
						Qt5::Multimedia
						Qt5::WebChannel 
						Qt5::WebEngine)


