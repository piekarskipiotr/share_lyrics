<img src="assets/app_logos/share_lyrics_logo.png" alt="shareLYRICS Logo" width="200" height="200">

**shareLYRICS** is a powerful and user-friendly application designed for music enthusiasts who love to search, save,
and
share song lyrics effortlessly.
Leveraging the extensive database of the [Genius API][genius_api_link], **shareLYRICS**
provides access to a vast collection of song lyrics from various artists and genres.
With the convenience
of [Firestore][firestore_link], users can easily manage and share their favorite lyrics with friends.

---

## Project Updates and Contributions 🚀

I will be occasionally updating this project with new features, improvements, and bug fixes. Stay tuned for the latest
enhancements to **shareLYRICS**!

Your contributions are highly valued and appreciated. If you have any ideas for new features, improvements, or have
found a bug, feel free to submit a pull request. Whether you're a beginner or an experienced developer, your input can
help make **shareLYRICS** even better.

---

## Requirements 🛠️

To run the project, you will need to meet the following requirements:

- **Genius API Key** 🔑

  Get a Genius API key from the [Genius API website][genius_api_link]. Use the obtained API key when running the app by
  passing it as a Dart define:
    ```
    --dart-define GENIUS_API_KEY=<your_genius_api_key>
    ```

- **Firebase Project** 🔥

    - **Firebase Setup**: Create a Firebase project in the Firebase Console.
        - Add an Android and/or iOS app to your Firebase project.
        - Download the google-services.json (for Android) and/or GoogleService-Info.plist (for iOS) files and place them
          in the appropriate directories in your Flutter project.
        - Enable Firestore in the Firebase Console.
    - **Authentication**: Set up Firebase Authentication for user sign-in.
        - Enable the desired authentication methods (e.g., Google, Apple).

    <br>
    Note: To use Apple Sign-In, you must have a paid Apple Developer account.

---

### Disclaimer ⚠️

Please note that this app is not intended for commercial use and will not be published in-app stores due to the legal
complexities surrounding the usage of song lyrics. This project is for educational purposes, and users are free to fork
the repository and modify it as they wish. The [Genius API][genius_api_link] usage is subject to their terms and
conditions, and scraping lyrics is not the way to go.

[genius_api_link]: https://docs.genius.com/

[firestore_link]: https://firebase.google.com/docs/firestore
