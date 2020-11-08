unit class HarfBuzz::Subset::Tables
    does Iterable;

use HarfBuzz::Raw;
use HarfBuzz::Raw::Defs :types, :&hb-tag-enc, :&hb-tag-dec, :hb-set-value;
use Method::Also;

has $.subset is required;
has hb_set:D $.raw is required;

method add(Str:D $tag) {
    $!raw.add: hb-tag-enc($tag);
}

method remove(Str:D $tag) {
    $!raw.del: hb-tag-enc($tag);
}

method iterate {
    class Iteration does Iterable does Iterator {
        has $.subset is required;
        has hb_set:D $.raw is required;
        has hb_codepoint $.enc = HB_SET_VALUE_INVALID;
        method iterator { self }
        method pull-one {
            if $!raw.next($!enc) {
                hb-tag-dec($!enc);
            }
            else {
                IterationEnd;
            }
        }
    }
    Iteration.new: :$!subset, :$!raw;
}
