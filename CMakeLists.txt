cmake_minimum_required(VERSION 3.0)
project(vld)
if(CMAKE_CONFIGURATION_TYPES)
  set(CMAKE_CONFIGURATION_TYPES Release CACHE STRING
    "Set the configurations to what we need" FORCE)
endif()
include_external_msproject(vld ${CMAKE_CURRENT_SOURCE_DIR}/vld.vcxproj)
#######################################
# install
if(CMAKE_SIZEOF_VOID_P EQUAL 8) # 64-bit
  set(dbghelp setup/dbghelp/x64/dbghelp.dll)
  set(manifest setup/dbghelp/x64/Microsoft.DTfW.DHL.manifest)
  set(outdirlib bin/x64/Release/vld.lib)
  set(outdirdll bin/x64/Release/vld_x64.dll)
elseif(CMAKE_SIZEOF_VOID_P EQUAL 4) # 32-bit
  set(dbghelp setup/dbghelp/x86/dbghelp.dll)
  set(manifest setup/dbghelp/x86/Microsoft.DTfW.DHL.manifest)
  set(outdirlib bin/Win32/Release/vld.lib)
  set(outdirdll bin/Win32/Release/vld_x86.dll)
else()
  message(FATAL_ERROR "Unknown-bit, CMAKE_SIZEOF_VOID_P=${CMAKE_SIZEOF_VOID_P}")
endif()
if(MSVC)
  install(PROGRAMS ${dbghelp} ${outdirlib} ${outdirdll} DESTINATION lib)
  install(FILES ${manifest} DESTINATION lib)
endif()
install(FILES vld.h vld_def.h vld.ini DESTINATION include/visualleakdetector)
