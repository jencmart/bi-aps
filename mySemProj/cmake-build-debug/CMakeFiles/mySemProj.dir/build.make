# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.8

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /opt/clion-2017.2.2/bin/cmake/bin/cmake

# The command to remove a file.
RM = /opt/clion-2017.2.2/bin/cmake/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/jencmart/Dropbox/development/ClionProjects/aps/mySemProj

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/jencmart/Dropbox/development/ClionProjects/aps/mySemProj/cmake-build-debug

# Include any dependencies generated for this target.
include CMakeFiles/mySemProj.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/mySemProj.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/mySemProj.dir/flags.make

CMakeFiles/mySemProj.dir/main.cpp.o: CMakeFiles/mySemProj.dir/flags.make
CMakeFiles/mySemProj.dir/main.cpp.o: ../main.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/jencmart/Dropbox/development/ClionProjects/aps/mySemProj/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/mySemProj.dir/main.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/mySemProj.dir/main.cpp.o -c /home/jencmart/Dropbox/development/ClionProjects/aps/mySemProj/main.cpp

CMakeFiles/mySemProj.dir/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/mySemProj.dir/main.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/jencmart/Dropbox/development/ClionProjects/aps/mySemProj/main.cpp > CMakeFiles/mySemProj.dir/main.cpp.i

CMakeFiles/mySemProj.dir/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/mySemProj.dir/main.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/jencmart/Dropbox/development/ClionProjects/aps/mySemProj/main.cpp -o CMakeFiles/mySemProj.dir/main.cpp.s

CMakeFiles/mySemProj.dir/main.cpp.o.requires:

.PHONY : CMakeFiles/mySemProj.dir/main.cpp.o.requires

CMakeFiles/mySemProj.dir/main.cpp.o.provides: CMakeFiles/mySemProj.dir/main.cpp.o.requires
	$(MAKE) -f CMakeFiles/mySemProj.dir/build.make CMakeFiles/mySemProj.dir/main.cpp.o.provides.build
.PHONY : CMakeFiles/mySemProj.dir/main.cpp.o.provides

CMakeFiles/mySemProj.dir/main.cpp.o.provides.build: CMakeFiles/mySemProj.dir/main.cpp.o


# Object files for target mySemProj
mySemProj_OBJECTS = \
"CMakeFiles/mySemProj.dir/main.cpp.o"

# External object files for target mySemProj
mySemProj_EXTERNAL_OBJECTS =

mySemProj: CMakeFiles/mySemProj.dir/main.cpp.o
mySemProj: CMakeFiles/mySemProj.dir/build.make
mySemProj: CMakeFiles/mySemProj.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/jencmart/Dropbox/development/ClionProjects/aps/mySemProj/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable mySemProj"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/mySemProj.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/mySemProj.dir/build: mySemProj

.PHONY : CMakeFiles/mySemProj.dir/build

CMakeFiles/mySemProj.dir/requires: CMakeFiles/mySemProj.dir/main.cpp.o.requires

.PHONY : CMakeFiles/mySemProj.dir/requires

CMakeFiles/mySemProj.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/mySemProj.dir/cmake_clean.cmake
.PHONY : CMakeFiles/mySemProj.dir/clean

CMakeFiles/mySemProj.dir/depend:
	cd /home/jencmart/Dropbox/development/ClionProjects/aps/mySemProj/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/jencmart/Dropbox/development/ClionProjects/aps/mySemProj /home/jencmart/Dropbox/development/ClionProjects/aps/mySemProj /home/jencmart/Dropbox/development/ClionProjects/aps/mySemProj/cmake-build-debug /home/jencmart/Dropbox/development/ClionProjects/aps/mySemProj/cmake-build-debug /home/jencmart/Dropbox/development/ClionProjects/aps/mySemProj/cmake-build-debug/CMakeFiles/mySemProj.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/mySemProj.dir/depend

