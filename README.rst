Generate Code
-------------

::

   $ ./filecreator.rkt 10
   $ raco make output/*.rkt

Time Loading of the Combined Module
-----------------------------------

You will need the `require-latency <https://pkgd.racket-lang.org/pkgn/package/require-latency>`_ package, ``raco pkg install require-latency``.

::

   $ raco require-latency -f output/main-combined.rkt

Time Loading of the Separated Modules
-------------------------------------

::

   $ raco require-latency -f output/main-separate.rkt

Tools
-----

Try setting the ``PLT_LINKLET_SHOW_CP0`` environment variable to see the output at different stages of compilation of any module. This helps us verify that the code we intend to be present in the final result is not optimized away.

::

   $ export plt_linklet_show_cp0=1
   $ cd output
   $ rm compiled/mod0*  # delete the existing compiled output just to make sure
   $ racket mod0.rkt

Unset it using:

::

   $ unset plt_linklet_show_cp0

You could also verify the size of the compiled modules using, for instance:

::

   $ ls -alh output/compiled/mod4_rkt.zo
