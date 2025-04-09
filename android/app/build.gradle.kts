plugins {
    id("com.android.application")
    id("kotlin-android")
    id("com.google.gms.google-services")  // Google services plugin
    id("dev.flutter.flutter-gradle-plugin")  // Flutter Gradle plugin
}

android {
    namespace = "com.mycompany.CloudMessaging"  // Replace with your actual package name
    compileSdk = 34  // Use the latest stable version

    defaultConfig {
        applicationId = "com.mycompany.CloudMessaging"  // Replace with your actual application ID
        minSdk = 21  // Minimum SDK version your app supports
        targetSdk = 34  // Target SDK version
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }
}

dependencies {
    implementation("org.jetbrains.kotlin:kotlin-stdlib:1.9.23")  // Use the latest stable version

    // Import the Firebase BoM
    implementation(platform("com.google.firebase:firebase-bom:33.12.0"))  // Check for the latest version

    // Add the dependencies for Firebase products you want to use
    implementation("com.google.firebase:firebase-core")
    implementation("com.google.firebase:firebase-messaging")

    // Add the dependency for the flutter_local_notifications plugin
    implementation("com.dexterous.flutterlocalnotifications:flutter_local_notifications:12.0.4")  // Check for the latest version
}

