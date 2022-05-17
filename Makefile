PORTNAME=	godot
DISTVERSION=	g20220516
CATEGORIES=	games
PKGNAMESUFFIX=	-dev
DISTNAME=	${PORTNAME}-${GH_TAGNAME}
DIST_SUBDIR=	${PORTNAME}${PKGNAMESUFFIX}

MAINTAINER=	nope@nothere
COMMENT=	Multi-platform 2D and 3D game engine

LICENSE=                MIT CC-BY-3.0
LICENSE_COMB=           multi

BUILD_DEPENDS=	yasm:devel/yasm
LIB_DEPENDS=	libfreetype.so:print/freetype2 \
		libpcre2-8.so:devel/pcre2 \
		libpng.so:graphics/png \
		libvpx.so:multimedia/libvpx
# ------------> need to add libthorvg
RUN_DEPENDS=	xdg-user-dir:devel/xdg-user-dirs \
		xdg-open:devel/xdg-utils \
		xmessage:x11/xmessage

USES=		compiler:c++17-lang cpe gl pkgconfig python:3.5+ scons xorg

USE_XORG=       x11 xcursor xext xi xinerama xrandr xrender
USE_GL=         gl glew glu

CXXFLAGS+=	-Wno-error=unused-command-line-argument

CONFLICTS=	godot

USE_GITHUB=     nodefault
GH_ACCOUNT=     godotengine
GH_PROJECT=     godot
GH_TAGNAME=	b154f445d59f5a6b332311890569fda689fe480b

MAKE_ARGS+=             platform=linuxbsd target=release_debug verbose=yes use_llvm=yes use_lld=yes \
			builtin_freetype=no builtin_libpng=no builtin_libvpx=no builtin_pcre2=no builtin_zlib=no \
			tools=no use_static_cpp=no module_openxr_enabled=no module_tinyexr_enabled=no \
			module_tvg_enabled=no werror=no

WRKSRC=	${WRKDIR}/${PORTNAME}-${GH_TAGNAME}

# These options from the devel/godot need to be setup along with opening up
# the ability for consumers of this Makefile to choose bundled items over ports as desired.
#
# option MONO doesn't build (needs 5.12+) so for now leave it out as an option
#OPTIONS_DEFINE=         EXAMPLES TOOLS UDEV
##OPTIONS_DEFAULT=        ALSA UDEV
#OPTIONS_DEFAULT=        UDEV
## Moved to devel/godot-tools
#OPTIONS_EXCLUDE?=       EXAMPLES TOOLS
#OPTIONS_GROUP=          AUDIO
#OPTIONS_GROUP_AUDIO=    ALSA PULSEAUDIO
#
#AUDIO_DESC=             Audio support
#ALSA_LIB_DEPENDS=       libasound.so:audio/alsa-lib
#ALSA_MAKE_ARGS=         alsa=True
#ALSA_MAKE_ARGS_OFF=     alsa=False
#
## tagged 6/11/21 for 3.4
#EXAMPLES_GH_TUPLE=      godotengine:godot-demo-projects:585455e67ca3:DEMOS
#EXAMPLES_PORTEXAMPLES=  *
#
## mono support doesn't build at present
#MONO_BUILD_DEPENDS=     msbuild:devel/msbuild
#MONO_LIB_DEPENDS=       libinotify.so:devel/libinotify
#MONO_GH_TUPLE=          mono:nuget-binary:ebedbf8:NUGT/nuget-binary
#MONO_MAKE_ARGS=         module_mono_enabled=yes mono_glue=True
#MONO_USES=              gettext-runtime mono:nuget
#
#NUGET_DEPENDS=          DotNet.Glob=2.1.1
#
#PULSEAUDIO_LIB_DEPENDS= libpulse.so:audio/pulseaudio
#PULSEAUDIO_MAKE_ARGS=   pulseaudio=True
#PULSEAUDIO_MAKE_ARGS_OFF=       pulseaudio=False
#
#TOOLS_DESC=             Include development tools (IDE)
#TOOLS_MAKE_ARGS=        target=release_debug tools=True
#TOOLS_MAKE_ARGS_OFF=    target=release tools=False
#TOOLS_DESKTOP_ENTRIES=  "Godot" "${COMMENT}" "${GODOTFILE}" \
#                        "${GODOTFILE}" "Development;IDE;" ""
#TOOLS_PLIST_FILES=      share/pixmaps/${GODOTFILE}.png \
#                        share/pixmaps/${GODOTFILE}.svg
#UDEV_DESC=              Libudev support (Joystick)
#UDEV_BUILD_DEPENDS=     ${PREFIX}/include/linux/input.h:devel/evdev-proto
#UDEV_LIB_DEPENDS=       libudev.so:devel/libudev-devd
#UDEV_MAKE_ARGS=         udev=True
#UDEV_MAKE_ARGS_OFF=     udev=False

GODOTFILE=              ${PORTNAME}${PKGNAMESUFFIX}
PLIST_FILES=            bin/${GODOTFILE}

# The alloca.h issue is fixed but I need to apply a similar patch on two other files until upstream catches adds them.
#
# clang++ -o scene/gui/texture_rect.linuxbsd.opt.debug.64.llvm.o -c -std=gnu++17 -O2 -pipe -fstack-protector-strong -fno-strict-aliasing
# -Wno-error=unused-command-line-argument -g2 -O2 -fstack-protector-strong -fno-strict-aliasing -pipe -pthread -Wall
# -Wno-ordered-compare-function-pointers -DDEBUG_ENABLED -DNO_EDITOR_SPLASH -D_THREAD_SAFE -DTOUCH_ENABLED -DALSA_ENABLED
# -DALSAMIDI_ENABLED -DDBUS_ENABLED -DX11_ENABLED -DUNIX_ENABLED -D_FILE_OFFSET_BITS=64 -DVULKAN_ENABLED -DGLES3_ENABLED
# -DMINIZIP_ENABLED -DZSTD_STATIC_LINKING_ONLY -DUSE_VOLK -DVK_USE_PLATFORM_XLIB_KHR -DGLAD_ENABLED -DGLES_OVER_GL
# -Ithirdparty/freetype/include -Ithirdparty/libpng -Ithirdparty/glad -Ithirdparty/volk -Ithirdparty/vulkan -Ithirdparty/vulkan/include
# -Ithirdparty/zstd -Ithirdparty/zlib -Iplatform/linuxbsd -I. -I/usr/local/include -I/usr/local/include/dbus-1.0 -I/usr/local/lib/dbus-1.0/include

#.include <bsd.port.options.mk>

.include <bsd.port.mk>
