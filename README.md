# Flutter Video Streaming (MUX integration)

A sample Flutter project for demonstrating how to integrate video streaming service with the help of [MUX](https://mux.com).

![](https://github.com/sbis04/flutter_stream/raw/master/screenshots/fluter_mux_cover.png)

# Usage

If you want to try this sample app, follow the steps mentioned below:

* Clone this GitHub repository
  
  ```bash
  https://github.com/sbis04/flutter_stream.git
  ```

* Get packages
  
  ```bash
  flutter pub get
  ```

* Create a file called `secrets.dart` inside the `lib` folder, add the following in it
  
  ```dart
  const accessTokenMUX = '<token_id>';
  const secretTokenMUX = '<token_secret>';
  ```

* Generate **MUX API Access Token** from [here](https://dashboard.mux.com/settings/access-tokens) (if you don't have a MUX account, create one by going [here](https://dashboard.mux.com/signup))

* This will generate a **Token ID** and **Token Secret**, add them to the `secrets.dart` file

Now, you are ready to run this app on your device, just use the this command:

```bash
cd flutter_stream
fluter run
```

# Plugins

The plugins that are used in this app are as follows:

* [dio](https://pub.dev/packages/dio) - for making HTTP POST and GET requests
* [video_player](https://pub.dev/packages/video_player) - for previewing the video to be streamed
* [intl](https://pub.dev/packages/intl) - to format `DateTime` objects

# License

Copyright (c) 2021 Souvik Biswas

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.