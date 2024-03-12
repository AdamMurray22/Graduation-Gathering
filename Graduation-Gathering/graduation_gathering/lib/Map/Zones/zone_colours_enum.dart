import 'colour.dart';

enum ZoneColours
{
  blue(0,0,255),
  red(255,0,0);

  const ZoneColours(this._r,this._g,this._b);

  final int _r;
  final int _g;
  final int _b;

  getColourRGB()
  {
    return Colour(_r,_g,_b);
  }
}