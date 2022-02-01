use Test;
plan 10;
use HarfBuzz;
use HarfBuzz::Face;
use HarfBuzz::Raw;
use HarfBuzz::Subset;
use HarfBuzz::Subset::Input;
use HarfBuzz::Subset::Raw;
use HarfBuzz::Raw::Defs :&hb-tag-enc, :&hb-tag-dec;
constant Min-HarfBuzz-Version = v3.0.0;

my Version $version;
lives-ok { $version = HarfBuzz.version }, 'got version';
note "HarfBuzz version is $version (bindings {HarfBuzz::Subset.^ver})";

ok($version >= Min-HarfBuzz-Version, "HarfBuzz version is suppported")
    or diag "sorry this version of HarfBuzz is not supported ($version < {Min-HarfBuzz-Version})";

my @unicodes = 'Hello, World!'.ords;
my HarfBuzz::Subset::Input $input .= new: :@unicodes;
ok $input.subroutines;
ok $input.hints;
nok $input.retain-gids;
my $file = "t/fonts/NimbusRoman-Regular.otf";
my HarfBuzz::Face $face .= new: :$file;
my HarfBuzz::Subset $subsetter .= new: :$face, :$input;
$subsetter.drop-tables.add('post');
my @dropped-tables = $subsetter.drop-tables.iterate;
is @dropped-tables.tail, 'post';
my HarfBuzz::Face $subset = $subsetter.subset-face;

is $subset.get-glyph-count, 1 + 'Hello, World!'.ords.unique;

mkdir('tmp');

my Blob() $buf;
lives-ok {$buf = $subset};

$file = 'tmp/01_basic-subset.otf';
$file.IO.spurt: :bin, $buf;

lives-ok { $face .= new: :$file; };

is $subset.get-glyph-count, 1 + 'Hello, World!'.ords.unique;

