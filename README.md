Twenty Four Days of Hackage, 2013 edition
=========================================

This combines every sample from Oliver Charles' Twenty Four days of Haskell into
an easily compilable repository.


Building
--------

The following examples need manual build steps:


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


Problematic examples
--------------------

* [Gloss](http://hackage.haskell.org/package/gloss) conflicts with
  [Linear](http://hackage.haskell.org/package/linear) because of incompatible
  OpenGL dependencies.
