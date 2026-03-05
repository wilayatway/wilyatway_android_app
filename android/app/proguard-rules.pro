# Keep Flutter's internal classes
-keep class io.flutter.** { *; }
-dontwarn io.flutter.**

# Keep Flutter plugin classes
-keep class io.flutter.plugins.** { *; }

# Keep app-related classes
-keep class com.wilayat_way_app.** { *; }
-dontwarn com.wilayat_way_app.**

# Prevent obfuscation of the youtube player library
-keep class com.pierfrancescosoffritti.androidyoutubeplayer.** { *; }
