# AOC
A set of tools to run your Advent of Code solutions, written with various languages

The `aoc` command is a wrapper around a couple of scripts, providing a simple framework to run Advent of Code solutions with just one command, regardless of the language it is implemented in

## Directory structure
The commands expect your solutions to be in a precise directory structure, like this one:
```
advent-of-code
├── day-01
│   ├── input
│   ├── input.debug
│   ├── part-1.hs
│   └── part-2.c
├── day-02
│   ├── input
│   ├── input.debug
│   ├── part-1.rs
│   └── part-2.cpp
└── ...
```

## Commands
Available commands are:
- `aoc input`: fetch your input file from adventofcode.com, using your session cookie. \
    As you can see in the example you can manually create an `input.debug`, copying the small input provided in the problem description
- `aoc lang`: print and set the language of the solutions
- `aoc run`: run the solutions in the selected language.
    If the language is supported it just runs the latest solution (if a `part-2` exists it runs that one), even if the language is compiled.
    It also copies the result on the clipboard (on macOS), to be ready to quickly paste it on the website. \
    You can also run it in debug mode with `aoc run -d`, using the smaller debug input file (for which you know the solution, given in the problem description)
