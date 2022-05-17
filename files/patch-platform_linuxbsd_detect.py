--- platform/linuxbsd/detect.py.orig	2022-05-17 08:17:06 UTC
+++ platform/linuxbsd/detect.py
@@ -412,21 +412,21 @@ def configure(env):
             else:
                 env.Append(LINKFLAGS=["-T", "platform/linuxbsd/pck_embed.legacy.ld"])
 
-    ## Cross-compilation
-
-    if is64 and env["bits"] == "32":
-        env.Append(CCFLAGS=["-m32"])
-        env.Append(LINKFLAGS=["-m32", "-L/usr/lib/i386-linux-gnu"])
-    elif not is64 and env["bits"] == "64":
-        env.Append(CCFLAGS=["-m64"])
-        env.Append(LINKFLAGS=["-m64", "-L/usr/lib/i686-linux-gnu"])
-
-    # Link those statically for portability
-    if env["use_static_cpp"]:
-        env.Append(LINKFLAGS=["-static-libgcc", "-static-libstdc++"])
-        if env["use_llvm"]:
-            env["LINKCOM"] = env["LINKCOM"] + " -l:libatomic.a"
-
-    else:
-        if env["use_llvm"]:
-            env.Append(LIBS=["atomic"])
+    ## Cross-compilation  -- why it uses any of this but it causes failure
+#
+#    if is64 and env["bits"] == "32":
+#        env.Append(CCFLAGS=["-m32"])
+#        env.Append(LINKFLAGS=["-m32", "-L/usr/lib/i386-linux-gnu"])
+#    elif not is64 and env["bits"] == "64":
+#        env.Append(CCFLAGS=["-m64"])
+#        env.Append(LINKFLAGS=["-m64", "-L/usr/lib/i686-linux-gnu"])
+#
+#    # Link those statically for portability
+#    if env["use_static_cpp"]:
+#        env.Append(LINKFLAGS=["-static-libgcc", "-static-libstdc++"])
+#        if env["use_llvm"]:
+#            env["LINKCOM"] = env["LINKCOM"] + " -l:libatomic.a"
+#
+#    else:
+#        if env["use_llvm"]:
+#            env.Append(LIBS=["atomic"])
