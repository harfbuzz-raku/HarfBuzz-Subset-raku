use Test;
plan 1;
use HarfBuzz::Face;
use HarfBuzz::Raw;
use HarfBuzz::Subset;
use HarfBuzz::Subset::Input;
use HarfBuzz::Subset::Raw;

my hb_subset_input $raw .= new;

my hb_set $unicode = $raw.unicode;

$unicode.add($_) for 'Hello, World!'.ords;

my HarfBuzz::Subset::Input $input .= new: :$raw;

my $file = "t/fonts/NimbusRoman-Regular.otf";

my HarfBuzz::Face $face .= new: :$file;

my HarfBuzz::Subset $subsetter .= new: :$face, :$input;

my HarfBuzz::Face $subset = $subsetter();

is $subset.get-glyph-count, 1 + 'Hello, World!'.ords.unique;

