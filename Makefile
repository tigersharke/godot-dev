PORTNAME=	godot
DISTVERSION=	g20220305
CATEGORIES=	games
PKGNAMESUFFIX=	-dev
DISTNAME=	${PORTNAME}-${GH_TAGNAME}
DIST_SUBDIR=	${PORTNAME}${PKGNAMESUFFIX}

MAINTAINER=	nope@nothere
COMMENT=	Multi-platform 2D and 3D game engine

LICENSE=                MIT CC-BY-3.0
LICENSE_COMB=           multi

BUILD_DEPENDS=  yasm:devel/yasm
LIB_DEPENDS=    libfreetype.so:print/freetype2 \
                libpcre2-8.so:devel/pcre2 \
                libpng.so:graphics/png \
                libvpx.so:multimedia/libvpx
RUN_DEPENDS=    xdg-user-dir:devel/xdg-user-dirs \
                xdg-open:devel/xdg-utils \
                xmessage:x11/xmessage
USES=		compiler:c++17-lang cpe gl pkgconfig python:3.5+ scons xorg

USE_XORG=       x11 xcursor xext xi xinerama xrandr xrender
USE_GL=         gl glew glu

CXXFLAGS+=	-Wno-error=unused-command-line-argument
#-Wunused-command-line-argument
# -Wno-error=foo: Turn warning "foo" into an warning even if -Werror is specified.

CONFLICTS=	godot

USE_GITHUB=     nodefault
GH_ACCOUNT=     godotengine
GH_PROJECT=     godot
GH_TAGNAME=	dc361d32014c3eab0b80a8422d1f850f854b7532

#MAKE_ARGS+=             platform=linuxbsd tools=false target=release bits=64 verbose=yes use_llvm=yes use_clang=yes \
MAKE_ARGS+=             platform=linuxbsd target=release_debug bits=64 verbose=yes use_llvm=yes use_lld=yes \
			builtin_freetype=no builtin_libpng=no builtin_libvpx=no builtin_pcre2=no builtin_zlib=no
#			module_openxr_enabled=no module_tinyexr_enabled=no module_svg_enabled=no module_tga_enabled=no

WRKSRC=	${WRKDIR}/${PORTNAME}-${GH_TAGNAME}

# option MONO doesn't build (needs 5.12+) so for now leave it out as an option
OPTIONS_DEFINE=         EXAMPLES TOOLS UDEV
#OPTIONS_DEFAULT=        ALSA UDEV
OPTIONS_DEFAULT=        UDEV
# Moved to devel/godot-tools
OPTIONS_EXCLUDE?=       EXAMPLES TOOLS
OPTIONS_GROUP=          AUDIO
OPTIONS_GROUP_AUDIO=    ALSA PULSEAUDIO

AUDIO_DESC=             Audio support
ALSA_LIB_DEPENDS=       libasound.so:audio/alsa-lib
ALSA_MAKE_ARGS=         alsa=True
ALSA_MAKE_ARGS_OFF=     alsa=False

# tagged 6/11/21 for 3.4
EXAMPLES_GH_TUPLE=      godotengine:godot-demo-projects:585455e67ca3:DEMOS
EXAMPLES_PORTEXAMPLES=  *

# mono support doesn't build at present
MONO_BUILD_DEPENDS=     msbuild:devel/msbuild
MONO_LIB_DEPENDS=       libinotify.so:devel/libinotify
MONO_GH_TUPLE=          mono:nuget-binary:ebedbf8:NUGT/nuget-binary
MONO_MAKE_ARGS=         module_mono_enabled=yes mono_glue=True
MONO_USES=              gettext-runtime mono:nuget

NUGET_DEPENDS=          DotNet.Glob=2.1.1

PULSEAUDIO_LIB_DEPENDS= libpulse.so:audio/pulseaudio
PULSEAUDIO_MAKE_ARGS=   pulseaudio=True
PULSEAUDIO_MAKE_ARGS_OFF=       pulseaudio=False

TOOLS_DESC=             Include development tools (IDE)
TOOLS_MAKE_ARGS=        target=release_debug tools=True
TOOLS_MAKE_ARGS_OFF=    target=release tools=False
TOOLS_DESKTOP_ENTRIES=  "Godot" "${COMMENT}" "${GODOTFILE}" \
                        "${GODOTFILE}" "Development;IDE;" ""
TOOLS_PLIST_FILES=      share/pixmaps/${GODOTFILE}.png \
                        share/pixmaps/${GODOTFILE}.svg
UDEV_DESC=              Libudev support (Joystick)
UDEV_BUILD_DEPENDS=     ${PREFIX}/include/linux/input.h:devel/evdev-proto
UDEV_LIB_DEPENDS=       libudev.so:devel/libudev-devd
UDEV_MAKE_ARGS=         udev=True
UDEV_MAKE_ARGS_OFF=     udev=False

GODOTFILE=              ${PORTNAME}${PKGNAMESUFFIX}
PLIST_FILES=            bin/${GODOTFILE}

# This works --except-- it quits with an error via clang that is not actually a fatal error but more a warning made fatal.
# The build does seem to succeed otherwise.

.include <bsd.port.options.mk>

.include <bsd.port.mk>
