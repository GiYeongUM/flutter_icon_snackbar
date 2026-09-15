# Migrating to flutter_icon_snackbar 2.0

[← README](README.md) · [Release history](CHANGELOG.md)

Flutter 3.32 and Dart 3.8 remain the minimum supported versions. Update the dependency
to `flutter_icon_snackbar: ^2.0.0`, apply the changes below, then run `flutter analyze`
and your application's tests.

## Public API changes

| 1.x                                         | 2.0                                               |
| ------------------------------------------- | ------------------------------------------------- |
| IconSnackBar.show(...)                      | showIconSnackBar(...)                             |
| snackBarType                                | type                                              |
| direction                                   | dismissDirection                                  |
| labelTextStyle                              | textStyle                                         |
| SnackBarWidget                              | IconSnackBarContent                               |
| SnackBarWidget.color                        | IconSnackBarContent.iconColor                     |
| textColor                                   | textStyle: TextStyle(color: ...)                  |
| disabledTextColor / disabledBackgroundColor | Removed; use explicit styling when needed         |
| Non-null onPressed                          | Nullable onPressed; null disables tap interaction |

### Before

```dart
IconSnackBar.show(context, snackBarType: SnackBarType.success, label: 'Saved');
```

### After

```dart
showIconSnackBar(context, type: SnackBarType.success, label: 'Saved');
```

The context remains positional. duration and dismissDirection are now non-null options
with defaults; omit them instead of explicitly passing null.

Default status colors now follow ColorScheme rather than fixed green/red/black. The
entrance starts immediately rather than after a 300 ms timer. Content no longer
implements SnackBarAction; use Flutter's SnackBarAction for a true action.

## Verification checklist

- Check light and dark themes with your app's color scheme.
- Check large text and narrow layouts.
- Check right-to-left layouts where applicable.
- Check screen-reader labels and reduced-motion behavior.
- Run application tests after updating call sites.
