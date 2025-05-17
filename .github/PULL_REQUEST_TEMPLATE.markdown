# Pull Request Template

Thank you for contributing to the Blood Donor History App! Please fill out the sections below to help us review your pull request efficiently.

## Description
Provide a clear and concise description of what this PR does. Include:
- The feature or bug fix (e.g., added gold medal logic, fixed map API integration).
- Why this change is necessary.
- Any relevant context or screenshots (e.g., UI changes for donation history).

Example:
> Added a new feature to display the number of days since the last donation in the user profile. This enhances user engagement by showing donation recency. Includes UI updates in Flutter and a new API endpoint in NodeJS.

## Type of Change
Please check the appropriate box:
- [ ] Bug fix (non-breaking change that fixes an issue)
- [ ] New feature (non-breaking change that adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to change)
- [ ] Documentation update
- [ ] Other (please specify):

## Related Issues
Link any related GitHub issues this PR addresses (e.g., `Fixes #123`).

Example:
> Fixes #123 (Issue with incorrect medal calculation for silver tier)

## How Has This Been Tested?
Describe how you tested your changes. Include:
- Steps to reproduce or test the feature/bug fix.
- Any specific setup (e.g., ngrok for backend testing, Firebase configuration).
- Platforms tested (e.g., Android, iOS, NodeJS backend).

Example:
> - Ran `flutter test` for unit tests on donation history logic.
> - Tested API endpoint `/api/donations` using ngrok (`https://abc123.ngrok.io`).
> - Verified map rendering on Android emulator and iOS physical device.
> - Checked profile image upload to Firebase Storage.

## Checklist
Ensure your PR meets the following requirements:
- [ ] My code follows the project's coding standards (Flutter lint, NodeJS ESLint).
- [ ] I have performed a self-review of my code.
- [ ] I have commented my code, particularly in hard-to-understand areas.
- [ ] I have made corresponding changes to the documentation (e.g., README, API docs).
- [ ] My changes generate no new warnings or errors.
- [ ] I have added tests that prove my fix is effective or that my feature works.
- [ ] All new and existing tests pass (`flutter test` and `npm test`).

## Additional Notes
Add any other information that might help reviewers, such as:
- Dependencies added (e.g., new Flutter or NodeJS packages).
- Potential follow-up tasks (e.g., optimize map loading performance).
- Screenshots or videos (especially for UI changes like medal display or map updates).

Example:
> Added `google_maps_flutter` dependency for enhanced map features. Consider optimizing marker loading in a future PR.

## Testing Instructions for Reviewers
Provide specific instructions for reviewers to test your changes. Include:
- How to set up the environment (e.g., `flutter pub get`, `npm install`, ngrok setup).
- Commands to run the app or backend.
- What to look for (e.g., bronze medal appears after 3 donations).

Example:
> 1. Clone the repo and checkout this branch.
> 2. Run `flutter pub get` in the `frontend` folder.
> 3. Run `npm install` and `node index.js` in the `backend` folder.
> 4. Start ngrok: `ngrok http 3000` and update `lib/core/constants/api_endpoints.dart` with the ngrok URL.
> 5. Run `flutter run` and verify the donation history updates in the profile screen.

---

By submitting this pull request, you agree to follow our [Code of Conduct](CODE_OF_CONDUCT.md) and [Contributing Guidelines](CONTRIBUTING.md).
