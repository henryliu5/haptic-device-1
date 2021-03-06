if(PKG_USER-SMD)
  find_package(Eigen3 NO_MODULE)
  if(EIGEN3_FOUND)
    set(DOWNLOAD_EIGEN3_DEFAULT OFF)
  else()
    set(DOWNLOAD_EIGEN3_DEFAULT ON)
  endif()
  option(DOWNLOAD_EIGEN3 "Download Eigen3 instead of using an already installed one)" ${DOWNLOAD_EIGEN3_DEFAULT})
  if(DOWNLOAD_EIGEN3)
    message(STATUS "Eigen3 download requested - we will build our own")
    include(ExternalProject)
    ExternalProject_Add(Eigen3_build
      URL http://bitbucket.org/eigen/eigen/get/3.3.7.tar.gz
      URL_MD5 f2a417d083fe8ca4b8ed2bc613d20f07
      CONFIGURE_COMMAND "" BUILD_COMMAND "" INSTALL_COMMAND ""
    )
    ExternalProject_get_property(Eigen3_build SOURCE_DIR)
    set(EIGEN3_INCLUDE_DIR ${SOURCE_DIR})
    list(APPEND LAMMPS_DEPS Eigen3_build)
  else()
    find_package(Eigen3 NO_MODULE)
    mark_as_advanced(Eigen3_DIR)
    if(NOT EIGEN3_FOUND)
      message(FATAL_ERROR "Eigen3 not found, help CMake to find it by setting EIGEN3_INCLUDE_DIR, or set DOWNLOAD_EIGEN3=ON to download it")
    endif()
  endif()
  include_directories(${EIGEN3_INCLUDE_DIR})
endif()
