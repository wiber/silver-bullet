
{
  cyan500
  cyan700
  grey100
  grey300
  grey400
  grey500
  pinkA200
  white
  darkBlack
  fullBlack
  deepOrange500
  yellowA400

} = require('material-ui/lib/styles/colors')
ColorManipulator = require('material-ui/lib/utils/color-manipulator').default

lightBaseUsThemeO =
  spacing:
    iconSize: 24
    desktopGutter: 24
    desktopGutterMore: 32
    desktopGutterLess: 16
    desktopGutterMini: 8
    desktopKeylineIncrement: 64
    desktopDropDownMenuItemHeight: 32
    desktopDropDownMenuFontSize: 15
    desktopLeftNavMenuItemHeight: 48
    desktopSubheaderHeight: 48
    desktopToolbarHeight: 56
  fontFamily: 'Roboto,  sans-serif'
  palette:
    primary1Color: cyan500
    primary2Color: cyan700
    primary3Color: grey400
    accent1Color: pinkA200
    accent2Color: grey100
    accent3Color: grey500
    textColor: darkBlack
    alternateTextColor: white
    canvasColor: white
    borderColor: grey300
    disabledColor: ColorManipulator.fade(darkBlack, 0.3)
    pickerHeaderColor: cyan500
    clockCircleColor: ColorManipulator.fade(darkBlack, 0.07)
    shadowColor: fullBlack
  userAgent: 'all'


letsMeSeeTheme =
  spacing:
    iconSize: 24
    desktopGutter: 24
    desktopGutterMore: 32
    desktopGutterLess: 16
    desktopGutterMini: 8
    desktopKeylineIncrement: 64
    desktopDropDownMenuItemHeight: 32
    desktopDropDownMenuFontSize: 15
    desktopLeftNavMenuItemHeight: 48
    desktopSubheaderHeight: 48
    desktopToolbarHeight: 56
  fontFamily: 'Roboto,  sans-serif'
  palette:
    primary1Color: deepOrange500
    primary2Color: yellowA400
    primary3Color: grey400
    accent1Color: pinkA200
    accent2Color: grey100
    accent3Color: grey500
    textColor: darkBlack
    alternateTextColor: white
    canvasColor: white
    borderColor: grey300
    disabledColor: ColorManipulator.fade(darkBlack, 0.3)
    pickerHeaderColor: cyan500
    clockCircleColor: ColorManipulator.fade(darkBlack, 0.07)
    shadowColor: fullBlack
  userAgent: 'all'

getMuiTheme = require('material-ui/styles/getMuiTheme').default
exports.lightBaseUsTheme = getMuiTheme(lightBaseUsThemeO)
exports.letsMeSeeTheme = getMuiTheme(letsMeSeeTheme)
