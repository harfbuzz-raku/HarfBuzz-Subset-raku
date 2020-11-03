unit class HarfBuzz::Subset:ver<0.0.1>;

use HarfBuzz::Face;
use HarfBuzz::Raw;

use HarfBuzz::Subset::Input;
use HarfBuzz::Subset::Raw;

has HarfBuzz::Face:D $.face is required;
has HarfBuzz::Subset::Input:D $.input is required;

method CALL-ME() {
    my hb_face $raw = hb_subset($!face.raw, $!input.raw);
    HarfBuzz::Face.new: :$raw;
}
