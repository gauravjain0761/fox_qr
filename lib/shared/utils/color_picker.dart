library hsv_picker;

import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter_colorpicker/src/palette.dart';
// ignore: implementation_imports
import 'package:flutter_colorpicker/src/utils.dart';
import 'package:fox/shared/utils/utils.dart';

/// The default layout of Color Picker.
class ColorPicker extends StatefulWidget {
  const ColorPicker({
    Key? key,
    required this.pickerColor,
    required this.onColorChanged,
    this.pickerHsvColor,
    this.onHsvColorChanged,
    this.paletteType = PaletteType.hsvWithHue,
    this.enableAlpha = true,
    @Deprecated('Use empty list in [labelTypes] to disable label.')
        this.showLabel = true,
    this.labelTypes = const [
      ColorLabelType.rgb,
      ColorLabelType.hsv,
      ColorLabelType.hsl
    ],
    @Deprecated('Use Theme.of(context).textTheme.bodyText1 & 2 to alter text style.')
        this.labelTextStyle,
    this.displayThumbColor = false,
    this.portraitOnly = false,
    this.colorPickerWidth = 300.0,
    this.pickerAreaHeightPercent = 1.0,
    this.pickerAreaBorderRadius = const BorderRadius.all(Radius.zero),
    this.hexInputController,
    this.colorHistory,
    this.onHistoryChanged,
  }) : super(key: key);

  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;
  final HSVColor? pickerHsvColor;
  final ValueChanged<HSVColor>? onHsvColorChanged;
  final PaletteType paletteType;
  final bool enableAlpha;
  final bool showLabel;
  final List<ColorLabelType> labelTypes;
  final TextStyle? labelTextStyle;
  final bool displayThumbColor;
  final bool portraitOnly;
  final double colorPickerWidth;
  final double pickerAreaHeightPercent;
  final BorderRadius pickerAreaBorderRadius;

  final TextEditingController? hexInputController;
  final List<Color>? colorHistory;
  final ValueChanged<List<Color>>? onHistoryChanged;

  @override
  // ignore: library_private_types_in_public_api
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  HSVColor currentHsvColor = const HSVColor.fromAHSV(0.0, 0.0, 0.0, 0.0);
  List<Color> colorHistory = [];

  @override
  void initState() {
    currentHsvColor = (widget.pickerHsvColor != null)
        ? widget.pickerHsvColor as HSVColor
        : HSVColor.fromColor(widget.pickerColor);
    // If there's no initial text in `hexInputController`,
    if (widget.hexInputController?.text.isEmpty == true) {
      // set it to the current's color HEX value.
      widget.hexInputController?.text = colorToHex(
        currentHsvColor.toColor(),
        enableAlpha: widget.enableAlpha,
      );
    }
    // Listen to the text input, If there is an `hexInputController` provided.
    widget.hexInputController?.addListener(colorPickerTextInputListener);
    if (widget.colorHistory != null && widget.onHistoryChanged != null) {
      colorHistory = widget.colorHistory ?? [];
    }
    super.initState();
  }

  @override
  void didUpdateWidget(ColorPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    currentHsvColor = (widget.pickerHsvColor != null)
        ? widget.pickerHsvColor as HSVColor
        : HSVColor.fromColor(widget.pickerColor);
  }

  void colorPickerTextInputListener() {
    // It can't be null really, since it's only listening if the controller
    // is provided, but it may help to calm the Dart analyzer in the future.
    if (widget.hexInputController == null) return;
    // If a user is inserting/typing any text — try to get the color value from it,
    final Color? color = colorFromHex(widget.hexInputController!.text,
        // and interpret its transparency, dependent on the widget's settings.
        enableAlpha: widget.enableAlpha);
    // If it's the valid color:
    if (color != null) {
      // set it as the current color and
      setState(() => currentHsvColor = HSVColor.fromColor(color));
      // notify with a callback.
      widget.onColorChanged(color);
      if (widget.onHsvColorChanged != null) {
        widget.onHsvColorChanged!(currentHsvColor);
      }
    }
  }

  @override
  void dispose() {
    widget.hexInputController?.removeListener(colorPickerTextInputListener);
    super.dispose();
  }

  Widget colorPickerSlider(TrackType trackType) {
    return ColorPickerSlider(
      trackType,
      fullThumbColor: false,
      currentHsvColor,
      (HSVColor color) {
        // Update text in `hexInputController` if provided.
        widget.hexInputController?.text =
            colorToHex(color.toColor(), enableAlpha: widget.enableAlpha);
        setState(() => currentHsvColor = color);
        widget.onColorChanged(currentHsvColor.toColor());
        if (widget.onHsvColorChanged != null) {
          widget.onHsvColorChanged!(currentHsvColor);
        }
      },
      displayThumbColor: true,
    );
  }

  void onColorChanging(HSVColor color) {
    // Update text in `hexInputController` if provided.
    widget.hexInputController?.text =
        colorToHex(color.toColor(), enableAlpha: widget.enableAlpha);
    setState(() => currentHsvColor = color);
    widget.onColorChanged(currentHsvColor.toColor());
    if (widget.onHsvColorChanged != null) {
      widget.onHsvColorChanged!(currentHsvColor);
    }
  }

  Widget colorPicker() {
    return Padding(
      padding:
          EdgeInsets.all(widget.paletteType == PaletteType.hueWheel ? 10 : 0),
      child: ColorPickerArea(
        currentHsvColor,
        onColorChanging,
        widget.paletteType,
      ),
    );
  }

  Widget sliderByPaletteType() {
    switch (widget.paletteType) {
      case PaletteType.hsv:
      case PaletteType.hsvWithHue:
      case PaletteType.hsl:
      case PaletteType.hslWithHue:
        return colorPickerSlider(TrackType.hue);
      case PaletteType.hsvWithValue:
      case PaletteType.hueWheel:
        return colorPickerSlider(TrackType.value);
      case PaletteType.hsvWithSaturation:
        return colorPickerSlider(TrackType.saturation);
      case PaletteType.hslWithLightness:
        return colorPickerSlider(TrackType.lightness);
      case PaletteType.hslWithSaturation:
        return colorPickerSlider(TrackType.saturationForHSL);
      case PaletteType.rgbWithBlue:
        return colorPickerSlider(TrackType.blue);
      case PaletteType.rgbWithGreen:
        return colorPickerSlider(TrackType.green);
      case PaletteType.rgbWithRed:
        return colorPickerSlider(TrackType.red);
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: SizedBox(
            width: widget.colorPickerWidth,
            height: 200.h,
            child: colorPicker(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 70.0,
                    width: double.infinity,
                    child: sliderByPaletteType(),
                  ),
                  Transform.translate(
                    offset: const Offset(10, -15),
                    child: Theme(
                      data: ThemeData(
                        primaryColor: Colors.red,
                        hintColor: Colors.green,
                        disabledColor: Colors.black,
                      ),
                      child: ColorPickerInput(
                        currentHsvColor.toColor(),
                        (Color color) {
                          setState(() =>
                              currentHsvColor = HSVColor.fromColor(color));
                          widget.onColorChanged(currentHsvColor.toColor());
                          if (widget.onHsvColorChanged != null) {
                            widget.onHsvColorChanged!(currentHsvColor);
                          }
                        },
                        enableAlpha: true,
                        disable: true,
                        embeddedText: false,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
