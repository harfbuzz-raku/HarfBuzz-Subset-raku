HarfBuzz-Subset-raku
=============

Description
-----
Bindings to the HarfBuzz Subset font subsetting library.

This module is classed as *Experimental*, just because the `harfbuzz-subset` library is not commonly packaged yet, and needs to be built from source.

Synopsis
-----

```raku
use HarfBuzz::Subset;

# face to be subsetted
my $file = "t/fonts/NimbusRoman-Regular.otf";

my @unicodes = 'Hello, World!'.ords;
my HarfBuzz::Subset $subset .= new: :face{ :$file }, :input{ :@unicodes };
my Blob() $buf = $subset;
'/tmp/my-nimbus-subset.otf'.IO.spurt: :bin, $buf;
```

Description
----
This module binds to the HarfBuzz library's subsetting capability and allows a font to be compacted to a smaller set of glyphs.

Subsetting is useful in a number of domains, including

- embedded PDF fonts, and
- fast loading Web-Fonts (you'll need additional external tools to then package as WOFF or EOT format).

HarfBuzz::Subset Methods
----

### new

   method new(
       HarfBuzz::Font() :$font!,
       HarfBuzz::Subset::Input :$input()
   ) returns HarfBuzz::Subset:D;

- `:$font` is either a HarfBuzz::Font object or a hash of coercable options.
- `:$input` is either a HarfBuzz::Subset::Input object or a hash of coerceable options.

### Blob

The subsetted font. This can be saved to a file with the same extension as the input font (typically `.ttf` or `.otf`) or embedded somehow (for example in a PDF file).

HarfBuzz::Subset::Input Methods

### new

    method new(
        UInt :@unicodes,      # unicode code-points
        UInt :@glyphs,        # glyph identifiers
        Str  :@drop-tables,   # additional SFnt tables to drop
        Bool :$hints=True,    # retain font hinting
        Bool :$retain-gids,   # retain glyph identifiers
        Bool :$subroutines=True,
    ) returns HarfBuzz::Subset::Input:D;

See tests for examples

### Blob

Produces a binary image of the subsetted font. This will havve the
same format as the inout font (OpenType or TrueType).

Installation
----
As of late 2020, HarfBuzz's font subsetting capability is not commonly packaged yet and you'll mostly likely need to build HarfBuzz from source.

The HarfBuzz font shaping and subsetting libraries can be downloaded and built from https://github.com/harfbuzz/harfbuzz.


