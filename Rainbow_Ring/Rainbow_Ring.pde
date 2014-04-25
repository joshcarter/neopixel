//
// Scrolls a rainbow around a 16-NeoPixel ring. Uses pin D0 of Adafruit Gemma
// to drive the ring.
//

#include <Adafruit_NeoPixel.h>
#ifdef __AVR_ATtiny85__ // Trinket, Gemma, etc.
  #include <avr/power.h>
#endif

// Color library (see lib/README.md) must be installed in Arduino IDE.
#include "Color.h"

// 16 LED ring connected to pin 0.
Adafruit_NeoPixel pixels = Adafruit_NeoPixel(16, 0, NEO_GRB + NEO_KHZ800);

// offset used to make the colors scroll around the ring.
int offset = 0;

void setup() {
    pixels.begin();
    pixels.setBrightness(50);
}

void loop() {
    int max = pixels.numPixels();

    for (int i = 0; i < max; i++) {
        // Offset our position within the ring; mod back to range 0..max.
        int pos = (offset + i) % max;

        // Create (hue,saturation,brightness) tuple with:
        // - position mapped to 0..360 range
        // - saturation full (1.0)
        // - brightness full (1.0)
        HSB hsb(pos * (360.0 / max), 1.0, 1.0);

        // Convert HSB -> RGB.
        RGB rgb(0, 0, 0);
        hsb.to_rgb(&rgb);

        pixels.setPixelColor(i, rgb.r, rgb.g, rgb.b);
    }

    // Push the updated values to the NeoPixel ring.
    pixels.show();
    delay(100);

    // Keep offset in the range 0..max.
    offset++;

    if (offset >= max) {
        offset = 0;
    }
}
