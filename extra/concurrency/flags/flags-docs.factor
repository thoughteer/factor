! Copyright (C) 2008 Slava Pestov.
! See http://factorcode.org/license.txt for BSD license.
USING: help.markup help.syntax ;
IN: concurrency.flags

HELP: flag
{ $class-description "A flag allows one thread to notify another when a condition is satisfied." } ;

HELP: <flag>
{ $values { "flag" flag } }
{ $description "Creates a new flag." } ;

HELP: raise-flag
{ $values { "flag" flag } }
{ $description "Raises a flag, notifying any threads waiting on it. Does nothing if the flag has already been raised." } ;

HELP: lower-flag
{ $values { "flag" flag } }
{ $description "Attempts to lower a flag. If the flag has been raised previously, returns immediately, otherwise waits for it to be raised first." } ;

ARTICLE: "concurrency.flags" "Flags"
"A " { $emphasis "flag" } " is a condition notification device which can be in one of two states: " { $emphasis "lowered" } " (the initial state) or " { $emphasis "raised" } "."
$nl
"The flag can be raised at any time; raising a raised flag does nothing. Lowering a flag if the flag has not been raised, it first waits for it to be raised."
$nl
"Essentially, a flag can be thought of as a counting semaphore where the count never goes above one."
{ $subsection flag }
{ $subsection flag? }
"Raising and lowering flags:"
{ $subsection raise-flag }
{ $subsection lower-flag } ;

ABOUT: "concurrency.flags"
