# Moon2P8
Compiles MoonScript to Pico-8 codes easily and flexibly.

## Overview

**[Pico-8](https://www.lexaloffle.com/pico-8.php)** is a fantasy game console created by [Lexaloffle Games](https://www.lexaloffle.com/). Pico-8 provides a complete package of tools for small-sized videogame development, including code editor (in Lua), sprite editor, tile map editor, and audio/music tools.

**[MoonScript](https://moonscript.org/)** is a programming language that compiles to [Lua](http://www.lua.org/).

While Pico-8 cartridge code is written in Lua and allows the inclusion of multiple files, its subset of Lua unfortunately conflicts with MoonScript and prevents a flexible code structure.

**Moon2P8** is a tool written in Python that automates the process of MoonScript to Lua compilation and injection to Pico-8 cartridge, while allowing a flexible code structure with a syntax similar to Pico-8's original `#include`.

## Requirement

**[Moonscript](https://moonscript.org/#installation)**: While a system-wide installation is preferred, `moonc` only needs to work in the working directory. To confirm, `moonc -v` should return the version of MoonScript.

**[Python 3](https://www.python.org/)**: This has been tested on Python 3.8.3.

**An output Pico-8 cartridge**: the easiest and simple way to do this is to reboot Pico-8 and `save *.p8`. This has to be a valid Pico-8 cartridge with `__lua__` and `__gfx__` markers. The output file has to be created priorly.

## Installation

* Download and save the raw script. Alternative, clone this repository.

* Keep the script somewhere easy to access, ideally in the same working directory with the source file and the output file.

A system-wide setup is possible and the process varies from OS and OS, but is unnecessary.

## Usage

**The process will destroy the codes contained in the output Pico-8 cartridge. Do make backup as needed.**

    moon2p8.py inputFile outputFile [-h] [-v] [-kt]

    positional arguments:
      inputFile             your *.moon source file
      outputFile            the output *.p8 Pico-8 cartridge to insert codes to     
                            (must be pre-created and has valid __lua__ and __gfx__  
                            markers)

    optional arguments:
      -h, --help            show this help message and exit
      -v, --verbose         show detailed and verbose output
      -kt, --keeptempfiles  keep temporary files after the operation

Actual example:

    python moon2p8.py src.moon DarkDawn.p8 -v

## Multiple files inclusion

The syntax differs slightly from Pico-8, but works similarly:

    #include("your_file.moon")
    #Include("Entities/Player.moon")
    #INCLUDE("Components/PlayerControl.moon")

`#include` can be case insensitive, and **DOUBLE-QUOTES** are mandatory.

Consolidating instances of `#include` into the entry source file is recommended. It should work recursively, but this has not been tested.

## Remarks

* **The process will destroy the code contained in the output Pico-8 cartridge. Do make backup as needed.**
* This has not been tested with Python 2.
* This has only been tested on Windows 10.
* Two temporary files will be created and necessary for the compilation to Lua. Some permission granting might be necessary, and this differs from system to system.

## Contribution

Code critiques, issues and pull requests are welcomed.
