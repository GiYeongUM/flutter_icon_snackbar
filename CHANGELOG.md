# Changelog

[← README](README.md) · [Migration guide](MIGRATION.md)

## 2.0.0

### Changed

- Separate presentation, content, animation lifecycle, status models, and color
  resolution.
- Replace static helpers with showIconSnackBar and expose IconSnackBarContent.
- Remove the inappropriate SnackBarAction interface and unused disabled-color fields.
- Replace delayed timers with lifecycle-owned animation controllers.
- Follow ColorScheme, typography, RTL, and reduced motion; use icon_animated 2.0.0.

### Migration

- This major release intentionally changes public APIs; see
  [MIGRATION.md](MIGRATION.md).
- Minimum requirements remain Flutter 3.32 and Dart 3.8.

### Documentation

- Refresh examples, configuration tables, architecture notes, and migration
  instructions.

## 1.3.0

- Update icon_animated to 1.3.0.
- Require Dart 3.8 and Flutter 3.32 or newer; adopt flutter_lints 6.
- Cancel pending animation timers on disposal and capture the messenger safely.
- Return the snack bar controller and respect directional text spacing.
- Remove deprecated APIs and add dismissal and lifecycle regression tests.

## 1.2.1

- fix Readme

## 1.2.0

- fix SnackBarStyle error
  ([#3](https://github.com/GiYeongUM/flutter_icon_snackbar/issues/3))
- remove SnackBarStyle

## 1.1.7

- add SnackBarBehavior option
  ([#2](https://github.com/GiYeongUM/flutter_icon_snackbar/issues/2))
- change SnackBarType save to success

## 1.1.6

- add maxLines option
  ([#1](https://github.com/GiYeongUM/flutter_icon_snackbar/issues/1))

## 1.1.5

- fix issue with multiline text
  ([#1](https://github.com/GiYeongUM/flutter_icon_snackbar/issues/1))

## 1.1.4

- fix dispose error

## 1.1.3

- update icon package

## 1.1.2

- add dispose

## 1.1.1

- fix Ticker

## 1.1.0

- fix package update
- delete showIconFirst

## 1.0.2

- update Flutter version 3.10.0

## 1.0.1

- fix flutter version

## 1.0.0

- publish project on pub.dev
- project Separation
