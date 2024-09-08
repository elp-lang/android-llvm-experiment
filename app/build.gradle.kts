import com.android.build.gradle.internal.tasks.factory.dependsOn

plugins {
    alias(libs.plugins.android.application)
    alias(libs.plugins.kotlin.android)
}

tasks.register<Exec>("buildLLVMModule") {
    doFirst {
        println("Executing buildLLVMModule task")
        println("Current directory: ${project.projectDir}")
        commandLine(
            "llvm-as",
            "src/main/llvm/hello_world.ll",
            "-o",
            "build/intermediates/llvm/hello_world.bc"
        )
    }
}

tasks.register<Exec>("linkLLVMModule") {
    doFirst {
        dependsOn("buildLLVMModule")
        println("Linking LLVM")
        commandLine(
            "llvm-link",
            "build/intermediates/llvm/hello_world.bc",
            "-o",
            "build/intermediates/llvm/hello_world.o",
            "<path/to/android/libraries>"
        )
    }
}

android {
    namespace = "com.example.llvm_ir_test"
    compileSdk = 34

    afterEvaluate {
        tasks.withType(Exec::class.java).forEach {
            if (it.name != "buildLLVMModule" && it.name != "linkLLVMModule") {
                it.dependsOn("linkLLVMModule")
            }
        }
    }

    defaultConfig {
        applicationId = "com.example.llvm_ir_test"
        minSdk = 24
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"

        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
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
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }
    kotlinOptions {
        jvmTarget = "1.8"
    }
}

dependencies {
    implementation(libs.androidx.core.ktx)
    implementation(libs.androidx.appcompat)
    implementation(libs.material)
    testImplementation(libs.junit)
    androidTestImplementation(libs.androidx.junit)
    androidTestImplementation(libs.androidx.espresso.core)
}