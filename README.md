# Transnode AngularDart app

## Install DartSDK and Dartium
* [Download SDK](https://www.dartlang.org/tools/download.html).
 Dartium included in SDK and can be found in **\<dart-sdk\>**/chromium

* extract to some folder, for example /opt/dart

* app to shell PATH folder /opt/dart/dart-sdk/bin
example:
```
  export PATH=/opt/dart/dart-sdk/bin:$PATH
```

## Deploy App
* clone this repo
```
  git clone git@github.com:WelkeGlobal/transnode-frontend.git
```

* run `pub get` in app root to get needed dependencies
```
  cd transnode-frontend
  pub get
```

* serve static files from `web` directory
