import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // Flutter plugin must be last
    id("dev.flutter.flutter-gradle-plugin")
}

// Load keystore properties
val keystoreProperties = Properties()
val keystorePropertiesFile = file("../../key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
    // Debugging: Print the keyAlias to check if the properties are loaded
    println("Key Alias: ${keystoreProperties["keyAlias"]}")
} else {
    println("key.properties file not found!")
}

android {
    namespace = "com.example.wilayat_way_app"
    compileSdk = 35
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.wilayat_way_app"
        minSdk = 21
        targetSdk = 35
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"]?.toString() ?: throw GradleException("Missing keyAlias in key.properties")
            keyPassword = keystoreProperties["keyPassword"]?.toString() ?: throw GradleException("Missing keyPassword")
            storeFile = file(keystoreProperties["storeFile"]?.toString() ?: throw GradleException("Missing storeFile"))
            storePassword = keystoreProperties["storePassword"]?.toString() ?: throw GradleException("Missing storePassword")

        }
    }

    buildTypes {
        getByName("release") {
            isMinifyEnabled = true
            isShrinkResources = false
            signingConfig = signingConfigs.getByName("release")
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8")
    implementation ("com.google.firebase:firebase-messaging:23.1.2")
    implementation ("com.google.firebase:firebase-analytics")

}
