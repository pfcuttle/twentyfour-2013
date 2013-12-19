Twenty Four Days of Hackage, 2013 edition
=========================================

This combines (nearly) every sample from Oliver Charles' Twenty Four days of
Haskell into an easily compilable repository.


Building
--------

To build all the included examples, run:

```sh
cabal sandbox init
cabal add-source {various sources}
cabal install --dependencies-only
cabal configure --enable-tests  # Optional
cabal build
```

Binaries will be in `dist/{example name}`.

The following examples need manual build or run steps:


### Linear

* Depends on [SDL2](https://github.com/Lemmih/hsSDL2)

As SDL2 is not on Hackage yet, it is recommended to clone the repository, and
use a sandbox with the `cabal sandbox add-source` command.


### Scotty

* Depends on [Scotty 0.6.x](https://github.com/ku-fpg/scotty)

Version 0.6 is not released on Hackage yet. You can try building with the latest
version available (0.5.x), but expect errors. It is preferable to clone the
repository, and use a sandbox with the `cabal sandbox add-source` command.

Please run from `src/scotty` if you want to render the included HTML stub.


### SBV

* Depends on an external STM solver, by default [Z3](https://z3.codeplex.com/)
* If using Z3, version 4.1 will not work. The example was tested with the
  [Debian x64 unstable binary](https://z3.codeplex.com/releases/view/101916)
  (4.3.2).


### Heist

Please run from `src/heist` if you want to render the included templates.


### Repa

Please run from `src/repa` if you want to snowflake ocharles' picture.


### Doctest

Run `cabal configure --enable-tests` before doing `cabal build`, then run `cabal
test` from this project's root directory.


Problematic examples
--------------------

[ ] [Gloss](http://hackage.haskell.org/package/gloss) conflicts with
    [Linear](http://hackage.haskell.org/package/linear) because of incompatible
    OpenGL dependencies.
