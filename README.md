# DonerDiary
<p align="center">
<img src="https://github.com/LakshanMaduka/DonorDiary/blob/f428b6d2d167f09291bf01f896bea593d37adcae/Track%20your%20blood%20donations%2C%20earn%20medals%2C%20and%20locate%20blood%20banks%20with%20the%20Blood%20Donor%20History%20App.png" alt="name"/>
<p/>

<h4 align="center">Best practices to gain maximum engagements, contributions, and acknowledgements(like stars, sponsors)</h4>

<p align="center">
<a href="[https://github.com/LakshanMaduka/DornerDiary/LICENSE" target="blank">
<img src="https://img.shields.io/github/license/atapas/model-repo?style=flat-square" alt="tryshape licence" />
</a>

# 👋 Introducing `DonorDiary`
`DonorDiary`  is an open-source mobile application built with Flutter, Riverpod, and a NodeJS backend (MVVM architecture). It helps blood donors track their donation history, earn medals (bronze, silver, gold) based on donation count, locate blood banks and mobile collection centers via maps.


# 💻 DonorDiary Repo
Please access `model-repo` using the URL:

> https://github.com/LakshanMaduka/DornerDiary

# 🔥 Features
`DonerDiary` comes with a bundle of features already. You can do the followings with it,

✅ **Donation Tracking:** Log donation history and see days since last donation.

✅ **Medal Rewards:** Earn bronze, silver, or gold medals for donation milestones.

✅ **Blood Bank Locator:** View nearby blood banks and mobile centers on interactive maps.

✅ **Mobile blood donation schedule:** Users can see the scheduled mobile blood donation campaigns for the upcoming two weeks.

✅ **Cross-Platform:** Runs on Android and iOS with a responsive Flutter UI.

# 🛠️ How to Set up `DonerDiary` for Development?
1. Clone the repository

```bash
git clone https://github.com/LakshanMaduka/DonorDiary.git
```
## 2.1 Setup client project

For this project, I have used Flutter 3.24.5 version.

 Change the working directory.

```bash
cd DonorDiary
```

 Install Flutter dependencies

```bash
flutter pub get
```
You need to set up Firebase for this project. Use Firebase CLI to set up Firebase. Make sure to turn on the storage service in the Firebase Project.

```bash
1. Install Firebase CLI: `npm install -g firebase-tools`
2. Authenticate: `firebase login`
3. Generate config: `flutterfire configure`
```

Run the app

```bash
flutter run
```

## 2.2 Setup Backend

Change the work directory to the server.

```bash
npm install
```
Then create .env in the project directory according to .env.example file.

run backend

```bash
node src/index.js 
```

You can use `ngrok` 
ngrok creates a secure tunnel to your local NodeJS backend (e.g., running on localhost:3000), providing a public URL (e.g., https://abc123.ngrok.io). Then, paste this public URL in client/lib/constants/api_endpoints.dart file.

That's All!!! Now open [localhost:3000](http://localhost:3000/) to see the app.

# 🛡️ License
This project is licensed under the MIT License - see the [`LICENSE`](LICENSE) file for details.

# 🦄 Upcoming Features
`model-repo` has all the potentials to grow further. Here are some of the upcoming features planned(not in any order),

- ✔️ Blood request functionality.
- ✔️ Notification service.
- ✔️ Map direction to the blood bank.
  


If you find something is missing, `DonerDiary` is listening. Please create a feature request [from here](https://github.com/LakshanMaduka/DonorDiary/issues).


# 🤝 Contributing to `DonorDiary`
Any kind of positive contribution is welcome! Please help us to grow by contributing to the project.

If you wish to contribute, you can work on any features [listed here](https://github.com/LakshanMaduka/DonorDiary#-upcoming-features) or create one on your own. After adding your code, please send us a Pull Request.

> Please read [`CONTRIBUTING`](CONTRIBUTING.md) for details on our [`CODE OF CONDUCT`](CODE_OF_CONDUCT.md), and the process for submitting pull requests to us.

