# marked

A full-featured markdown parser and compiler, written in javascript.
Built for speed.

## Benchmarks

node v0.4.x

``` bash
$ node test --bench
marked completed in 12071ms.
showdown (reuse converter) completed in 27387ms.
showdown (new converter) completed in 75617ms.
markdown-js completed in 70069ms.
```

node v0.6.x

``` bash
$ node test --bench
marked completed in 6448ms.
marked (gfm) completed in 7357ms.
marked (pedantic) completed in 6092ms.
discount completed in 7314ms.
showdown (reuse converter) completed in 16018ms.
showdown (new converter) completed in 18234ms.
markdown-js completed in 24270ms.
```

__Marked is now faster than Discount, which is written in C.__

:trollface:

:shipit:

:smiley:

- [ ] *un*check
- [x] _chec_k