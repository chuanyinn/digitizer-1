# Digitzer
[Hardware](https://github.com/nupole/digitizer/tree/rev/hw) and [firmware](https://github.com/nupole/digitizer/tree/rev/fw) prototyping of a multichannel 8-bit, 100 MS/s digitizer.

## Features
- Two 1 V<sub>pp</sub> single-ended input channels
- Analog band-pass of 10 kHz to 10 MHz
- 8-bit, 100 MS/s ADCs
- Reconfigurable FPGAa
 - 1 kB/channel event buffer
 - Programmable pre and post-trigger sizes (0 to 2.55 &mu;s)
 - Programmable channel trigger thresholds
 - Programmable coincidence window sizes (0 to 2.55 &mu;s)
 - Programmable trigger coincidence value
 - Programmable trigger veto window size (0 to 2.55 &mu;s)
 - 32 I/O connections
 - 1 single-ended coax I/O
 - 4 JTAG connections

## Table of Contents
1. [Features](#features)
2. [Overview](#overview)

## Overview
The digitizer is a 100 mm by 50 mm electronics card with two 1 V<sub>pp</sub> single-ended input channels sampled by an 8-bit, 100 MS/s ADC. Each channels incoming data is written into its own circular buffer, and upon an internal trigger, is block transferred into its own 1 kB event buffer using user-defined pre and post-trigger window sizes ranging from 0 to 2.55 microseconds (0 to 255 bytes respectively). The event buffers are then readout on a parallel backplane interface.

To form an internal coincidence trigger, each input channel generates a user-defined coincidence window (ranging in size from 0 to 2.55 microseconds) by comparing the current ADC sample with a user-defined threshold. These coincidence windows are added and compared with a user-defined coincidence value to generate both a trigger and veto window. The veto window has user-defined size ranging from 0 to 2.55 microseconds and prevents a re-trigger during its duration.
