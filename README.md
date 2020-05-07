# flutter_strings_localization

A flutter plugin to manage different locations files for your translates with supports for differents country codes and plurals.

## Project configuration

To use flutter_localizations, add the package as a dependency to your `pubspec.yaml` file:

```
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
```

Next, import the flutter_localizations library and specify `localizationsDelegates` and `supportedLocales` for `MaterialApp`:

```
import 'package:flutter_localizations/flutter_localizations.dart';

MaterialApp(
 localizationsDelegates: [
   // ... app-specific localization delegate[s] here
   GlobalMaterialLocalizations.delegate,
   GlobalWidgetsLocalizations.delegate,
   GlobalCupertinoLocalizations.delegate,
 ],
 supportedLocales: [
    const Locale('en'), // English
    const Locale('he'), // Hebrew
  ],
  // ...
)
```

More info in [https://flutter.dev/docs/development/accessibility-and-localization/internationalization](https://flutter.dev/docs/development/accessibility-and-localization/internationalization)

### iOS configuration

Add the next permissions to info.plist (Remember selected the correct language code)

```
<key>CFBundleDevelopmentRegion</key>
	<string>en</string>

<key>CFBundleLocalizations</key>
	<array>
		<string>en</string>  <!-- English -->
		<string>he</string>  <!-- Hebrew -->
	</array>
```

### Android configuration

Anything to do! Great!

## Library Configuration

Add **_flutter_strings_localization_** package as a dependency to your `pubspec.yaml` file:

```
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter

  # Another Awesome libreries

  flutter_strings_localization: ^1.0.0
```

## How to use

You will need create a individual file for each location. For example. if you want to have support for (English, Spanish and French) in your project, You will need to add 3 individual files.dart **_(strings_en.dart, strings_es.dart, strings_french.dart)_**

**_Contry code is supported too_** and you can add different variations of english for example. **_en_US_** and **_ en_UK_**

### 1. Create your first location file

Sample file for strings.en.dart

```
Map<String, Map<PluralsKey, String>> stringFileEN = {
	StringsKey.title: {
		PluralsKey.none:  'This is the title',
	},

	StringsKey.sampleWithoutParams: {
		PluralsKey.none:  'This is an description without parameteres'
	},

	StringsKey.sampleWithParams: {
		PluralsKey.none:  'This is the "@0" that I am sending'
	},

	StringsKey.sampleWithPlurals: {
		PluralsKey.zero:  'Tomato Empty',
		PluralsKey.one:  'I have @0 tomato',
		PluralsKey.other:  'I have @0 tomatoes'
	},
};
```

**_PluralsKey_** is an enum used by the library with 4 options **_(none, zero, one, other)_**
Please use **_.none_** for default strings without plurals because is called by default for the getString() method.

**_@0_** is the easy way to replace the different parameters that you will send. there are not limit but always staring in @0 and continue with @1, @2, @3, @4. etc... this parameters are sending in a dynamic list.

### 2. Add your location file

```
void  main() {
	LocalizationsFiles().save = {
		'en': stringFileES, // English File
		'he': stringFileHE // Hebrew File
	};
	runApp(MyApp());
}
```

**_ Important_** the 'locale_key' must be the same declared in supported locales.

```
 supportedLocales: [
    const Locale('en'), // English
    const Locale('he'), // Hebrew
  ],
```

### 3. Try and enjoy!

You can call the TranslateManager to access the methods **_getString()_** and **_getPlurals()_**

```
@override
Widget  build(BuildContext context) {
	final translateManager =  TranslateManager(context);

return  Scaffold(
	appBar:  AppBar(
		title:  Text(translateManager.getString('your_key')),
		),
	);
}
```
