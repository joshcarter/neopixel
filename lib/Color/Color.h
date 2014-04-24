#ifndef __COLOR_H__
#define __COLOR_H__

#include "Arduino.h"

class RGB;
class HSB;

// RGB is a simple wrapper for (red,green,blue) tuples.
class RGB {
public:
  uint8_t r; // 0 to 255
  uint8_t g; // 0 to 255
  uint8_t b; // 0 to 255

  // Construct RGB tuple.
  RGB(uint8_t r, uint8_t g, uint8_t b);
  
  // Convert to NeoMatrix 16-bit color.
  uint16_t to_color();
};

// HSB is a simple wrapper for (hue,saturation,brightness) tuples, with the
// ability to convert to RGB.
class HSB {
public:
  float h; // 0 to 360
  float s; // 0 to 1
  float b; // 0 to 1
  
  // Construct HSB tuple.
  HSB(float h, float s, float b);

  // Convert to RGB tuple.
  void to_rgb(RGB *rgb);

  // Convert to NeoMatrix 16-bit color.
  uint16_t to_color();
};

#endif // __COLOR_H__

