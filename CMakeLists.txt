cmake_minimum_required(VERSION 3.15)
project(Rexis LANGUAGES C)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

# Add source files
file(GLOB_RECURSE SOURCES src/*.c)

add_executable(rexis ${SOURCES})

# Include directories
target_include_directories(rexis PRIVATE ${PROJECT_SOURCE_DIR}/include)

# Example: link libraries if needed
# target_link_libraries(rexis PRIVATE some_library)