# lff-cr

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](/LICENSE)
[![Build Status](https://travis-ci.org/mkdika/lff-cr.svg?branch=master)](https://travis-ci.org/mkdika/lff-cr)

Simple and straightforward large files finder utility for *nix, optimize for human, written in [Crystal](https://crystal-lang.org/) language.

## Why?

There are workarounds to do it on *nix, using combination of `find`, `du`, `sort`, `head` eg:

```bash
find /your/directory -xdev -type f -exec du -sh {} ';' | sort -rh | head -n10
# will printout the top 10 largest files size within given directory
```

But I'm to lazy to memorize them all :sweat_smile: so I need the simplest solution instead!

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
