# lff-cr

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](/LICENSE)
[![Built with Crystal](https://img.shields.io/badge/built%20with-crystal-000000.svg?style=flat-square)](https://crystal-lang.org/)
[![Build Status](https://travis-ci.org/mkdika/lff-cr.svg?branch=master)](https://travis-ci.org/mkdika/lff-cr)
[![Latest release](https://img.shields.io/github/release/mkdika/lff-cr.svg)](https://github.com/mkdika/lff-cr/releases)

Simple and straightforward large files finder utility for *nix, optimize for human.

## Why?

There are workarounds about how to do it on *nix, for instance is using combination of `find`, `du`, `sort`, `head`.

```bash
find /your/directory -xdev -type f -exec du -sh {} ';' | sort -rh | head -n10
# will printout the top 10 largest files size within given directory
```

But I'm to lazy to memorize them all :sweat_smile: I need a simpler solution instead!

```bash
# my way
lff /your/directory
```

## Benchmark

I simple benchmarking with `time`, with searching the top largest files within moderate Java project directory and about 11.901 files:

```bash
# with: find, du, sort, head
find /my/project/directory -xdev -type f -exec du -sh {} ';'  6.63s user 14.03s system 85% cpu 24.131 total
sort -rh  0.08s user 0.07s system 0% cpu 24.145 total
head -n10  0.00s user 0.00s system 0% cpu 24.141 total
```

```bash
# with: lff
./lff /my/project/directory  0.05s user 0.25s system 92% cpu 0.328 total
```

It is faster!

_NOTE: Benchmarking is run on MBP2018 13" OSX 10.15.4._

## Installation

### MacOS

```bash
brew tap mkdika/brew
brew install lff
```

### Linux

_Coming soon.._

## Build from source

Install [Crystal](https://crystal-lang.org/install/) language.

```bash
git clone https://github.com/mkdika/lff-cr.git
cd lff-cr/
shards build --production --release
```

The built binary will be available as `./bin/lff`

## Usage

```bash
# lff <directory-path>
lff ~/Downloads
# or simple `lff` only to run at current directory.
```

## Contributing

1. Fork it (<https://github.com/mkdika/lff-cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Maikel Chandika](https://github.com/mkdika) - creator and maintainer

## Copyright and License

Copyright 2020 Maikel Chandika (mkdika@gmail.com). Code released under the MIT License. See [LICENSE](/LICENSE) file.
