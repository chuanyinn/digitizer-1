# Digitizer (Hardware)
[Hardware](https://github.com/nupole/digitizer/tree/rev/hw) prototyping of a multichannel 8-bit, 100 MS/s digitizer.

## Features
 - Two singled ended input channels
 - Low-pass filter designed using current feedback amplifier in a Sallen-Key topology
 - 8-bit, 100 MS/s ADCs
 - Reconfigurable FPGA
  - 32 I/O connections
  - 1 single-ended coax I/O
  - 4 JTAG connections

## Modifications for Rev 0.1
 - [ ] Remove the solder mask covering the analog and trigger inputs
 - [ ] Exchange 4 pin header for a 6 pin header to include 3.3 V and GND from JTAG programmer
 - [ ] Copper fill the entire power plane
 - [ ] Add grounding strips on the front and back copper layers
 - [ ] Remove unused copper trace on the back copper layers
 - [ ] Slow the TCLK from FT232H programmer by bypassing to ground with 10's of pF
