ExternalProject_Add(
  mpv
  DEPENDS curl
          ffmpeg
          fribidi
          lcms2
          libass
          libiconv
          libjpeg
          libplacebo
          libpng
          #sdl2
          luajit
          #mujs
          #rubberband
          shaderc
          spirv-cross
          uchardet
          vulkan-loader
          winrt-headers
  GIT_REPOSITORY https://github.com/mpv-player/mpv.git
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND
    ${EXEC} meson setup --reconfigure <BINARY_DIR> <SOURCE_DIR>
    ${meson_conf_args}
    -Db_lto_mode=thin
    -Db_ndebug=true
    -Dlibmpv=false
    -Dtests=false
    -Dd3d11=enabled
    -Diconv=enabled
    #-Djavascript=enabled
    -Dcplugins=disabled
    -Dd3d9-hwaccel=disabled
    -Ddirect3d=disabled
    -Djpeg=enabled
    -Dlcms2=enabled
    -Dlibcurl=enabled
    -Dlua=enabled
    -Dmanpage-build=disabled
    #-Drubberband=enabled
    #-Dsdl2-audio=disabled
    #-Dsdl2-gamepad=enabled
    #-Dsdl2-video=disabled
    -Dshaderc=enabled
    -Dspirv-cross=enabled
    -Duchardet=enabled
    -Dvulkan=enabled
    -Dwin32-smtc=enabled
    -Dwin32-subsystem=console
    -Dwin32-threads=enabled
    -Dzimg=enabled
    -Dzlib=enabled
  BUILD_COMMAND ${NINJA} -C <BINARY_DIR>
  INSTALL_COMMAND ""
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1)

ExternalProject_Add_Step(
  mpv strip-binary
  DEPENDEES build
  COMMAND
    ${EXEC} x86_64-w64-mingw32-strip -s
    <BINARY_DIR>/mpv.exe

ExternalProject_Add_Step(
  mpv copy-binary
  DEPENDEES strip-binary
  COMMAND
    ${CMAKE_COMMAND} -E copy
    <BINARY_DIR>/mpv.exe
    ${CMAKE_CURRENT_BINARY_DIR}/mpv-package/mpv.exe

force_rebuild_git(mpv)
force_meson_configure(mpv)
