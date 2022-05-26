#!/bin/bash

gdbserver --disable-randomization --once 0.0.0.0:5678 ${@:1}
