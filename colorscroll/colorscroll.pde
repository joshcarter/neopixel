#include <Adafruit_GFX.h>
#include <Adafruit_NeoMatrix.h>
#include <Adafruit_NeoPixel.h>
#include <Color.h>
#ifndef PSTR
 #define PSTR // Make Arduino Due happy
#endif

#define PIN 6

// matrix is set up for a 5x8 NeoMatrix attached to an Arduino Uno.
Adafruit_NeoMatrix matrix = Adafruit_NeoMatrix(5, 8, PIN,
    NEO_MATRIX_TOP     + NEO_MATRIX_RIGHT +
    NEO_MATRIX_COLUMNS + NEO_MATRIX_PROGRESSIVE,
    NEO_GRB            + NEO_KHZ800);

// The offset makes the colors scroll across the screen.
int offset = 0;

void setup() {
    matrix.begin();
    
    // setBrightness is 0..255, but using all pixels at 255 brightness would
    // draw far too much power from Arduino's 5v supply. 50 is conservative
    // but still plenty bright with all pixels on.
    matrix.setBrightness(50);
}

void loop() {
    // 5x8 NeoMatrix: 40
    int max = matrix.height() * matrix.width();

    for (int x = 0; x < matrix.width(); x++) {
        for (int y = 0; y < matrix.height(); y++) {
            // pos is our (x,y) position expressed in a linear 0..max
            // line, with offset continually offsetting the starting
            // position. It's used to create a hue.
            int pos = (offset + (x * matrix.width() + y)) % max;

            // Create (hue,saturation,brightness) tuple with:
            // - position mapped to 0..360 range
            // - saturation full (1.0)
            // - brightness full (1.0)
            HSB hsb(pos * (360.0 / max), 1.0, 1.0);

            matrix.drawPixel(x, y, hsb.to_color());
        }
    }

    // Push the updated matrix to the NeoPixel display.
    matrix.show();
    delay(100);

    // Keep offset in the range 0..max.
    offset++;
    
    if (offset >= max) {
        offset = 0;
    }
}
