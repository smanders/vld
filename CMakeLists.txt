cmake_minimum_required(VERSION 2.8.9)
project(vld)
include(flags OPTIONAL)
set(lib_name ${PROJECT_NAME})
if(MSVC)
  #######################################
  # preprocessor
  add_definitions(
    -D_USRDLL
    -D_WIN32_WINNT=0x0502
    -D_UNICODE
    -DUNICODE
    )
  #######################################
  # Flags
  ####################
  # C/C++ > General
  # Debug Information Format: C7 compatible (/Z7)
  # Warning Level: Level1 (/W1)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /Z7 /W1")
  ####################
  # C/C++ > Optimization
  # Optimization: Full Optimization (/Ox)
  # Favor Size Or Speed: Favor fast code (/Ot)
  # Enable Fiber-Safe Optimizations: Yes (/GT)
  # Whole Program Optimization: Yes (/GL)
  string(REGEX REPLACE "/O2" "/Ox" CMAKE_CXX_FLAGS_RELEASE ${CMAKE_CXX_FLAGS_RELEASE})
  set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /Ot /GT /GL")
  ####################
  # C/C++ > Code Generation
  # Enable String Pooling: Yes (/GF)
  # Buffer Security Check: No (/GS-)
  # Enable Function-Level Linking: No (/Gy-)
  # Floating Point Model: Fast (/fp:fast)
  set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /GF /GS- /Gy- /fp:fast")
  ####################
  # General
  # Whole Program Optimization: Use Link Time Code Generation
  #set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} /LTCG")
  ####################
  # Linker > Debugging
  # Generate Debug Info: Yes (/DEBUG)
  set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} /DEBUG")
  ####################
  # Linker > System
  # SubSystem: Not Set
  #string(REPLACE "/SUBSYSTEM:CONSOLE" "" CMAKE_SHARED_LINKER_FLAGS ${CMAKE_SHARED_LINKER_FLAGS})
  ####################
  # Linker > Optimization
  # References: Yes (/OPT:REF)
  # Enable COMDAT Folding: Yes (/OPT:ICF)
  set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} /OPT:REF /OPT:ICF")
  ####################
  # Linker > Advanced
  # Base Address: 0x03200000
  # Randomized Base Address: No (/DYNAMICBASE:NO)
  set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} /BASE:\"0x03200000\" /DYNAMICBASE:NO")
endif(MSVC)
#######################################
# include directories
include_directories(
  ${CMAKE_CURRENT_SOURCE_DIR}/setup
  )
#######################################
# library sources
set(${lib_name}_libsrcs
  callstack.cpp
  callstack.h
  criticalsection.h
  crtmfcpatch.h
  dllspatches.cpp
  map.h
  ntapi.cpp
  ntapi.h
  resource.h
  set.h
  stdafx.cpp
  stdafx.h
  tree.h
  utility.cpp
  utility.h
  setup/version.h
  vld.cpp
  vld.h
  vld.rc
  vld_def.h
  vld_hooks.cpp
  vldapi.cpp
  vldheap.cpp
  vldheap.h
  vldint.h
  )
#######################################
# library
if(MSVC)
  add_library(${lib_name} SHARED ${${lib_name}_libsrcs})
#  if(${CMAKE_GENERATOR} MATCHES "Win64$")
#    set_target_properties(${lib_name} PROPERTIES OUTPUT_NAME ${lib_name}_x64)
#  else()
#    set_target_properties(${lib_name} PROPERTIES OUTPUT_NAME ${lib_name}_x86)
#  endif()
endif()
#######################################
# install
if(${CMAKE_GENERATOR} MATCHES "Win64$")
  set(dbghelp setup/dbghelp/x64/dbghelp.dll)
  set(manifest setup/dbghelp/x64/Microsoft.DTfW.DHL.manifest) #vld.dll.dependency.x64.manifest
else()
  set(dbghelp setup/dbghelp/x86/dbghelp.dll)
  set(manifest setup/dbghelp/x86/Microsoft.DTfW.DHL.manifest) # vld.dll.dependency.x86.manifest
endif()
if(MSVC)
  install(TARGETS ${lib_name}
    RUNTIME DESTINATION lib${NUMBITS}
    LIBRARY DESTINATION lib${NUMBITS}
    ARCHIVE DESTINATION lib${NUMBITS}
    )
  install(PROGRAMS ${dbghelp} DESTINATION lib${NUMBITS})
  install(FILES ${manifest} DESTINATION lib${NUMBITS})
  install(FILES vld.h vld_def.h DESTINATION include/visualleakdetector)
endif()