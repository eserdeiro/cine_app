# Preview

<img src="https://raw.githubusercontent.com/eserdeiro/cine_app/main/assets/images/one.png" width="30%"><img src="https://raw.githubusercontent.com/eserdeiro/cine_app/main/assets/images/two.png" width="30%">

<img src="https://raw.githubusercontent.com/eserdeiro/cine_app/main/assets/images/three.png" width="30%"><img src="https://raw.githubusercontent.com/eserdeiro/cine_app/main/assets/images/four.png" width="30%">

# Getting Started

1. Generate an API key from [The Movie Database](https://www.themoviedb.org/).
2. Copy 'env.template' and rename it to 'env'.
3. Put the key in the `.env` file.
4. Execute
```
flutter pub run build_runner build
``` 
.env file
```
THE_MOVIEDB_KEY=YOUR_API_KEY
```

# UI

The UI components are designed following the example of the following repository
[Cinemax](https://github.com/AfigAliyev/Cinemax).

The app has one dark theme that uses predefined colors.

# Compatibility 

Currently only available for Android and iOS

I have incompatibilities with search delegate & isar database, which do not allow me to function on the web