# Keep Flutter's internal classes
-keep class io.flutter.** { *; }
-dontwarn io.flutter.**

# Keep Flutter plugin classes
-keep class io.flutter.plugins.** { *; }

# Keep app-related classes
-keep class com.example.** { *; }
-dontwarn com.example.**

# Prevent obfuscation of the youtube player library
-keep class com.pierfrancescosoffritti.androidyoutubeplayer.** { *; }
