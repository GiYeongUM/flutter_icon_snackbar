# flutter_icon_snackbar

This widget is a simple snackbar of the flutter that contains animations and icons.

[![Flutter](https://img.shields.io/badge/Platform-Flutter-blue.svg)](https://flutter.dev/)

## Features

- **Easier**
- [Animated Icons](https://pub.dev/packages/icon_animated)

## ⚡ [Installation](https://flutter.dev/docs/development/packages-and-plugins/using-packages)

```yaml
dependencies:
  flutter_icon_snackbar: ^<latest_version>
```

## 💪 Usage

## 1. common usage

Default type of icon_snackbar.

<img width="308" alt="" src="https://github.com/GiYeongUM/flutter_icon_snackbar/raw/main/images/snackbar_type_1.gif">

``` dart
IconSnackBar.show(
    context: context, 
    snackBarType: SnackBarType.save, 
    label: 'Save successfully'
);
```

## 2. snackbar type

Snackbar has many types, and you can set the types of Save, Fail, and Alert. and icon includes animation, [and here are the icons](https://pub.dev/packages/icon_animated) that you can use.

<img width="308" alt="" src="https://github.com/GiYeongUM/flutter_icon_snackbar/raw/main/images/snackbar_type_2.gif">
<img width="308" alt="" src="https://github.com/GiYeongUM/flutter_icon_snackbar/raw/main/images/snackbar_type_3.gif">

``` dart
IconSnackBar.show(context: context, snackBarType: SnackBarType.error, label: 'Save failed!');
```

``` dart
IconSnackBar.show(context: context, snackBarType: SnackBarType.alert, label: 'Data required');
```

## 3. custom theme

Also modify the theme of Snackbar. The theme contains the following data.

``` dart
class SnackBarStyle {
  final Color? backgroundColor;
  final Color iconColor;
  final TextStyle labelTextStyle;

  const SnackBarStyle({this.backgroundColor, this.iconColor = Colors.white, this.labelTextStyle = const TextStyle()});
}
```



