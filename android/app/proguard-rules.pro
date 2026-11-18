# Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.plugins.** { *; }

# Google Mobile Ads
-keepattributes *Annotation*
-keepattributes Obfuscation
-keepattributes InnerClasses
-keepattributes Signature
-keep public class com.google.android.gms.ads.** {
   public *;
 }

# Flutter Local Notifications & Timezone
-keep class com.dexterous.flutterlocalnotifications.** { *; }
-dontwarn com.dexterous.flutterlocalnotifications.**
-keep class timezone.** { *; }
-dontwarn timezone.**

# Audioplayers
-keep class xyz.luan.audioplayers.** { *; }

# SharedPreferences & PathProvider
-keep class io.flutter.plugins.sharedpreferences.** { *; }
-keep class io.flutter.plugins.pathprovider.** { *; }

# Google Play Core / Feature Delivery (Optional Flutter Embedding references)
-dontwarn com.google.android.play.core.**
-keep class com.google.android.play.core.** { *; }

# General ProGuard Keep Rules
-keepattributes *Annotation*,Signature
-dontwarn sun.misc.**
-keep class sun.misc.* { *; }
