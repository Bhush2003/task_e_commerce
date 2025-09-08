Signup Process
1. User fills email, password, and selects image
2. Image path is stored as string (not File object)
3. User data is stored in Hive using `SimpleAuthController.addUser()`

Login Process
1. User enters email and password
2. Credentials are validated using `SimpleAuthController.checkUser()`
3. On success, user is navigated to Dashboard
4. On failure, appropriate error message is shown

Key Changes Made

1. **User Model**: Changed `File image` to `String imagePath`
2. **Authentication**: Centralized auth logic in `SimpleAuthController`
3. **Error Handling**: Added proper try-catch blocks and error messages
4. **Navigation**: Fixed premature navigation in login flow
5. **Hive Setup**: Updated main.dart with correct adapter registration


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


