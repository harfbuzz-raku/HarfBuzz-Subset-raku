use Test;
plan 5;
use HarfBuzz::Face;
use HarfBuzz::Raw;
use HarfBuzz::Subset;
use HarfBuzz::Subset::Input;
use HarfBuzz::Subset::Raw;
use HarfBuzz::Raw::Defs :&hb-tag-enc, :&hb-tag-dec;

my @unicodes = 'Hello, World!'.ords;
my HarfBuzz::Subset::Input $input .= new: :@unicodes;
my $file = "t/fonts/Lohit-Devanagari.ttf";
my HarfBuzz::Face $face .= new: :$file;
my HarfBuzz::Subset $subsetter .= new: :$face, :$input, :drop-tables['post'], :!retain-gids;
my @dropped-tables = $subsetter.drop-tables.iterate;
is @dropped-tables.tail, 'post';
my HarfBuzz::Face $subset = $subsetter.subset-face;

is $subset.get-glyph-count, 1 + 'Hello, World!'.ords.unique;

mkdir('tmp');

$file = 'tmp/02_truetype-subset.ttf';
my Blob $buf;
lives-ok {$buf = $subset.Blob};
$file.IO.open(:w).write: $buf;

lives-ok { $face .= new: :$file; };

is $subset.get-glyph-count, 1 + 'Hello, World!'.ords.unique;

