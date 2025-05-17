# Security Policy

## Supported Versions

The Blood Donor History App is currently maintained for the following versions:

| Component      | Version  | Supported          |
| -------------- | -------- | ------------------ |
| Flutter        | 3.24.5   | :white_check_mark: |
| NodeJS Backend | v22.11.0 | :white_check_mark: |
| Riverpod       | 2.6.1    | :white_check_mark: |
| Firebase SDK   | Latest   | :white_check_mark: |

We provide security updates for the above versions. If you are using older versions, please upgrade to ensure you receive the latest security patches.

## Reporting a Vulnerability

We take the security of the Blood Donor History App seriously. If you discover a security vulnerability, please report it to us responsibly. This includes vulnerabilities in:

- The Flutter frontend (e.g., UI input validation, local storage).
- The NodeJS backend (e.g., API endpoints, authentication).
- Firebase Storage (e.g., improper access controls for profile images).
- Third-party integrations (e.g., map APIs, Riverpod state management).
- Development tools like ngrok (e.g., misconfigured tunnels).

### How to Report

1. **Do not disclose the vulnerability publicly** (e.g., in GitHub issues, social media, or forums) until it has been addressed.
2. Email your findings to [insert-your-email@example.com](mailto:insert-your-email@example.com). Include:
   - A detailed description of the vulnerability.
   - Steps to reproduce the issue (e.g., API endpoint exploited, Flutter UI bypass).
   - Any relevant screenshots, logs, or proof-of-concept code.
   - Your contact information for follow-up.
3. If you prefer encrypted communication, use our PGP key (available upon request via email).

### What to Expect

- We will acknowledge your report within 48 hours.
- We will investigate and validate the vulnerability within 7 days.
- If confirmed, we will work on a fix and coordinate with you on disclosure timing.
- We aim to release patches promptly, typically within 30 days, depending on severity.

## Guidelines for Responsible Disclosure

- Do not exploit the vulnerability beyond what is necessary to demonstrate it.
- Do not access, modify, or delete user data (e.g., donation history, profile images in Firebase).
- Do not disrupt the app’s services (e.g., denial-of-service attacks on the NodeJS backend).
- Follow ethical hacking principles and respect user privacy.

## Known Security Considerations

- **ngrok**: Used for development only. Free ngrok tunnels are publicly accessible, so ensure sensitive data (e.g., API keys, Firebase credentials) is not exposed during testing. Use environment variables (`.env`) and avoid committing sensitive data to GitHub.
- **Firebase Storage**: Profile images are stored in Firebase. Ensure proper security rules are configured to restrict unauthorized access (see `firebase.json` or Firebase console).
- **Map APIs**: If using external map services (e.g., Google Maps), secure API keys and restrict their usage to your app’s domains or bundle IDs.
- **NodeJS Backend**: Regularly update dependencies (`npm update`) to address known vulnerabilities in packages.

## Security Updates

We will notify users of critical security updates via:

- GitHub repository announcements (in the README or Releases).
- Email to contributors (if subscribed to our mailing list).
- Social media posts (e.g., Twitter, linked in the README).

## Recognition

We appreciate security researchers who report vulnerabilities responsibly. With your permission, we will acknowledge your contribution in our release notes or a dedicated "Hall of Fame" section in the repository.

Thank you for helping keep the Blood Donor History App safe and secure for all users!

---

Last updated: May 17, 2025
