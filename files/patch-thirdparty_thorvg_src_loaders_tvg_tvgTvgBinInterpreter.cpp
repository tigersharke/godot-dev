--- thirdparty/thorvg/src/loaders/tvg/tvgTvgBinInterpreter.cpp.orig	2022-05-16 22:19:11 UTC
+++ thirdparty/thorvg/src/loaders/tvg/tvgTvgBinInterpreter.cpp
@@ -23,6 +23,8 @@
 
 #ifdef _WIN32
     #include <malloc.h>
+#elif __FreeBSD__
+    #include<stdlib.h>
 #else
     #include <alloca.h>
 #endif
