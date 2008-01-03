! Copyright (C) 2007, 2008 Slava Pestov.
! See http://factorcode.org/license.txt for BSD license.
USING: compiler cpu.architecture vocabs.loader system sequences
namespaces parser kernel kernel.private classes classes.private
arrays hashtables vectors tuples sbufs inference.dataflow
hashtables.private sequences.private math tuples.private
growable namespaces.private alien.remote-control assocs words
generator command-line vocabs io prettyprint libc definitions ;
IN: bootstrap.compiler

"cpu." cpu append require

"-no-stack-traces" cli-args member? [
    f compiled-stack-traces? set-global
] when

nl
"Compiling some words to speed up bootstrap..." write

! Compile a set of words ahead of the full compile.
! This set of words was determined semi-empirically
! using the profiler. It improves bootstrap time
! significantly, because frequenly called words
! which are also quick to compile are replaced by
! compiled definitions as soon as possible.
{
    roll -roll declare not

    tuple-class-eq? array? hashtable? vector?
    tuple? sbuf? node? tombstone?

    array-capacity array-nth set-array-nth

    wrap probe

    delegate

    underlying

    find-pair-next namestack*

    bitand bitor bitxor bitnot
} compile

"." write flush

{
    + 1+ 1- 2/ < <= > >= shift min
} compile

"." write flush

{
    new nth push pop peek
} compile

"." write flush

{
    hashcode* = get set
} compile

"." write flush

{
    . lines
} compile

"." write flush

{
    malloc free memcpy
} compile

[ compiled-usages recompile ] recompile-hook set-global

" done" print flush
