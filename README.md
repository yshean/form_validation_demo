# form_validation_simple

This is the source code of the demo that is shown in my talk [Elegant Form Validation in Flutter](https://docs.google.com/presentation/d/157ynN4mF-qa9C01RVJdch-UjmLDCv00pUGezf_EtI54/edit?usp=sharing).

To run the app, make sure you register for account at [FavQs](https://favqs.com) and get an API key. Assuming that you use VS Code to run the app, rename the `launch.json.example` file in `.vscode/` directory to `launch.json`, and replace `YOUR_API_KEY` with a valid API key. If you are not using VS Code, start the app (`flutter run`) with an extra argument `--dart-define fav-qs-app-token=YOUR_API_KEY`. Enjoy!

This repository contains packages that are part of the [materials](https://github.com/kodecocodes/rwf-materials) that accompany the Real-World Flutter by Tutorials book. They reside in the `packages/` folder. I would highly recommend any intermediate users of Flutter to get the book :)

## What this demo shows

<img src="form_validation_demo.gif" height="600"/>

- Sync/realtime validation errors (e.g. check if the field is empty, if number of characters meet a minimum length, if it matches a regular expression, etc.)
- Validate fields that are dependent on each other (e.g. password and confirm password)
- Async/server validation errors (e.g. check if the username is already taken, if the email is already registered)
- Control the timing when validation happens (e.g. only show validation error if the form or field has already been interacted by the user before, or only when the form has been submitted once)
- Clear the validation error when user has started editing the field
- Implement custom looking fields (non-Material/Cupertino based)
- A few UX tricks for controlling focus
