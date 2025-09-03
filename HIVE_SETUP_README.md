# Hive Authentication Setup Guide

## Issues Identified

1. **File Type in Hive**: The original `User` model used `File` type which is not compatible with Hive
2. **Missing Generated Files**: Hive requires generated adapter files that are missing
3. **Login Logic**: The login was navigating to Dashboard before checking authentication

## Solutions Implemented

### 1. Fixed User Model
- Created `SimpleUser` model that stores image path as `String` instead of `File`
- Added proper Hive annotations (`@HiveType`, `@HiveField`)

### 2. Created Authentication Service
- `SimpleAuthController` handles user storage and authentication
- Proper error handling and validation
- Clean separation of concerns

### 3. Fixed Login Flow
- Removed premature navigation to Dashboard
- Added proper authentication checks
- Better error messages for different failure scenarios

## Steps to Fix

### Step 1: Generate Hive Adapters
Run the following command to generate the required Hive adapter files:

```bash
flutter packages pub run build_runner build
```

This will generate:
- `lib/framework/repository/auth/model/simple_user.g.dart`
- Other required `.g.dart` files

### Step 2: Update Main.dart
The main.dart file has been updated to:
- Use `SimpleUser` instead of `User`
- Register the correct Hive adapters
- Open the correct Hive boxes

### Step 3: Test Authentication
Use the provided test files:
- `SimpleSignup` for user registration
- `SimpleLogin` for user authentication
- `HiveTest` for testing Hive functionality

## File Structure

```
lib/
├── framework/
│   ├── repository/auth/model/
│   │   ├── simple_user.dart          # Fixed user model
│   │   └── user.dart                 # Original model (has File type issue)
│   └── controllers/auth/
│       ├── simple_auth_controller.dart # Working auth controller
│       └── signup_controller.dart     # Original controller
├── ui/auth/mobile/
│   ├── simple_signup.dart            # Working signup screen
│   ├── simple_login.dart             # Working login screen
│   ├── signup/signup.dart            # Original signup (has File type issue)
│   └── login/login.dart              # Original login (has navigation issue)
└── test_hive.dart                    # Hive functionality test
```

## Usage

### Signup Process
1. User fills email, password, and selects image
2. Image path is stored as string (not File object)
3. User data is stored in Hive using `SimpleAuthController.addUser()`

### Login Process
1. User enters email and password
2. Credentials are validated using `SimpleAuthController.checkUser()`
3. On success, user is navigated to Dashboard
4. On failure, appropriate error message is shown

## Key Changes Made

1. **User Model**: Changed `File image` to `String imagePath`
2. **Authentication**: Centralized auth logic in `SimpleAuthController`
3. **Error Handling**: Added proper try-catch blocks and error messages
4. **Navigation**: Fixed premature navigation in login flow
5. **Hive Setup**: Updated main.dart with correct adapter registration

## Testing

After running `build_runner`, test the authentication flow:

1. Run the app
2. Navigate to SimpleSignup
3. Create a user account
4. Navigate to SimpleLogin
5. Login with the created credentials
6. Verify successful authentication

## Common Issues and Solutions

### Issue: "Target of URI hasn't been generated"
**Solution**: Run `flutter packages pub run build_runner build`

### Issue: "Hive.box not found"
**Solution**: Ensure Hive is properly initialized in main.dart

### Issue: "File type not supported"
**Solution**: Store file paths as strings, not File objects

### Issue: "Adapter not registered"
**Solution**: Register all Hive adapters before opening boxes

## Dependencies Required

Make sure these are in your `pubspec.yaml`:

```yaml
dependencies:
  hive: ^2.2.3
  hive_flutter: ^1.1.0

dev_dependencies:
  build_runner: ^2.5.4
  hive_generator: ^2.0.1
```

## Next Steps

1. Run `flutter packages pub get`
2. Run `flutter packages pub run build_runner build`
3. Test the authentication flow
4. Integrate with your existing dashboard/navigation
5. Add proper state management (Riverpod/Provider)
6. Implement proper session management
7. Add logout functionality
8. Add password hashing for security


