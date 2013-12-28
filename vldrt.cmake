if(WIN32)
  if(MSVC12)
    set(vcver _vc12)
  else()
    set(vcver)
  endif()
  if(${CMAKE_GENERATOR} MATCHES "Win64$")
    set(lib_DIR ${externpro_DIR}/lib64)
    set(dll_suffix "${vcver}_x64")
  else()
    set(lib_DIR ${externpro_DIR}/lib32)
    set(dll_suffix "${vcver}_x86")
  endif()
  set(vld_runtime
    debug ${externpro_DIR}/include/visualleakdetector/vld.ini
    debug ${lib_DIR}/dbghelp.dll
    debug ${lib_DIR}/Microsoft.DTfW.DHL.manifest
    debug ${lib_DIR}/vld${dll_suffix}.dll
    )
else()
  set(vld_runtime)
endif()
