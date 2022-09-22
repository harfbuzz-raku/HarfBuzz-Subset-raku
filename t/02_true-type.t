use Test;
plan 4;
use HarfBuzz::Face;
use HarfBuzz::Subset;

my @unicodes = 'Hello, World!'.ords;
my $file = "t/fonts/Lohit-Devanagari.ttf";
my HarfBuzz::Subset $subsetter .= new: :face{ :$file }, :input{:@unicodes, :drop-tables['post'], :!retain-gids};
my @dropped-tables = $subsetter.drop-tables.iterate;
is @dropped-tables.tail, 'post';
my HarfBuzz::Face $subset = $subsetter.subset-face;

is $subset.get-glyph-count, 1 + 'Hello, World!'.ords.unique;

mkdir('tmp');

$file = 'tmp/02_truetype-subset.ttf';
my Blob $buf;
lives-ok {$buf = $subset.Blob};
$file.IO.open(:w).write: $buf;

is $subset.get-glyph-count, 1 + 'Hello, World!'.ords.unique;

