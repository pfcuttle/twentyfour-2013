Twenty Four Days of Hackage, 2013 edition
=========================================

This combines every sample from Oliver Charles' Twenty Four days of Haskell into
an easily compilable repository.


Linear
------

* Depends on [SDL2](https://github.com/Lemmih/hsSDL2)

As SDL2 is not on Hackage yet, it is recommended to clone the repository, and
use a sandbox with the `cabal sandbox add-source` command.


Scotty
------

* Depends on [Scotty 0.6.x](https://github.com/ku-fpg/scotty)

Version 0.6 is not released on Hackage yet. You can try building with the latest
version available (0.5.x), but expect errors. It is preferable to clone the
repository, and use a sandbox with the `cabal sandbox add-source` command.

Please run from `src/scotty` if you want to render the included HTML stub.
