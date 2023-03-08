import 'package:fluent_ui/fluent_ui.dart';

/// A colored button.
///
/// {@macro fluent_ui.buttons.base}
///
/// See also:
///
///   * [Button], the default button
///   * [OutlinedButton], an outlined button
///   * [TextButton], a borderless button with mainly text-based content
class FilledButton extends Button {
  /// Creates a filled button
  const FilledButton({
    Key? key,
    required Widget child,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    FocusNode? focusNode,
    bool autofocus = false,
    ButtonStyle? style,
  }) : super(
          key: key,
          child: child,
          focusNode: focusNode,
          autofocus: autofocus,
          onLongPress: onLongPress,
          onPressed: onPressed,
          style: style,
        );

  @override
  ButtonStyle? themeStyleOf(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));
    final buttonTheme = ButtonTheme.of(context);
    return buttonTheme.filledButtonStyle;
  }

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    final theme = FluentTheme.of(context);

    final def = ButtonStyle(backgroundColor: ButtonState.resolveWith((states) {
      return backgroundColor(theme, states);
    }), foregroundColor: ButtonState.resolveWith((states) {
      if (states.isDisabled) {
        return theme.brightness.isDark ? theme.disabledColor : Colors.white;
      }
      return backgroundColor(theme, states).basedOnLuminance();
    }));

    return super.defaultStyleOf(context).merge(def) ?? def;
  }

  static Color backgroundColor(ThemeData theme, Set<ButtonStates> states) {
    if (states.isDisabled) {
      if (theme.brightness.isDark) {
        return const Color(0xFF434343);
      } else {
        return const Color(0xFFBFBFBF);
      }
    } else if (states.isPressing) {
      if (theme.brightness.isDark) {
        return theme.accentColor.darker;
      } else {
        return theme.accentColor.lighter;
      }
    } else if (states.isHovering) {
      if (theme.brightness.isDark) {
        return theme.accentColor.dark;
      } else {
        return theme.accentColor.light;
      }
    }
    return theme.accentColor;
  }
}
