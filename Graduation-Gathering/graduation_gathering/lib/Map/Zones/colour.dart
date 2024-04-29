/// A Colour class that storwes the RGB values.
class Colour
{
  /// The red value.
  final int red;
  /// The green value.
  final int green;
  /// The blue value.
  final int blue;
  Colour(this.red, this.green, this.blue);

  /// Sets the == operator to check if the rgb values of the two object are equal.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Colour &&
              runtimeType == other.runtimeType &&
              red == other.red &&
              blue == other.blue &&
              green == other.green;

  /// Sets the hashcode to use the rgb values.
  @override
  int get hashCode => red.hashCode + blue.hashCode + green.hashCode;
}