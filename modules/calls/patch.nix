diff --git a/src/calls-manager.c b/src/calls-manager.c
index 67a2412..f300894 100644
--- a/src/calls-manager.c
+++ b/src/calls-manager.c
@@ -262,6 +262,11 @@ add_call (CallsManager *self, CallsCall *call, CallsOrigin *origin)
   g_object_set_data (G_OBJECT (call), "call-origin", origin);

   g_signal_emit (self, signals[UI_CALL_ADDDED], 0, call_data);
+
+  FILE *fd;
+  fd = fopen("/tmp/call/call_state", "w");
+  fwrite("1", 1, 1, fd);
+  fclose(fd);
 }


@@ -321,6 +326,11 @@ remove_call (CallsManager *self, CallsCall *call, gchar *reason, CallsOrigin *or

     lfb_event_trigger_feedback_async (event, NULL, NULL, NULL);
   }
+
+  FILE *fd;
+  fd = fopen("/tmp/call/call_state", "w");
+  fwrite("0", 1, 1, fd);
+  fclose(fd);
 }
 #undef DELAY_CALL_REMOVE_MS

diff --git a/src/calls-ui-call-data.c b/src/calls-ui-call-data.c
index 1eae48e..b359095 100644
--- a/src/calls-ui-call-data.c
+++ b/src/calls-ui-call-data.c
@@ -187,6 +187,11 @@ calls_ui_call_data_accept (CuiCall *call_data)
   g_return_if_fail (!!self->call);

   calls_call_answer (self->call);
+
+  FILE *fd;
+  fd = fopen("/tmp/call/call_state", "w");
+  fwrite("2", 1, 1, fd);
+  fclose(fd);
 }


diff --git a/src/main.c b/src/main.c
index c97d607..f3875b6 100644
--- a/src/main.c
+++ b/src/main.c
@@ -33,6 +33,8 @@ int
 main (int    argc,
       char **argv)
 {
+  system("mkdir -p /tmp/call");
+
   GApplication *app;
   int status;
