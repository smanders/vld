if(WIN32)
  set(vld_DIR ${externpro_DIR}/lib)
  if(${CMAKE_GENERATOR} MATCHES "Win64$")
    set(dll_suffix "_x64")
  else()
    set(dll_suffix "_x86")
  endif()
  set(vld_runtime
    debug ${externpro_DIR}/include/visualleakdetector/vld.ini
    debug ${vld_DIR}/dbghelp.dll
    debug ${vld_DIR}/Microsoft.DTfW.DHL.manifest
    debug ${vld_DIR}/vld${dll_suffix}.dll
    )
else()
  set(vld_runtime)
endif()
