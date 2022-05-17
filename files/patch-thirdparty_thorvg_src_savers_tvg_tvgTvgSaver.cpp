--- thirdparty/thorvg/src/savers/tvg/tvgTvgSaver.cpp.orig	2022-05-16 22:23:08 UTC
+++ thirdparty/thorvg/src/savers/tvg/tvgTvgSaver.cpp
@@ -28,6 +28,8 @@
 
 #ifdef _WIN32
     #include <malloc.h>
+#elif __FreeBSD__
+    #include<stdlib.h>
 #else
     #include <alloca.h>
 #endif
