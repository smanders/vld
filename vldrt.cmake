if(WIN32)
  if(${CMAKE_GENERATOR} MATCHES "Win64$")
    set(vld_DIR ${externpro_DIR}/lib64)
    set(dll_suffix "_x64")
  else()
    set(vld_DIR ${externpro_DIR}/lib32)
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
