#include "Color.h"

RGB::RGB(uint8_t r1, uint8_t g1, uint8_t b1) {
    r = r1;
    g = g1;
    b = b1;
}

// This code comes from Adafruit_NeoMatrix. They use a uint16_t to express
// RGB tuples.
uint16_t RGB::to_color() {
  return ((uint16_t)(r & 0xF8) << 8) |
         ((uint16_t)(g & 0xFC) << 3) |
                    (b         >> 3);
}

HSB::HSB(float h1, float s1, float b1) {
    // if (hue < 0f || hue > 360f || saturation < 0f || saturation > 1f || 
    //     brightness < 0f || brightness > 1f) {
    //     SWT.error(SWT.ERROR_INVALID_ARGUMENT);
    // }
    
    h = h1;
    s = s1;
    b = b1;
}

// This code apapted from SWT, released under the Eclipse Public License.
void HSB::to_rgb(RGB *rgb) {
     float r1, g1, b1;

     if (s == 0) {
         r1 = g1 = b1 = b; 
     } else {
         float hue = h;

         if (hue == 360) { hue = 0; }

         hue /= 60; 
         int i = (int)hue;
         float f = hue - i;
         float p = b * (1 - s);
         float q = b * (1 - s * f);
         float t = b * (1 - s * (1 - f));
         switch(i) {
             case 0:
                 r1 = b;
                 g1 = t;
                 b1 = p;
                 break;
             case 1:
                 r1 = q;
                 g1 = b;
                 b1 = p;
                 break;
             case 2:
                 r1 = p;
                 g1 = b;
                 b1 = t;
                 break;
             case 3:
                 r1 = p;
                 g1 = q;
                 b1 = b;
                 break;
             case 4:
                 r1 = t;
                 g1 = p;
                 b1 = b;
                 break;
             case 5:
             default:
                 r1 = b;
                 g1 = p;
                 b1 = q;
                 break;
         }
     }

     rgb->r = (int)(r1 * 255 + 0.5);
     rgb->g = (int)(g1 * 255 + 0.5);
     rgb->b = (int)(b1 * 255 + 0.5);
}

uint16_t HSB::to_color() {
    RGB rgb(0, 0, 0);
    to_rgb(&rgb);
    return rgb.to_color();
}
