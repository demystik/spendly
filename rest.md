Before APK, one correction:

For the Play Store in 2026, you should publish an **AAB (Android App Bundle)**, not APK.

Google Play prefers:

```txt id="v6n9xk"
.aab
```

because it optimizes app size per device.

You can still generate APK for testing or sharing with friends.

---

# Step 1: Update version

In `pubspec.yaml`

Example:

```yaml id="h3m7qp"
version: 1.0.0+1
```

Meaning:

```txt id="p8x2wr"
1.0.0 → app version
+1 → build number
```

Every Play Store update:

```txt id="t4q9zn"
1.0.0+1
1.0.1+2
1.1.0+3
```

---

# Step 2: Build release APK (testing)

Run:

```bash id="v7m2pk"
flutter build apk --release
```

After build completes:

Find file here:

```txt id="k9x4qp"
build/app/outputs/flutter-apk/app-release.apk
```

Install it on phone.

Test EVERYTHING:

```txt id="q6p8mn"
login
logout
delete account
Firestore sync
expenses
routing
internet failure
```

---

# Step 3: Build App Bundle (Play Store)

Run:

```bash id="u3n9xm"
flutter build appbundle --release
```

Output:

```txt id="z2m8qp"
build/app/outputs/bundle/release/app-release.aab
```

This is what you upload to Play Console.

---

# Step 4: Create signing key (IMPORTANT)

Without signing, you’re not production-ready.

Open terminal in project:

### Windows:

```bash id="x8m2wr"
keytool -genkey -v ^
-keystore upload-keystore.jks ^
-keyalg RSA ^
-keysize 2048 ^
-validity 10000 ^
-alias upload
```

It will ask:

```txt id="g5n7qp"
password
name
organization
country code
```

Save the `.jks` safely.

Do NOT lose it.

Losing keystore = pain.

You may not be able to update your app later.

Move it here:

```txt id="j4m9pk"
android/app/upload-keystore.jks
```

---

# Step 5: Create `key.properties`

In `/android`

Create:

```txt id="n2x8wr"
key.properties
```

Add:

```properties id="w7q3mn"
storePassword=yourpassword
keyPassword=yourpassword
keyAlias=upload
storeFile=../app/upload-keystore.jks
```

---

# Step 6: Configure signing

Open:

```txt id="k6m2xp"
android/app/build.gradle.kts
```

(or `build.gradle` if Groovy)

Add signing config.

If you're using Kotlin DSL (`.kts`), tell me — setup differs slightly.

---

# Step 7: Optimize release

In:

```txt id="y8q4pn"
android/app/build.gradle
```

Enable shrinking:

```gradle id="r3m7xt"
buildTypes {
    release {
        minifyEnabled true
        shrinkResources true
    }
}
```

Smaller app size.

---

# Step 8: Test release mode

Never trust debug build.

Run:

```bash id="m9x2wr"
flutter run --release
```

Why?

Debug hides many issues.

Common release-only bugs:

```txt id="f7n4pk"
Firebase config
Proguard
crashes
permissions
routing
```

---

# Spendly pre-publish checklist

Before Play Store:

### Must have

✅ Privacy Policy
✅ Terms of Service
✅ Delete Account
✅ Logout
✅ App icon
✅ Native splash
✅ Proper Firebase rules
✅ Release build tested
✅ No debug prints
✅ Real screenshots

### Strongly recommended

✅ Offline handling
✅ Error messages
✅ Empty states
✅ Loading states

---

Your command for now:

### Test APK

```bash id="v1q9mn"
flutter build apk --release
```

### Play Store build

```bash id="s5m2xp"
flutter build appbundle --release
```

Use APK for testing.

Use AAB for publishing.
