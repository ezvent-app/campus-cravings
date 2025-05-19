-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivity$g
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$Args
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$Error
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningEphemeralKeyProvider


# Stripe rules
-dontwarn com.stripe.android.**
-dontwarn androidx.window.**
-dontwarn androidx.work.**

# Keep Stripe classes
-keep class com.stripe.android.** { *; }
-keep class com.reactnativestripesdk.** { *; }

# Keep WorkManager classes
-keep class androidx.work.** { *; }
-keep class androidx.window.** { *; }

# CameraX + camera_android_camerax reflection-related rules
-keep class androidx.camera.** { *; }
-keep interface androidx.camera.** { *; }

# Needed to avoid Enum reflection crash
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# Flutter plugin registrant
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.embedding.engine.FlutterEngine { *; }

# Prevent stripping classes used via JNI/Reflection in CameraX
-keep class androidx.lifecycle.** { *; }
-keep class androidx.core.content.ContextCompat { *; }

