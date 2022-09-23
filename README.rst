Generate Code
-------------

::

   ./filecreator.rkt 10
   raco make output/*.rkt

Time Loading of the Combined Module
-----------------------------------

You will need the `require-latency <https://pkgd.racket-lang.org/pkgn/package/require-latency>`_ package, ``raco pkg install require-latency``.

::

   raco require-latency -f output/main-combined.rkt

Time Loading of the Separated Modules
-------------------------------------

::

   raco require-latency -f output/main-separate.rkt
