buildscript {
    val kotlinVersion = "2.1.0"

    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        classpath("com.android.tools.build:gradle:8.7.0")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlinVersion")
    }
}

allprojects {
    configurations.all {
        resolutionStrategy.eachDependency {
            if (requested.group == "org.jetbrains.kotlin") {
                useVersion("2.1.0")
                because("Ensure all modules use the same Kotlin version to avoid metadata mismatches")
            }
        }
    }
}



// Set root project build directory
rootProject.buildDir = file("../build")

// Configure subproject build directories
subprojects {
    afterEvaluate {
        buildDir = file("${rootProject.buildDir}/${project.name}")
    }
    project.evaluationDependsOn(":app")
}

// Register a clean task
tasks.register<Delete>("clean") {
    delete(rootProject.buildDir)
}
