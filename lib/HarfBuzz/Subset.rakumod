unit class HarfBuzz::Subset:ver<0.0.1>;

use HarfBuzz::Face;
use HarfBuzz::Raw;

use HarfBuzz::Subset::Input;
use HarfBuzz::Subset::Raw;

has HarfBuzz::Face $.face;
has HarfBuzz::Subset::Input() $.input handles<drop-tables> .= new;

submethod TWEAK(Str :$file, Blob :$buf, :input($), :face($), |opts) {
    $!face //= $!face.new: :file($_) with $file;
    $!face //= $!face.new: :buf($_) with $buf;
    die "no face given" without $!face;
    $!input.set-options: |opts;
}

method subset-face {
    my hb_face $raw = hb_subset($!face.raw, $!input.raw);
    HarfBuzz::Face.new: :$raw;
}

