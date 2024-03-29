unit class HarfBuzz::Subset:ver<0.0.5>;

use HarfBuzz::Face;
use HarfBuzz::Raw;

use HarfBuzz::Subset::Input;
use HarfBuzz::Subset::Raw;

has HarfBuzz::Face() $.face;
has HarfBuzz::Subset::Input() $.input handles<drop-tables> .= new;

method subset-face handles<Blob> {
    my hb_face $raw = hb_subset_or_fail($!face.raw, $!input.raw);
    HarfBuzz::Face.new: :$raw;
}

