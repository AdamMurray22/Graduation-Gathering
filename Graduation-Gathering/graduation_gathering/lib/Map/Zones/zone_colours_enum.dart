import 'colour.dart';

/// Zone colours enum.
enum ZoneColours
{
  /// Pure blue colour
  blue(0,0,255),
  /// Pure Red colour
  red(255,0,0);

  const ZoneColours(this._r,this._g,this._b);

  final int _r;
  final int _g;
  final int _b;

  /// Returns the RGB Colour Object.
  getColourRGB()
  {
    return Colour(_r,_g,_b);
  }
}