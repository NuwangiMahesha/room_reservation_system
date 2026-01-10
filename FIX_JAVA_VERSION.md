# 🔧 Fix: Java Version Compatibility Issue

## Problem
You have **Java 24** installed, but this project requires **Java 17** (LTS version). Maven's compiler plugin has compatibility issues with Java 24.

**Error:** `java.lang.ExceptionInInitializerError: com.sun.tools.javac.code.TypeTag :: UNKNOWN`

---

## ✅ Solution: Install Java 17

### Step 1: Download Java 17

**Option A: Oracle JDK 17 (Recommended)**
1. Go to: https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html
2. Download "Windows x64 Installer"
3. Run the installer
4. **Important:** During installation, note the installation path (e.g., `C:\Program Files\Java\jdk-17`)

**Option B: OpenJDK 17 (Free Alternative)**
1. Go to: https://adoptium.net/temurin/releases/?version=17
2. Select:
   - Operating System: Windows
   - Architecture: x64
   - Package Type: JDK
   - Version: 17 - LTS
3. Download and install

---

### Step 2: Set JAVA_HOME to Java 17

#### Method 1: Using Environment Variables (Permanent)

1. Press `Windows + R`, type `sysdm.cpl`, press Enter
2. Click "Advanced" tab → "Environment Variables"
3. Under "System variables", find `JAVA_HOME`:
   - If it exists, click "Edit"
   - If not, click "New"
4. Set the value to your Java 17 installation path:
   ```
   C:\Program Files\Java\jdk-17
   ```
5. Find `Path` in System variables, click "Edit"
6. Make sure `%JAVA_HOME%\bin` is at the TOP of the list
7. Click OK on all windows
8. **Restart your terminal/IDE**

#### Method 2: Using Command Line (Temporary - for current session)

Open a new terminal and run:
```cmd
set JAVA_HOME=C:\Program Files\Java\jdk-17
set PATH=%JAVA_HOME%\bin;%PATH%
```

---

### Step 3: Verify Java 17 is Active

Open a **NEW** terminal window and run:
```cmd
java -version
```

You should see:
```
java version "17.0.x"
```

Also verify Maven uses Java 17:
```cmd
mvn -version
```

Should show:
```
Java version: 17.0.x
```

---

### Step 4: Run Your Project

Now you can run the project:

```cmd
cd D:\room_reservation_system
mvn clean install -DskipTests
mvn spring-boot:run
```

Or double-click: `run-application.bat`

---

## 🎯 Alternative: Use Maven Toolchains (Advanced)

If you want to keep Java 24 as default but use Java 17 for this project:

### 1. Create toolchains.xml

Create file: `C:\Users\YOUR_USERNAME\.m2\toolchains.xml`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<toolchains>
  <toolchain>
    <type>jdk</type>
    <provides>
      <version>17</version>
    </provides>
    <configuration>
      <jdkHome>C:\Program Files\Java\jdk-17</jdkHome>
    </configuration>
  </toolchain>
  <toolchain>
    <type>jdk</type>
    <provides>
      <version>24</version>
    </provides>
    <configuration>
      <jdkHome>C:\Program Files\Java\jdk-24</jdkHome>
    </configuration>
  </toolchain>
</toolchains>
```

### 2. Add to pom.xml

Add this plugin to your `pom.xml` (I can do this for you):

```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-toolchains-plugin</artifactId>
    <version>3.1.0</version>
    <executions>
        <execution>
            <goals>
                <goal>toolchain</goal>
            </goals>
        </execution>
    </executions>
    <configuration>
        <toolchains>
            <jdk>
                <version>17</version>
            </jdk>
        </toolchains>
    </configuration>
</plugin>
```

---

## 🚀 Quick Start After Installing Java 17

1. **Install Java 17** (see Step 1 above)
2. **Set JAVA_HOME** to Java 17 path (see Step 2 above)
3. **Restart terminal/IDE**
4. **Verify:** `java -version` shows 17.x.x
5. **Run:** `mvn clean install -DskipTests`
6. **Start:** `mvn spring-boot:run`
7. **Access:** http://localhost:8080/swagger-ui.html

---

## ❓ Why Java 17?

- **LTS (Long Term Support)**: Supported until 2029
- **Spring Boot 3.x**: Officially supports Java 17+
- **Stability**: Mature and well-tested
- **Industry Standard**: Most enterprise projects use Java 17

Java 24 is too new and has compatibility issues with many tools and libraries.

---

## 📞 Still Having Issues?

After installing Java 17 and setting JAVA_HOME:

1. Close ALL terminal windows and IDE
2. Restart your computer
3. Open a NEW terminal
4. Run: `java -version` (should show 17.x.x)
5. Run: `mvn clean install -DskipTests`

If you still see errors, share the output and I'll help further!
